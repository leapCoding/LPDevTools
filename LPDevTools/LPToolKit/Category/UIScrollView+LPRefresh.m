//
//  UIScrollView+LPRefresh.m
//  LPDevTools
//
//  Created by 李鹏 on 2017/7/12.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import "UIScrollView+LPRefresh.h"
#import <objc/runtime.h>
#import "LPApiManager.h"
#import "UIScrollView+LPEmptyDataSet.h"
#import "MJRefresh.h"
#import "LPCommonMacro.h"
#import "UIView+LPTools.h"

static char const *const kPageKey = "pageKey";
static char const *const kPageSizeKey = "kPageSizeKey";

@implementation UIScrollView (LPRefresh)

- (NSNumber *)page_{
    NSNumber *page__ = objc_getAssociatedObject(self, kPageKey);
    if (page__ == nil) {
        page__ = @(1);
    }
    return page__;
}

- (void)setPage_:(NSNumber *)page_{
    objc_setAssociatedObject(self, kPageKey, page_, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)pageSize_{
    NSNumber *pageSize__ = objc_getAssociatedObject(self, kPageSizeKey);
    if (pageSize__ == nil) {
        pageSize__ = @(10);
    }
    return pageSize__;
}

- (void)setPageSize_:(NSNumber *)pageSize_{
    objc_setAssociatedObject(self, kPageKey, pageSize_, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)lp_setupRefresh:(NSMutableArray *)datas showFooter:(BOOL)showFooter defaultEmptyTitle:(NSString *)emptyTitle fetchResultsWithPage:(void (^)(NSInteger page, ResponseBlock block))fetch {
    if ([self isKindOfClass:[UITableView class]]){
        UITableView *tableView = (UITableView *)self;
        
        @LPWeakObj(self);
        
        if (datas == nil) {
            datas = [NSMutableArray array];
        }
        
        [tableView lp_setupEmptyDataSet:emptyTitle emptyImage:nil tapBlock:^{
            @LPStrongObj(self);
            //            [self ]
        }];
        
        ResponseBlock block = ^(LPNetWorkResponse *response) {
            @LPStrongObj(self);
            [self lp_endRefreshing];
            
            if (self.page_.integerValue == 1) {
                [datas removeAllObjects];
                [self.mj_footer resetNoMoreData];
            }
            
            self.emptyTitle = [response isSuccess] ? emptyTitle : response.message;
            
            NSArray *result = response.result;
            if (result == nil || ![result isKindOfClass:[NSArray class]]) {
                if (self.page_.integerValue > 1) {
                    self.page_ = @(self.page_.integerValue - 1);
                }
                [(UITableView *)self reloadData];
                return ;
            }
            
            if (result.count == 0 || result.count < self.pageSize_.integerValue) {
                [self.mj_footer endRefreshingWithNoMoreData];
            }
            
            [datas addObjectsFromArray:result];
            
            [(UITableView *)self reloadData];
            
            self.mj_footer.hidden = (self.mj_footer.state == MJRefreshStateNoMoreData && self.contentSize.height <= self.height);
        };
        
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
            @LPStrongObj(self);
            self.page_ = @(1);
            self.mj_footer.hidden = YES;
            if (fetch) {
                fetch(self.page_.integerValue, block);
            }
        }];
        tableView.mj_header = header;
        
        if (showFooter) {
            MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                @LPStrongObj(self);
                self.page_ = @(self.page_.integerValue+1);
                if (fetch) {
                    fetch(self.page_.integerValue, block);
                }
            }];
            
            tableView.mj_footer = footer;
            self.mj_footer.hidden = YES;
        }
    }
    
}

- (void)lp_beginRefreshing {
    [self.mj_header beginRefreshing];
}

- (void)lp_endRefreshing {
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}


@end

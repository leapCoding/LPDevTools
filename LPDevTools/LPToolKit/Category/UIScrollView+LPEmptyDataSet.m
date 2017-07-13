//
//  UIScrollView+LPEmptyDataSet.m
//  LPDevTools
//
//  Created by 李鹏 on 2017/7/12.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import "UIScrollView+LPEmptyDataSet.h"
#import <objc/runtime.h>
#import "UIScrollView+EmptyDataSet.h"
#import "UIColor+LPTools.h"

static char const *const kEmptyTitle = "emptyTitle";
static char const *const kEmptyImage = "emptyImage";
static char const *const kEmptyTapBlock = "tapBlock";

@interface UIScrollView ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong) UIImage *emptyImage;
@property (nonatomic, copy) VoidBlock tapBlock;

@end

@implementation UIScrollView (LPEmptyDataSet)

- (NSString *)emptyTitle{
    return objc_getAssociatedObject(self, kEmptyTitle);
}

- (NSString *)emptyImage{
    return objc_getAssociatedObject(self, kEmptyImage);
}

- (VoidBlock)tapBlock{
    return objc_getAssociatedObject(self, kEmptyTapBlock);
}

- (void)lp_setupEmptyDataSet{
    self.emptyDataSetSource = self;
    self.emptyDataSetDelegate = self;
}

- (void)lp_setupEmptyDataSet:(NSString *)title emptyImage:(UIImage *)image tapBlock:(VoidBlock)tapBlock{
    self.emptyTitle = title;
    self.emptyImage = image;
    self.tapBlock = tapBlock;
    [self lp_setupEmptyDataSet];
}

- (void)lp_setupEmptyDataSet:(NSString *)title{
    self.emptyTitle = title;;
    [self lp_setupEmptyDataSet];
}

- (void)setEmptyTitle:(NSString *)emptyTitle{
    if (emptyTitle == nil) {
        return;
    }
    objc_setAssociatedObject(self, kEmptyTitle, emptyTitle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self reloadEmptyDataSet];
}

- (void)setEmptyImage:(UIImage *)emptyImage{
    if (!emptyImage) {
        return;
    }
    objc_setAssociatedObject(self, kEmptyImage, emptyImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self reloadEmptyDataSet];
}

- (void)setTapBlock:(VoidBlock)tapBlock{
    if (!tapBlock) {
        return;
    }
    objc_setAssociatedObject(self, kEmptyTapBlock, tapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    UIImage *image = self.emptyImage;
    return image ? image : [UIImage imageNamed:@""];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = self.emptyTitle == nil ? @"暂无内容" : self.emptyTitle;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor colorWithHexString:@"999999"]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

//- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
//    return -30;
//}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view{
    if (self.tapBlock) {
        self.tapBlock();
    }
}


@end

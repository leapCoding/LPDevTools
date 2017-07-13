//
//  UIScrollView+LPEmptyDataSet.h
//  LPDevTools
//
//  Created by 李鹏 on 2017/7/12.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^VoidBlock)(void);

@interface UIScrollView (LPEmptyDataSet)

@property (nonatomic, copy) NSString *emptyTitle;

/** 默认空视图 */
- (void)lp_setupEmptyDataSet;

- (void)lp_setupEmptyDataSet:(NSString *)title emptyImage:(UIImage *)image tapBlock:(VoidBlock)tapBlock;

- (void)lp_setupEmptyDataSet:(NSString *)title;

@end

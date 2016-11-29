//
//  UIViewController+Category.h
//  LPCoding
//
//  Created by lipeng on 16/4/14.
//  Copyright © 2016年 leap. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Category)

+ (UIViewController*)topViewController;
+ (UINavigationController *)navController;

- (void)showLoadHUD;

- (void)showLoadHUDTitle:(NSString *)string;

- (void)showTip:(NSString *)string;

- (void)hideHUD;

@end

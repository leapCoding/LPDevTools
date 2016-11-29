//
//  UIViewController+Category.m
//  LPCoding
//
//  Created by lipeng on 16/4/14.
//  Copyright © 2016年 leap. All rights reserved.
//

#import "UIViewController+Category.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
//#import "AFCTabBarController.h"

@implementation UIViewController (Category)

+ (UIViewController*)topViewController {
    return [self topViewControllerWithRootViewController:[(AppDelegate *)[[UIApplication sharedApplication] delegate] window].rootViewController];
}

+ (UINavigationController *)navController {
    UITabBarController *tab = (UITabBarController*)[(AppDelegate *)[[UIApplication sharedApplication] delegate] window].rootViewController;
    UINavigationController *nav = (UINavigationController *)tab.selectedViewController;
    return nav;
}

+ (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

- (void)showLoadHUD {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)showLoadHUDTitle:(NSString *)string {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // Set the label text.
    hud.labelText = string;
}

- (void)showTip:(NSString *)string {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // Set the annular determinate mode to show task progress.
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = string;
    [hud hide:YES afterDelay:2.f];
}

- (void)hideHUD {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end

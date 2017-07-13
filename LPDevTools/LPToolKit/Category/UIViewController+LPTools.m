//
//  UIViewController+LPTools.m
//  WYJCore
//
//  Created by 李鹏 on 2017/7/11.
//  Copyright © 2017年 WYJ. All rights reserved.
//

#import "UIViewController+LPTools.h"

@implementation UIViewController (LPTools)

+ (UIViewController*)topViewController {
    return [self topViewControllerWithRootViewController:[[[UIApplication sharedApplication] delegate] window].rootViewController];
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


@end

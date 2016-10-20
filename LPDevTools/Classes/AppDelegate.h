//
//  AppDelegate.h
//  LPDevTools
//
//  Created by lipeng on 16/10/19.
//  Copyright © 2016年 lpdev.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LPTabBarController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LPTabBarController *tabBarController;

@end


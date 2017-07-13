//
//  LPAPPConfig.m
//  WYJCore
//
//  Created by 李鹏 on 2017/7/11.
//  Copyright © 2017年 WYJ. All rights reserved.
//

#import "LPAPPConfig.h"
#import "UIApplication+LPTools.h"
#import "UIColor+LPTools.h"
#import "UIImage+LPTools.h"

#import "LPVersionManager.h"
#import "LPPushManager.h"
#import "LPPayManager.h"
#import "LPShareManager.h"

@interface LPAPPConfig ()

@end

@implementation LPAPPConfig

+ (instancetype)sharedInstance{
    static LPAPPConfig *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    
    return instance;
}

//app启动配置
- (void)start {
    
    //第一次安装使用
    [LPAPPConfig configFirstLaunch];
    
    //版本检测提示
    [[LPVersionManager shareManager] start];
    
    //推送
    [[LPPushManager shareManager]setupWithOptions:[LPAPPConfig sharedInstance].launchOptions];

    //支付
    [[LPPayManager shareManager]lp_registerApp];

    //分享
    [[LPShareManager shareManager]lp_registerApp];
    
    //导航主题设置
    [self customizeInterface];
    
}

- (void)customizeInterface {
    //    //状态栏颜色
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //设置Nav的背景色和title色
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    [navigationBarAppearance setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setShadowImage:[UIImage imageWithColor:[UIColor redColor]]];
    [navigationBarAppearance setTintColor:[UIColor whiteColor]];//返回按钮的箭头颜色
    NSDictionary *textAttributes = @{
                                     NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                                     NSForegroundColorAttributeName: [UIColor colorWithHexString:@"222222"],
                                     };
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}


+ (NSString *)everLaunchKey {
    return [NSString stringWithFormat:@"%@_%@",appEverLaunchedKey, [UIApplication sharedApplication].appBundleID];
}

+ (NSString *)firstLaunchKey {
    return [NSString stringWithFormat:@"%@_%@",appFirstLaunchKey, [UIApplication sharedApplication].appBundleID];
}

+ (NSString *)firstUpdateKey {
    return [NSString stringWithFormat:@"%@_%@",appFirstUpdateKey, [UIApplication sharedApplication].appVersion];
}

+ (void)configFirstLaunch {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:[self everLaunchKey]]) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:[self firstLaunchKey]];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:[self firstUpdateKey]];
    }else{
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[self everLaunchKey]];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[self firstLaunchKey]];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[self firstUpdateKey]];
    }
}


@end

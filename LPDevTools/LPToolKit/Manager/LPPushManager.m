//
//  LPPushManager.m
//  LPDevTools
//
//  Created by 李鹏 on 2017/7/12.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import "LPPushManager.h"
#import "LPAPPKeyConfig.h"
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface LPPushManager ()<JPUSHRegisterDelegate>

@end

@implementation LPPushManager

+ (instancetype)shareManager {
    static LPPushManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (void)setupWithOptions:(NSDictionary *)launchOptions {
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound;
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    [JPUSHService setupWithOption:launchOptions appKey:[LPAPPKeyConfig sharedInstance].jpushKey
                          channel:[LPAPPKeyConfig sharedInstance].jpushChannel
                 apsForProduction:[LPAPPKeyConfig sharedInstance].jpushForProduct];
}

+ (void)registerDeviceToken:(NSData *)deviceToken {
    [JPUSHService registerDeviceToken:deviceToken];
}

//推送通知处理
- (void)handleRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
    
    
    [self setBadge:0];
}

#pragma mark JPUSHRegisterDelegate
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger options))completionHandler
{
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [self handleRemoteNotification:userInfo];
    }
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        
    }
    completionHandler(UNNotificationPresentationOptionSound); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
    
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler
{
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [self handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert);  // 系统要求执行这个方法
}

//设置角标
- (void)setBadge:(int)badge
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badge];
    [JPUSHService setBadge:badge];
}

- (void)setTagsAlias{
//    NSString *memberId = nil;
//    if ([WYJUser isLogin]) {
//        memberId = [NSString stringWithFormat:@"%@",@([WYJUser curLoginUser].memberId)];
//    }else {
//        memberId = @"";
//    }
//    @WYJWeakObj(self);
//    [JPUSHService setTags:[NSSet setWithObjects:@"", nil] alias:memberId fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
//        @WYJStrongObj(self);
//        if (iResCode != 0) {
//            [self setTagsAlias];
//        }else{
//            ASLog(@"推送设置别名回调:%d,alias:%@", iResCode, iAlias);
//        }
//    }];
}

// log NSSet with UTF8
// if not ,log will be \Uxxx
+ (NSString *)logSet:(NSSet *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}


@end

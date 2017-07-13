//
//  LPShareManager.h
//  LPDevTools
//
//  Created by 李鹏 on 2017/7/12.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,SharePlatformType) {
    SharePlatformType_WechatSession = 0,//微信好友
    SharePlatformType_WechatTimeLine = 1,//朋友圈
    SharePlatformType_Sina = 2,//新浪
    SharePlatformType_QQ = 3,//QQ好友
};

@interface LPShareManager : NSObject

/**
 *  单例管理
 */
+ (instancetype)shareManager;

- (void)lp_registerApp;

- (BOOL)lp_handleOpenURL:(NSURL *)url;

- (BOOL)lp_openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options;

- (BOOL)lp_openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

- (void)shareToPlatformType:(SharePlatformType)platformType;

@end

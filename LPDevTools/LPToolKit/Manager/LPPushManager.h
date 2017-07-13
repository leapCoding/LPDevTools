//
//  LPPushManager.h
//  LPDevTools
//
//  Created by 李鹏 on 2017/7/12.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPPushManager : NSObject

+ (instancetype)shareManager;
// 在应用启动的时候调用
- (void)setupWithOptions:(NSDictionary *)launchOptions;

// 在appdelegate注册设备处调用
+ (void)registerDeviceToken:(NSData *)deviceToken;

- (void)handleRemoteNotification:(NSDictionary *)userInfo;

- (void)setTagsAlias;


@end

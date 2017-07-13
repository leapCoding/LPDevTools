//
//  LPAPPConfig.h
//  WYJCore
//
//  Created by 李鹏 on 2017/7/11.
//  Copyright © 2017年 WYJ. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  App是否已经启动过
 */
static NSString * const appEverLaunchedKey = @"appEverLaunchedKey";
/**
 *  App是否第一次启动
 */
static NSString * const appFirstLaunchKey  = @"appFirstLaunchKey";
/**
 *  App是否第一次更新提示
 */
static NSString * const appFirstUpdateKey  = @"appFirstUpdateKey";


@interface LPAPPConfig : NSObject

@property (nonatomic, strong) NSDictionary *launchOptions;

+ (instancetype)sharedInstance;

- (void)start;

+ (NSString *)everLaunchKey;

+ (NSString *)firstLaunchKey;

+ (NSString *)firstUpdateKey;

@end

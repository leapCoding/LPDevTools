//
//  UIDevice+LPTools.h
//  WYJCore
//
//  Created by 李鹏 on 2017/7/11.
//  Copyright © 2017年 WYJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (LPTools)

/**
 * 模拟器判断
 */
+ (BOOL)isSimulator;

/**
 * 系统版本
 */
+ (double)systemVersion;

+ (NSString *)iphoneType;

/**
 * 程序外调用电话 直接拨打不给提示
 */
+ (void)callPhone:(NSString *)phone;

/**
 * 程序内调用电话
 */
+ (void)callPhone:(NSString *)phone view:(UIView *)view;

/**
 * 获取手机IP地址
 */
+ (NSString *)getIPAddress:(BOOL)preferIPv4;

@end

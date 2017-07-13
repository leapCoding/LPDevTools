//
//  NSString+LPTools.h
//  WYJCore
//
//  Created by 李鹏 on 2017/6/22.
//  Copyright © 2017年 WYJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LPTools)

/**
 * 字符为空判断
 */
+ (BOOL)isEmpty:(NSString *)str;

/**
 * 密码匹配6-18位数字或字母
 */
+ (BOOL)checkPassword:(NSString *)str;

/**
 * 密码匹配6-18位数字和字母组合
 */
+ (BOOL)checkPasswordMix:(NSString *)str;

/**
 * 用户名匹配1-20位字母或中文组合
 */
+ (BOOL)checkUserName:(NSString *)str;

/**
 * 用户身份证号15或18位
 */
+ (BOOL)checkUserIdCard:(NSString *)str;

/**
 * 手机号匹配
 */
+ (BOOL)checkTelNumber:(NSString *)str;

/**
 * 邮箱地址验证
 */
+ (BOOL)checkEmailAddress:(NSString *)str;

/**
 * 车牌号验证
 */
+ (BOOL)checkCarNumber:(NSString *)str;

/**
 * 格式化手机号xxx-xxxx-xxxx
 */
+ (NSString *)formatPhone:(NSString *)phone;

/**
 * 去除字符串中html标签
 */
+ (NSString *)filterHtml:(NSString *)html;

/**
 * md5加密
 */
- (NSString *)md5String;

/**
 * base64Encoded
 */
- (NSString *)base64EncodedString;

/**
 * base64Decoded
 */
- (NSString *)base64DecodedString;

@end

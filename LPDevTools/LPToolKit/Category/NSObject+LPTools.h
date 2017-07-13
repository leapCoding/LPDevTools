//
//  NSObject+LPTools.h
//  WYJCore
//
//  Created by 李鹏 on 2017/7/5.
//  Copyright © 2017年 WYJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LPTools)

/**
 *  对系统方法进行替换
 *
 *  @param originalSelector 被替换的方法
 *  @param swizzledSelector 实际使用的方法
 *  @param error            替换过程中出现的错误，如果没有错误则为nil
 *
 *  @return 是否替换成功
 */
+ (BOOL)swizzleMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector error:(NSError **)error;

+ (NSString *)className;

- (NSString *)className;

/**
 *  @brief  异步执行代码块
 *
 *  @param block 代码块
 */
- (void)performAsynchronous:(void(^)(void))block;
/**
 *  @brief  GCD主线程执行代码块
 *
 *  @param block 代码块
 *  @param wait  是否同步请求
 */
- (void)performOnMainThread:(void(^)(void))block wait:(BOOL)wait;

/**
 *  @brief  延迟执行代码块
 *
 *  @param seconds 延迟时间 秒
 *  @param block   代码块
 */
- (void)performAfter:(NSTimeInterval)seconds block:(void(^)(void))block;

+ (id)changeType:(id)myObj;

@end

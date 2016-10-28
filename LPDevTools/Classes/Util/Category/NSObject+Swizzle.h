//
//  NSObject+Swizzle.h
//  LPDevTools
//
//  Created by lipeng on 16/10/28.
//  Copyright © 2016年 lpdev.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzle)

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

@end

//
//  NSArray+SafeAccess.h
//  LPDevTools
//
//  Created by lipeng on 16/10/27.
//  Copyright © 2016年 lpdev.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (SafeAccess)

/**
 *  @brief 判断是否为空
 */
- (BOOL)isNotEmpty;

- (BOOL)isContainsString:(NSString *)string;

- (NSArray *)reverseArray;

@end

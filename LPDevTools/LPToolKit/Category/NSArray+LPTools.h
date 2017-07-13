//
//  NSArray+LPTools.h
//  WYJCore
//
//  Created by 李鹏 on 2017/7/11.
//  Copyright © 2017年 WYJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (LPTools)

- (BOOL)isNotEmpty;

- (BOOL)isContainsString:(NSString *)string;

- (NSArray *)reverseArray;

@end

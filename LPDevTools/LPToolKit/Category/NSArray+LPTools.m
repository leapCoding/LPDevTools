//
//  NSArray+LPTools.m
//  WYJCore
//
//  Created by 李鹏 on 2017/7/11.
//  Copyright © 2017年 WYJ. All rights reserved.
//

#import "NSArray+LPTools.h"

@implementation NSArray (LPTools)

/**
 *  @brief 判断是否为空
 */
- (BOOL)isNotEmpty
{
    return (![(NSNull *)self isEqual:[NSNull null]]
            && [self isKindOfClass:[NSArray class]]
            && self.count > 0);
}

- (BOOL)isContainsString:(NSString *)string {
    for (NSString *element in self) {
        if ([element isKindOfClass:[NSString class]] && [element isEqualToString:string]) {
            return true;
        }
    }
    return false;
}

- (NSArray *)reverseArray {
    NSMutableArray *arrayTemp = [NSMutableArray arrayWithCapacity:[self count]];
    NSEnumerator *enumerator = [self reverseObjectEnumerator];
    
    for (id element in enumerator) {
        [arrayTemp addObject:element];
    }
    
    return arrayTemp;
}

@end

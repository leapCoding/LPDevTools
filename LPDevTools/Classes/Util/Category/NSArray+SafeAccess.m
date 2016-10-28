//
//  NSArray+SafeAccess.m
//  LPDevTools
//
//  Created by lipeng on 16/10/27.
//  Copyright © 2016年 lpdev.com. All rights reserved.
//

#import "NSArray+SafeAccess.h"
#import "Aspects.h"

@implementation NSArray (SafeAccess)

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

- (id)lp_objectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        return [self lp_objectAtIndex:index];
    }
    
    return nil;
}

@end

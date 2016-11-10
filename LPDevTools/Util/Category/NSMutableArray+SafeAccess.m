//
//  NSMutableArray+SafeAccess.m
//  LPDevTools
//
//  Created by lipeng on 16/10/28.
//  Copyright © 2016年 lpdev.com. All rights reserved.
//

#import "NSMutableArray+SafeAccess.h"

@implementation NSMutableArray (SafeAccess)

- (id)lp_objectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        return [self lp_objectAtIndex:index];
    }
    
    return nil;
}

- (void)lp_addObject:(id)anObject {
    if (anObject != nil && [anObject isKindOfClass:[NSNull class]] == NO) {
        [self lp_addObject:anObject];
    }
}

- (void)lp_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (index <= self.count && anObject != nil && [anObject isKindOfClass:[NSNull class]] == NO) {
        [self lp_insertObject:anObject atIndex:index];
    }
}

- (void)lp_removeObjectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        [self lp_removeObjectAtIndex:index];
    }
}

- (void)lp_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (index < self.count && anObject != nil && [anObject isKindOfClass:[NSNull class]] == NO) {
        [self lp_replaceObjectAtIndex:index withObject:anObject];
    }
}

@end

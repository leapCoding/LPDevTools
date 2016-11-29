//
//  NSUserDefaults+LPCategory.m
//  LPTools
//
//  Created by lipeng on 16/8/24.
//  Copyright © 2016年 lpdev.com. All rights reserved.
//

#import "NSUserDefaults+LPCategory.h"
#import "NSObject+Swizzle.h"

@implementation NSUserDefaults (LPCategory)

- (BOOL)setSafeObject:(id)value forKey:(NSString *)key {
    if (key == nil) {
        return NO;
    }
    
    if (value == nil || [value isKindOfClass:[NSNull class]]) {
        [self removeObjectForKey:key];
        
        return YES;
    }
    
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        [self setObject:value forKey:key];
        [self synchronize];
        return YES;
    } else {
        id result = [NSObject changeType:value];
        if (result) {
            [self setObject:result forKey:key];
            [self synchronize];
            
            return YES;
        }
    }
    
    return NO;
}

@end

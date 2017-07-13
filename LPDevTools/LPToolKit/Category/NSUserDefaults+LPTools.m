//
//  NSUserDefaults+LPTools.m
//  WYJCore
//
//  Created by 李鹏 on 2017/7/11.
//  Copyright © 2017年 WYJ. All rights reserved.
//

#import "NSUserDefaults+LPTools.h"
#import "NSObject+LPTools.h"

@implementation NSUserDefaults (LPTools)

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

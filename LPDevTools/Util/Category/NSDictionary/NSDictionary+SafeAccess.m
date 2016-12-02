//
//  NSDictionary+SafeAccess.m
//  LPDevTools
//
//  Created by lipeng on 16/11/23.
//  Copyright © 2016年 lpdev.com. All rights reserved.
//

#import "NSDictionary+SafeAccess.h"

@implementation NSDictionary (SafeAccess)

- (BOOL)isNotEmpty
{
    return (![(NSNull *)self isEqual:[NSNull null]]
            && [self isKindOfClass:[NSDictionary class]]
            && self.count > 0);
}

- (NSString *)stringForKey:(id)key
{
    id object = [self objectForKey:key];
    if (object == nil || [object isKindOfClass:[NSNull class]]) {
        return @"";
    } else if ([object isKindOfClass:[NSString class]]) {
        return object;
    } else if ([object isKindOfClass:[NSNumber class]]) {
        return [object stringValue];
    }
    return @"";
}

@end

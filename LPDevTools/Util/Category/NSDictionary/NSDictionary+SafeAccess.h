//
//  NSDictionary+SafeAccess.h
//  LPDevTools
//
//  Created by lipeng on 16/11/23.
//  Copyright © 2016年 lpdev.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SafeAccess)

- (BOOL)isNotEmpty;

- (NSString *)stringForKey:(id)key;

@end

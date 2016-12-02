//
//  NSDictionary+Block.h
//  LPDevTools
//
//  Created by lipeng on 16/12/2.
//  Copyright © 2016年 lpdev.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Block)

- (void)each:(void (^)(id k, id v))block;

- (void)eachKey:(void (^)(id k))block;

- (void)eachValue:(void (^)(id v))block;

@end

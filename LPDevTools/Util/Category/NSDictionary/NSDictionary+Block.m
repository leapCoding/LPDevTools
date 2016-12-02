//
//  NSDictionary+Block.m
//  LPDevTools
//
//  Created by lipeng on 16/12/2.
//  Copyright © 2016年 lpdev.com. All rights reserved.
//

#import "NSDictionary+Block.h"

@implementation NSDictionary (Block)

- (void)each:(void (^)(id k, id v))block {
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        block(key, obj);
    }];
}

- (void)eachKey:(void (^)(id))block {
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        block(key);
    }];
}

- (void)eachValue:(void (^)(id))block {
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        block(obj);
    }];
}

@end

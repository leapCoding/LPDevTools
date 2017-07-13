//
//  LPAPPKeyConfig.m
//  WYJCore
//
//  Created by 李鹏 on 2017/7/11.
//  Copyright © 2017年 WYJ. All rights reserved.
//

#import "LPAPPKeyConfig.h"

@implementation LPAPPKeyConfig

+ (instancetype)sharedInstance{
    static LPAPPKeyConfig *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _jpushChannel = @"AppStore";
        
#if DEBUG
        _jpushForProduct = NO;
#else
        _jpushForProduct = YES;
#endif
        _umengKey = @"5937d505734be4271a001169";
        _baiduKey = @"Ijca9qml8W62Xdx6a0wK6BClw6BN1GEp";
        _wxKey = @"wxe810f7f93ea047ff";
        _wxSecret = @"dfgdfsg975YY4409555k385422AS9OYB";
        _jpushKey = @"7607aadee5ddb421507c3540";
        _qqId = @"1106144421";
        _sinaKey = @"1006727077";
        _sinaSecret = @"19bc8180d9ef992737ebb43406866ffa";
        _appId = 1248148696;
    }
    return self;
}

- (NSString *)appUrl {
    return [NSString stringWithFormat:@"http://itunes.apple.com/app/id%ld?mt=8", (long)_appId];
}

@end

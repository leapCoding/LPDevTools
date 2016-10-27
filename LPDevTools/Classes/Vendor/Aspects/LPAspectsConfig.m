//
//  LPAspectsConfig.m
//  LPDevTools
//
//  Created by lipeng on 16/10/27.
//  Copyright © 2016年 lpdev.com. All rights reserved.
//

#import "LPAspectsConfig.h"
#import "Aspects.h"

@implementation LPAspectsConfig

+ (void)load {
    [super load];
    [LPAspectsConfig shareInstance];
}

+ (instancetype)shareInstance {
    static LPAspectsConfig *aspectsConfig;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        aspectsConfig = [[LPAspectsConfig alloc]init];
    });
    return aspectsConfig;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [NSArray aspect_hookSelector:@selector(objectAtIndex:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo){
            NSLog(@"----------------%@",[aspectInfo instance]);
        } error:NULL];
    }
    return self;
}



@end

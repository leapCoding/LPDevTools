//
//  NetWorkAspects.m
//  LPDevTools
//
//  Created by lipeng on 16/11/21.
//  Copyright © 2016年 lpdev.com. All rights reserved.
//

#import "NetWorkAspects.h"
#import "Aspects.h"

@implementation NetWorkAspects

+ (void)load {
    [super load];
}

+ (instancetype)shareInstance {
    static NetWorkAspects *aspectsConfig;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        aspectsConfig = [[NetWorkAspects alloc]init];
    });
    return aspectsConfig;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        SEL sel = NSSelectorFromString(@"dealloc");
        [UIViewController aspect_hookSelector:sel withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo>aspectInfo){
            [self dealloc:[aspectInfo instance]];
        } error:NULL];
    }
    return self;
}

- (void)dealloc:(UIViewController *)viewController{
    DebugLog(@"%@", NSStringFromClass([viewController class]));
    [NetWorkUrlConfig cancelAllRequest];
}

@end

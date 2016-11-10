//
//  LPAspectsConfig.m
//  LPDevTools
//
//  Created by lipeng on 16/10/27.
//  Copyright © 2016年 lpdev.com. All rights reserved.
//

#import "LPAspectsConfig.h"
#import "Aspects.h"
#import <objc/runtime.h>
#import "NSObject+Swizzle.h"

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
        [UIViewController aspect_hookSelector:@selector(viewDidAppear:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo){
            NSLog(@"---%@--viewDidAppear",[aspectInfo instance]);
        }error:NULL];
        
        //替换NSArray方法
        [objc_getClass("__NSArrayI") swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(lp_objectAtIndex:) error:nil];
        //替换NSMutableArray方法
        [objc_getClass("__NSArrayM") swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(lp_objectAtIndex:) error:nil];
        [objc_getClass("__NSArrayM") swizzleMethod:@selector(addObject:) withMethod:@selector(lp_addObject:) error:nil];
        [objc_getClass("__NSArrayM") swizzleMethod:@selector(insertObject:atIndex:) withMethod:@selector(lp_insertObject:atIndex:) error:nil];
        [objc_getClass("__NSArrayM") swizzleMethod:@selector(removeObjectAtIndex:) withMethod:@selector(lp_removeObjectAtIndex:) error:nil];
        [objc_getClass("__NSArrayM") swizzleMethod:@selector(replaceObjectAtIndex:withObject:) withMethod:@selector(lp_replaceObjectAtIndex:withObject:) error:nil];
    }
    return self;
}



@end

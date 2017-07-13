//
//  LPLocationManager.m
//  LPDevTools
//
//  Created by 李鹏 on 2017/7/12.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import "LPLocationManager.h"

@implementation LPLocationManager

+ (instancetype)shareInstance {
    static LPLocationManager *locationMagager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        locationMagager = [[self alloc]init];
    });
    return locationMagager;
}

@end

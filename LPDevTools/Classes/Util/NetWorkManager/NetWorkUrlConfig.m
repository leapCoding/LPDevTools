//
//  NetWorkUrlConfig.m
//  LPDevTools
//
//  Created by lipeng on 16/11/7.
//  Copyright © 2016年 lpdev.com. All rights reserved.
//

#import "NetWorkUrlConfig.h"

@implementation NetWorkUrlConfig

+ (NSString *)urlString:(NetWorkRequestUrl)url {
    switch (url) {
        case NetWorkRequestUrl_None:
            return @"";
            break;
            
        default:
            break;
    }
}

@end

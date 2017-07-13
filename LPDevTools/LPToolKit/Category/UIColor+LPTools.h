//
//  UIColor+LPTools.h
//  WYJCore
//
//  Created by 李鹏 on 2017/7/5.
//  Copyright © 2017年 WYJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (LPTools)

+ (UIColor *)randomColor;

+ (UIColor *)colorWithRGBHex:(UInt32)hex;

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

@end

//
//  UIColor+LPCategory.m
//  LPTools
//
//  Created by lipeng on 16/7/7.
//  Copyright © 2016年 lpdev.com. All rights reserved.
//

#import "UIColor+LPCategory.h"

@implementation UIColor (LPCategory)

+ (UIColor *)colorWithHex:(int)hexValue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0
                           alpha:alpha];
}

+ (UIColor *)colorWithHex:(int)hexValue
{
    return [UIColor colorWithHex:hexValue alpha:1.0];
}


#pragma mark - theme colors

+ (UIColor *)navigationbarColor
{
    return [UIColor colorWithHex:0x0a5090];
}

+ (UIColor *)uniformColor
{
    return [UIColor colorWithRed:235.0/255 green:235.0/255 blue:243.0/255 alpha:1.0];
}

@end

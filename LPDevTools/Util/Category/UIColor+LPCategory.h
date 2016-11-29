//
//  UIColor+LPCategory.h
//  LPTools
//
//  Created by lipeng on 16/7/7.
//  Copyright © 2016年 lpdev.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (LPCategory)

+ (UIColor *)colorWithHex:(int)hexValue alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHex:(int)hexValue;

+ (UIColor *)navigationbarColor;
+ (UIColor *)uniformColor;

@end

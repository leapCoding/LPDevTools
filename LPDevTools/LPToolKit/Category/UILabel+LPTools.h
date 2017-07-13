//
//  UILabel+LPTools.h
//  WYJCore
//
//  Created by 李鹏 on 2017/7/5.
//  Copyright © 2017年 WYJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LPTools)

/**
 *  计算设置label的行间距后的高度
 */
+ (CGFloat)text:(NSString*)text heightWithFontSize:(CGFloat)fontSize width:(CGFloat)width lineSpacing:(CGFloat)lineSpacing;

/**
 *  设置label的行间距
 */
- (void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing;

@end

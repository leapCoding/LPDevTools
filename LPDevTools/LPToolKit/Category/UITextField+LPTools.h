//
//  UITextField+LPTools.h
//  WYJCore
//
//  Created by 李鹏 on 2017/7/5.
//  Copyright © 2017年 WYJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (LPTools)

- (void)configurePlaceholderColor:(UIColor *)color font:(UIFont *)font;

//字数输入限制
- (void)textFieldWordLimitMaxLength:(NSInteger)length;

//保留两位小数
- (void)textFieldLimitFloat;

@end

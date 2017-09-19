//
//  UITextField+LPTools.m
//  WYJCore
//
//  Created by 李鹏 on 2017/7/5.
//  Copyright © 2017年 WYJ. All rights reserved.
//

#import "UITextField+LPTools.h"

@implementation UITextField (LPTools)

- (void)configurePlaceholderColor:(UIColor *)color font:(UIFont *)font {
    
    if ([self respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName: color,NSFontAttributeName:font}];
    }
}

- (void)textFieldWordLimitMaxLength:(NSInteger)length {
    NSString *toBeString = self.text;
    NSString *lang = [[UIApplication sharedApplication] textInputMode].primaryLanguage;
    if ([lang isEqualToString:@"zh-Hans"]) {// 中文输入
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        if (!position) {// 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (toBeString.length > length) {
                self.text = [toBeString substringToIndex:length];
            }
        }
    }else {
        if (toBeString.length > length) {
            self.text = [toBeString substringToIndex:length];
        }
    }
}

- (void)textFieldLimitFloat {
    if ([self.text rangeOfString:@"."].location != NSNotFound) {
        NSInteger index = [self.text rangeOfString:@"."].location;
        if (index == 0) {
            self.text = @"0.";
        }
        NSArray *array = [self.text componentsSeparatedByString:@"."];
        if (array.count>2) {
            self.text = [self.text substringToIndex:self.text.length-1];
        }
        if (self.text.length - index > 3) {
            self.text = [self.text substringToIndex:index+3];
        }
    }else {
        if ([self.text hasPrefix:@"0"]&&self.text.length>1) {
            self.text = @"0";
        }
    }
    if ([self.text isEqualToString:@"0.00"]) {
        self.text = @"0";
    }
}

@end

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


@end

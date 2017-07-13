//
//  UIButton+LPTools.m
//  WYJCore
//
//  Created by 李鹏 on 2017/7/5.
//  Copyright © 2017年 WYJ. All rights reserved.
//

#import "UIButton+LPTools.h"
#import "NSTimer+LPTools.h"

@implementation UIButton (LPTools)

- (void)leftTitleAndRightImage {
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    self.imageEdgeInsets = UIEdgeInsetsMake(0, self.imageView.frame.origin.x + titleSize.width + 5, 0, 0);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, 0, 0);
}

- (void)butttonCountDown:(UIButton *)button timeInterval:(NSInteger)time {
    button.enabled = NO;
    NSString *title = button.titleLabel.text;
    __block NSInteger count = time;
    [NSTimer scheduledTimerWithTimeInterval:1 block:^(NSTimer * _Nonnull timer) {
        count--;
        NSString *codeStr = [NSString stringWithFormat:@"%@ %@S",title,@(count)];
        [button setTitle:codeStr forState:UIControlStateNormal];
        if (count == 0) {
            button.enabled = YES;
            [button setTitle:title forState:UIControlStateNormal];
            [timer invalidate];
        }
    } repeats:YES];
}

@end

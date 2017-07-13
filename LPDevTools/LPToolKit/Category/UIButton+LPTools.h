//
//  UIButton+LPTools.h
//  WYJCore
//
//  Created by 李鹏 on 2017/7/5.
//  Copyright © 2017年 WYJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (LPTools)

- (void)leftTitleAndRightImage;

/**
 *  button倒计时显示
 */
- (void)butttonCountDown:(UIButton *)button timeInterval:(NSInteger)time;

@end

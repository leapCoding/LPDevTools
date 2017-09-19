//
//  LPTabBar.m
//  LPDevTools
//
//  Created by 李鹏 on 2017/9/8.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import "LPTabBar.h"

@interface LPTabBar ()

@property (nonatomic, strong) UIButton *customButton;

@end

@implementation LPTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.customButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //设置其他tabbar的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = CGRectGetWidth(self.frame) / 5;
    CGFloat buttonH = CGRectGetHeight(self.frame);
    
    NSInteger index = 0;
    for (UIButton *button in self.subviews) {
        if ([button isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            // 计算按钮的x值
            CGFloat buttonX = buttonW * ((index > 1)?(index + 1):index);
            button.frame = CGRectMake( buttonX, buttonY, buttonW, buttonH);
            index++;
        }
    }
    
    self.customButton.frame = CGRectMake(0, 0, buttonW, buttonH+50);
    self.customButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    
}

- (void)customButtonClicked {
    NSLog(@"buttonClicked");
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (!self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01) {
        return nil;
    }
    /**
     *  此注释掉的方法用来判断点击是否在父View Bounds内，
     *  如果不在父view内，就会直接不会去其子View中寻找HitTestView，return 返回
     */
//        if ([self pointInside:point withEvent:event]) {
    for (UIView *subview in [self.subviews reverseObjectEnumerator]) {
        CGPoint convertedPoint = [subview convertPoint:point fromView:self];
        UIView *hitTestView = [subview hitTest:convertedPoint withEvent:event];
        if (hitTestView) {
            return hitTestView;
        }
    }
//    return self;
//        }
    return nil;
}

- (UIButton *)customButton {
    if (!_customButton) {
        _customButton = [[UIButton alloc]init];
        _customButton.backgroundColor = [UIColor redColor];
        [_customButton addTarget:self action:@selector(customButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _customButton;
}

@end

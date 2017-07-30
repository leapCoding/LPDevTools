//
//  LPtestView.m
//  LPDevTools
//
//  Created by Leap on 2017/7/30.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import "LPtestView.h"

@interface LPtestView ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation LPtestView

- (instancetype)initWithImageUrl:(NSString *)url {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)setUpUI {
    _scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

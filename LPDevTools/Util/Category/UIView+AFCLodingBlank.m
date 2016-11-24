//
//  UIView+AFCLodingBlank.m
//  AFC
//
//  Created by Leap on 16/6/6.
//  Copyright © 2016年 carlyle. All rights reserved.
//

#import "UIView+AFCLodingBlank.h"
#import <objc/runtime.h>

@implementation UIView (AFCLodingBlank)
static char LoadingViewKey,BlankPageViewKey;
- (void)configBlankPage:(AFCBlankPageType)blankPageType hasData:(BOOL)hasData  reloadButtonBlock:(void(^)(id sender))block
{
    [self configBlankPage:blankPageType frame:self.frame hasData:hasData reloadButtonBlock:block];
}

- (void)configBlankPage:(AFCBlankPageType)blankPageType frame:(CGRect)frame hasData:(BOOL)hasData  reloadButtonBlock:(void(^)(id sender))block {
    if([self.loadingView isLoading]){
        [self.loadingView stopAnimating];
    }
    
    if (hasData) {
        if (self.blankPageView)
        {
            self.blankPageView.hidden = YES;
            [self.blankPageView removeFromSuperview];
        }
    }
    else
    {
        if (!self.blankPageView)
        {
            self.blankPageView = [[AFCBlankPageView alloc] initWithFrame:frame];
        }
        self.blankPageView.hidden = NO;
        [self.blankPageContainer addSubview:self.blankPageView];
        
        [self.blankPageView configWithType:blankPageType hasData:NO reloadButtonBlock:block];
        
    }
}

#pragma mark   LoadingView  Runtime 动态绑定
- (void)setLoadingView:(AFCLoadingView *)loadingView
{
    [self willChangeValueForKey:@"LoadingViewKey"];
    objc_setAssociatedObject(self, &LoadingViewKey,
                             loadingView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"LoadingViewKey"];
    
}


- (AFCLoadingView *)loadingView{
    return objc_getAssociatedObject(self, &LoadingViewKey);
}
#pragma mark   LoadingView  Runtime 动态绑定
- (void)setBlankPageView:(AFCBlankPageView *)pageView
{
    [self willChangeValueForKey:@"BlankPageViewKey"];
    objc_setAssociatedObject(self, &BlankPageViewKey,
                             pageView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"BlankPageViewKey"];
    
}
- (AFCBlankPageView *)blankPageView{
    return objc_getAssociatedObject(self, &BlankPageViewKey);
}
- (void)beginLoading{
    for (UIView *aView in [self.blankPageContainer subviews])
    {
        if ([aView isKindOfClass:[AFCBlankPageView class]] && !aView.hidden)
        {
            return;
        }
    }
    
    if (!self.loadingView) { //初始化LoadingView
        self.loadingView = [[AFCLoadingView alloc] initWithFrame:self.bounds];
    }
    [self addSubview:self.loadingView];
    
    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.self.edges.equalTo(self);
    }];
    [self.loadingView startAnimating];
}

- (void)endLoading{
    if (self.loadingView) {
        [self.loadingView stopAnimating];
    }
}
- (UIView *)blankPageContainer{
    UIView *blankPageContainer = self;
    for (UIView *aView in [self subviews])
    {
        if ([aView isKindOfClass:[UITableView class]])
        {
            blankPageContainer = aView;
        }
    }
    return blankPageContainer;
}

@end

@interface AFCLoadingView ()
@property (nonatomic, assign) CGFloat loopAngle, monkeyAlpha, angleStep, alphaStep;
@end


@implementation AFCLoadingView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _loopView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Loding"]];
        _monkeyView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        [_loopView setCenter:self.center];
        [_monkeyView setCenter:self.center];
        [self addSubview:_loopView];
        [self addSubview:_monkeyView];
        
        [_monkeyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
        }];
        
        
        [_loopView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
        }];
        _loopAngle = 0.0;
        _monkeyAlpha = 1.0;
        _angleStep = 360/4;
        _alphaStep = 1.0/3.0;
    }
    return self;
}

- (void)startAnimating{
    self.hidden = NO;
    if (_isLoading)
    {
        return;
    }
    _isLoading = YES;
    [self loadingAnimation];
}

- (void)stopAnimating{
    self.hidden = YES;
    _isLoading = NO;
}

- (void)loadingAnimation{
    static CGFloat duration = 0.4f;
    
    _loopAngle += _angleStep;
    if (_monkeyAlpha >= 1.0 || _monkeyAlpha <= 0.0) {
        _alphaStep = -_alphaStep;
    }
    _monkeyAlpha += _alphaStep;
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        CGAffineTransform loopAngleTransform = CGAffineTransformMakeRotation(_loopAngle * (M_PI / 180.0f));
        _loopView.transform = loopAngleTransform;
        _monkeyView.alpha = _monkeyAlpha;
    } completion:^(BOOL finished)
     {
         if (_isLoading && [self superview] != nil)
         {
             [self loadingAnimation];
         }
         else
         {
             [self removeFromSuperview];
             
             _loopAngle = 0.0;
             _monkeyAlpha = 1,0;
             _alphaStep = ABS(_alphaStep);
             CGAffineTransform loopAngleTransform = CGAffineTransformMakeRotation(_loopAngle * (M_PI / 180.0f));
             _loopView.transform = loopAngleTransform;
             _monkeyView.alpha = _monkeyAlpha;
         }
     }];
}
@end
@implementation AFCBlankPageView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)configWithType:(AFCBlankPageType)blankPageType hasData:(BOOL)hasData reloadButtonBlock:(void (^)(id))block{
    
    if (hasData)
    {
        [self removeFromSuperview];
        return;
    }
    self.alpha = 1.0;
    // 图片
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_imgView];
    }
    // 文字
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _tipLabel.backgroundColor = [UIColor clearColor];
        _tipLabel.numberOfLines = 0;
        _tipLabel.font = [UIFont systemFontOfSize:15];
        _tipLabel.textColor = [UIColor lightGrayColor];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_tipLabel];
    }
    // 布局
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.mas_centerY);
        make.height.width.mas_equalTo(self.width*2/5);
    }];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.centerX.equalTo(self);
        make.top.equalTo(_imgView.mas_bottom);
        make.height.mas_equalTo(50);
    }];
    
    // 空白数据
    if (block) {
        _reloadButtonBlock  =[block copy];
        
        //  [_imgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reloadButtonClicked:)]];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reloadButtonClicked:)]];
        self.userInteractionEnabled = YES;
        //_imgView.userInteractionEnabled=YES;
    }
    NSString *imageName, *tipStr;
    switch (blankPageType) {
        case AFCBlankPageTypeNoData:
        {
            imageName = @"blankpage_NoData";
            tipStr = @"什么也没有,怪我咯?\n";
        }
            break;
        case AFCBlankPageTypeNetError:
        {
            imageName = @"blankpage_NoData";
            tipStr = @"什么也没有,怪我咯?\n";
        }
            break;
            
        default://其它页面（这里没有提到的页面，都属于其它）
        {
            imageName = @"blankpage_image_Sleep";
            tipStr = @"这里还什么都没有\n赶快起来弄出一点动静吧";
        }
            break;
    }
    [_imgView setImage:[UIImage imageNamed:imageName]];
    _tipLabel.text = tipStr;
    
    
}
- (void)reloadButtonClicked:(id)sender{
    self.hidden = YES;
    [self removeFromSuperview];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_reloadButtonBlock) {
            _reloadButtonBlock(sender);
        }
    });
}
@end



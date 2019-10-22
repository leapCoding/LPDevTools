//
//  LPLaunchImageAdView.m
//  LPDevTools
//
//  Created by 李鹏 on 2017/7/26.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import "LPLaunchImageAdView.h"
#import "UIImageView+WebCache.h"

#define mainHeight      [[UIScreen mainScreen] bounds].size.height
#define mainWidth       [[UIScreen mainScreen] bounds].size.width

static NSString *const adImageName = @"adImageName";

@interface LPLaunchImageAdView()

@property (nonatomic, strong) NSTimer *countDownTimer;

@property (nonatomic, strong) NSString *isClick;

@end

@implementation LPLaunchImageAdView

+ (void)makeLBLaunchImageAdView:(void(^)(LPLaunchImageAdView *))block {
    [self loadAdImage];
    NSString *filePath = [self getFilePathWithImageName:[[NSUserDefaults standardUserDefaults] valueForKey:adImageName]];
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    if (isExist) {
        NSData *data = [[NSFileManager defaultManager] contentsAtPath:filePath];
        UIImage *image = [UIImage imageWithData:data];
        LPLaunchImageAdView *imgAdView = [[LPLaunchImageAdView alloc]init];
        imgAdView.getLBlaunchImageAdViewType(AdTypeFullScreen);
        imgAdView.localAdImg = image;
        block(imgAdView);
    }
}

//ad广告数据请求
+ (void)loadAdImage {
    
    //暂时没有接口, 就用一个数组存了若干图片url, 每次随机取出一个
    NSArray *imageArray = @[@"http://imgsrc.baidu.com/forum/pic/item/9213b07eca80653846dc8fab97dda144ad348257.jpg", @"http://pic.paopaoche.net/up/2012-2/20122220201612322865.png", @"http://img5.pcpop.com/ArticleImages/picshow/0x0/20110801/2011080114495843125.jpg", @"http://www.mangowed.com/uploads/allimg/130410/1-130410215449417.jpg"];
    NSString *imageUrl = imageArray[arc4random() % imageArray.count];
    
    //把获取的网址字符串按"/"分割成几部分组成数组
    NSArray *stringArr = [imageUrl componentsSeparatedByString:@"/"];
    NSString *imageName = stringArr.lastObject;
    
    //拼接沙盒路径
    NSString *filePath = [self getFilePathWithImageName:imageName];
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    
    //如果图片不存在, 删除老图片, 网络获取并存入沙盒
    if (!isExist) {
        [self downloadAdImageWithUrl:imageUrl imageName:imageName];
    }
}

#pragma mark - 获取广告类型
- (void (^)(AdType adType))getLBlaunchImageAdViewType{
    __weak typeof(self) weakSelf = self;
    return ^(AdType adType){
        [weakSelf addLBlaunchImageAdView:adType];
    };
}

#pragma mark - 点击广告
- (void)activiTap:(UITapGestureRecognizer*)recognizer{
    _isClick = @"1";
    [self startcloseAnimation];
}

#pragma mark - 开启关闭动画
- (void)startcloseAnimation{
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.duration = 0.5;
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.3];
    opacityAnimation.removedOnCompletion = NO;
    opacityAnimation.fillMode = kCAFillModeForwards;
    
    [self.adImgView.layer addAnimation:opacityAnimation forKey:@"animateOpacity"];
    [NSTimer scheduledTimerWithTimeInterval:opacityAnimation.duration
                                     target:self
                                   selector:@selector(closeAddImgAnimation)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)skipBtnClick{
    _isClick = @"2";
    [self startcloseAnimation];
}

#pragma mark - 关闭动画完成时处理事件
-(void)closeAddImgAnimation
{
    [_countDownTimer invalidate];
    _countDownTimer = nil;
    self.hidden = YES;
    self.adImgView.hidden = YES;
    [self removeFromSuperview];
    if ([_isClick integerValue] == 1) {
        if (self.clickBlock) {//点击广告
            self.clickBlock(ClickTypeAd);
        }
    }else if([_isClick integerValue] == 2){
        if (self.clickBlock) {//点击跳过
            self.clickBlock(ClickTypeSkip);
        }
    }else{
        if (self.clickBlock) {
            self.clickBlock(ClickTypeOvertime);
        }
    }
}

- (void)onTimer {
    if (_adTime == 0) {
        [_countDownTimer invalidate];
        _countDownTimer = nil;
        [self startcloseAnimation];
    }else{
        [self.skipBtn setTitle:[NSString stringWithFormat:@"%@ | 跳过",@(_adTime--)] forState:UIControlStateNormal];
    }
}

- (void)setLocalAdImg:(UIImage *)localAdImg {
    _localAdImg = localAdImg;
    self.adImgView.image = localAdImg;
}

- (void)setLocalAdImgName:(NSString *)localAdImgName {
    _localAdImgName = localAdImgName;
    if (_localAdImgName.length > 0) {
        if ([_localAdImgName rangeOfString:@".gif"].location  != NSNotFound ) {
            _localAdImgName  = [_localAdImgName stringByReplacingOccurrencesOfString:@".gif" withString:@""];
            
            NSData *gifData = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:_localAdImgName ofType:@"gif"]];
            UIWebView *webView = [[UIWebView alloc] initWithFrame:self.adImgView.frame];
            webView.backgroundColor = [UIColor clearColor];
            webView.scalesPageToFit = YES;
            webView.scrollView.scrollEnabled = NO;
            [webView loadData:gifData MIMEType:@"image/gif" textEncodingName:@"" baseURL:[NSURL URLWithString:@""]];
            [webView setUserInteractionEnabled:NO];
            UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            clearBtn.frame = webView.frame;
            clearBtn.backgroundColor = [UIColor clearColor];
            [clearBtn addTarget:self action:@selector(activiTap:) forControlEvents:UIControlEventTouchUpInside];
            [webView addSubview:clearBtn];
            [self.adImgView addSubview:webView];
            [self.adImgView bringSubviewToFront:_skipBtn];
        }else{
            self.adImgView.image = [UIImage imageNamed:_localAdImgName];
        }
    }
}

-(void)setImgUrl:(NSString *)imgUrl{
    _imgUrl = imgUrl;
//    [_adImgView sd_setImageWithURL:[NSURL URLWithString:_imgUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        if(image){
////            [self.adImgView setImage:[self imageCompressForWidth:image targetWidth:mainWidth]];
//        }
//    }];
}

- (void)addLBlaunchImageAdView:(AdType)adType{
#pragma mark - iOS开发 强制竖屏。系统KVO 强制竖屏—>适用于支持各种方向屏幕启动时，竖屏展示广告 by:nixs
    NSNumber * orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    //倒计时时间
    _adTime = 6;
    [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
    NSString *launchImageName = [self getLaunchImage:@"Portrait"];
    UIImage * launchImage = [UIImage imageNamed:launchImageName];
//    self.backgroundColor = [UIColor colorWithPatternImage:launchImage];
    self.frame = CGRectMake(0, 0, mainWidth, mainHeight);
    if (adType == AdTypeFullScreen) {
        self.adImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, mainWidth, mainHeight)];
    }else{
        self.adImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, mainWidth, mainHeight - mainWidth/3)];
    }
    self.skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.skipBtn.frame = CGRectMake(mainWidth - 70, 20, 60, 30);
    self.skipBtn.backgroundColor = [UIColor brownColor];
    self.skipBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.skipBtn addTarget:self action:@selector(skipBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.adImgView addSubview:self.skipBtn];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.skipBtn.bounds byRoundingCorners:UIRectCornerBottomRight | UIRectCornerTopRight cornerRadii:CGSizeMake(15, 15)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.skipBtn.bounds;
    maskLayer.path = maskPath.CGPath;
    self.skipBtn.layer.mask = maskLayer;
    self.adImgView.tag = 1101;
    [self addSubview:self.adImgView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(activiTap:)];
    // 允许用户交互
    self.adImgView.userInteractionEnabled = YES;
    [self.adImgView addGestureRecognizer:tap];
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.duration = 0.8;
    opacityAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.8];
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [self.adImgView.layer addAnimation:opacityAnimation forKey:@"animateOpacity"];
    _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
    [[UIApplication sharedApplication].delegate.window addSubview:self];
}

/*
 *viewOrientation 屏幕方向
 */
- (NSString *)getLaunchImage:(NSString *)viewOrientation{
    //获取启动图片
    CGSize viewSize = [UIApplication sharedApplication].delegate.window.bounds.size;
    //横屏请设置成 @"Landscape"|Portrait
    //    NSString *viewOrientation = @"Portrait";
    __block NSString *launchImageName = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    [imagesDict enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGSize imageSize = CGSizeFromString(obj[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:obj[@"UILaunchImageOrientation"]])
        {
            launchImageName = obj[@"UILaunchImageName"];
        }
    }];
    return launchImageName;
}

/**
 *  下载新图片
 */
+ (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:data];
        
        NSString *filePath = [self getFilePathWithImageName:imageName]; // 保存文件的名称
        
        if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {// 保存成功
            [self deleteOldImage];// 保存成功后删除旧图片
            [[NSUserDefaults standardUserDefaults] setValue:imageName forKey:adImageName];
            [[NSUserDefaults standardUserDefaults] synchronize];
            // 如果有广告链接，需要将广告链接也保存下来
        }
    });
}

/**
 *  删除旧图片
 */
+ (void)deleteOldImage
{
    NSString *imageName = [[NSUserDefaults standardUserDefaults] valueForKey:adImageName];
    if (imageName) {
        NSString *filePath = [self getFilePathWithImageName:imageName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:nil];
    }
}

+ (NSString *)getFilePathWithImageName:(NSString *)imageName{
    
    if (imageName) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *filePath = [paths.firstObject stringByAppendingPathComponent:imageName];
        return filePath;
    }
    return nil;
}

@end

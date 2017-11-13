//
//  LPLaunchImageAdView.h
//  LPDevTools
//
//  Created by 李鹏 on 2017/7/26.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AdType) {
    AdTypeLogo = 0,///带logo的广告
    AdTypeFullScreen = 1,///全屏的广告
};

typedef NS_ENUM(NSInteger, ClickType) {
    ClickTypeSkip = 1, //点击跳过
    ClickTypeAd = 2, //点击广告
    ClickTypeOvertime = 3,///倒计时完成跳过
};

typedef void (^LPClick) (ClickType);

@interface LPLaunchImageAdView : UIView

@property (nonatomic, strong) UIImageView *adImgView;
// 倒计时总时长,默认6秒
@property (nonatomic, assign) NSInteger adTime;
// 跳过按钮 可自定义
@property (nonatomic, strong) UIButton *skipBtn;
// 本地图片
@property (nonatomic, strong) UIImage *localAdImg;
// 本地图片名字
@property (nonatomic, copy) NSString *localAdImgName;
// 网络图片URL
@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, copy) LPClick clickBlock;

/*
 *  adType 广告类型
 */
- (void(^)(AdType const adType))getLBlaunchImageAdViewType;

+ (void)makeLBLaunchImageAdView:(void(^)(LPLaunchImageAdView *))block;

@end

//
//  UIView+AFCLodingBlank.h
//  AFC
//
//  Created by Leap on 16/6/6.
//  Copyright © 2016年 carlyle. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AFCLoadingView, AFCBlankPageView;
typedef NS_ENUM(NSInteger, AFCBlankPageType) {
    AFCBlankPageTypeNoData = 0,//无数据
    AFCBlankPageTypeNetError,//网络错误
};

@interface UIView (AFCLodingBlank)
#pragma mark LoadingView
@property (strong, nonatomic) AFCLoadingView *loadingView;
#pragma mark BlankPageView
@property (strong, nonatomic) AFCBlankPageView *blankPageView;
- (void)beginLoading;
- (void)endLoading;

- (void)configBlankPage:(AFCBlankPageType)blankPageType hasData:(BOOL)hasData  reloadButtonBlock:(void(^)(id sender))block;
- (void)configBlankPage:(AFCBlankPageType)blankPageType frame:(CGRect)frame hasData:(BOOL)hasData  reloadButtonBlock:(void(^)(id sender))block;

@end

//Loding动画
@interface AFCLoadingView : UIView
@property (strong,nonatomic) UIImageView *loopView,*monkeyView;
@property (assign, nonatomic, readonly) BOOL isLoading;
- (void)startAnimating;
- (void)stopAnimating;
@end


//数据加载失败的时候  没有数据的时候的处理逻辑
@interface AFCBlankPageView : UIView

@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UILabel *tipLabel;
@property (copy, nonatomic) void(^reloadButtonBlock)(id sender);
- (void)configWithType:(AFCBlankPageType)blankPageType hasData:(BOOL)hasData reloadButtonBlock:(void (^)(id))block;

@end
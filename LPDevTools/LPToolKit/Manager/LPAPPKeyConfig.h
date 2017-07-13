//
//  LPAPPKeyConfig.h
//  WYJCore
//
//  Created by 李鹏 on 2017/7/11.
//  Copyright © 2017年 WYJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPAPPKeyConfig : NSObject

//友盟分享
@property (nonatomic, copy) NSString *umengKey;
//qq
@property (nonatomic, copy) NSString *qqId;
//新浪微博
@property (nonatomic, copy) NSString *sinaKey;
@property (nonatomic, copy) NSString *sinaSecret;
//百度地图
@property (nonatomic, copy) NSString *baiduKey;
//极光推送
@property (nonatomic, copy) NSString *jpushKey;
@property (nonatomic, copy) NSString *jpushChannel;
@property (nonatomic, assign) BOOL jpushForProduct;

//微信
@property (nonatomic, copy) NSString *wxKey;
@property (nonatomic, copy) NSString *wxSecret;

@property (nonatomic, assign) NSInteger appId;

+ (instancetype)sharedInstance;

- (NSString *)appUrl;

@end

//
//  NetWorkUrlConfig.h
//  LPDevTools
//
//  Created by lipeng on 16/11/7.
//  Copyright © 2016年 lpdev.com. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSTimeInterval kNetworkingTimeoutSeconds = 20.0f; //请求超时设置（单位：秒）
static NSString * const APIBaseURLString = @"http://webapi.airfortune.cn/api/";//这里替换成你的BaseURL
static NSString * const kDefaultErrorTips = @"网络异常,请检查网络是否正常";

typedef NS_ENUM(NSUInteger, NetWorkRequestType){
    NetWorkRequestTypeGet,
    NetWorkRequestTypePost,
};

typedef NS_ENUM(NSUInteger, NetWorkResponseStatus)
{
    NetWorkResponseStatusSuccess,
    NetWorkResponseStatusFailed = 9999,
};


typedef NS_ENUM(NSUInteger, NetWorkRequestUrl){
    NetWorkRequestUrl_None = 0,
    NetWorkRequestUrl_QueryProjectList,//获取项目列表
};

@class NetWorkResponse;

typedef void (^ResponseBlock)(NetWorkResponse *response);

@interface NetWorkUrlConfig : NSObject

+ (NetWorkUrlConfig *)sharedManager;

+ (void)cancelAllRequest;

+ (void)cancelRequestWithURL:(NetWorkRequestUrl)url;

- (void)getUrl:(NetWorkRequestUrl)url
    parameters:(NSDictionary *)parameters
     className:(NSString *)className
 responseBlock:(ResponseBlock)responseBlock;

- (void)postUrl:(NetWorkRequestUrl)url
    parameters:(NSDictionary *)parameters
     className:(NSString *)className
 responseBlock:(ResponseBlock)responseBlock;

@end

@class NetWorkRequest;

@interface NetWorkResponse : NSObject

@property (assign, nonatomic) NSInteger code;

@property (copy, nonatomic) NSString *message;

@property (strong, nonatomic) NSDictionary *data;


/** 解析后的对象/数组 */
@property (strong, nonatomic) id result;

- (instancetype)initWithResult:(NSDictionary *)result request:(NetWorkRequest *)request;

- (BOOL)isSuccess;

@end

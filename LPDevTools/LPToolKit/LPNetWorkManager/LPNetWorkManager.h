//
//  LPNetWorkManager.h
//  LPNetWork
//
//  Created by lipeng on 17/3/24.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#ifndef ASLog
#if DEBUG
#define ASLog(fmt, ...) NSLog((@"%s [Line %d] " fmt),__PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define ASLog(fmt, ...)
#endif
#endif

#import <Foundation/Foundation.h>

static NSTimeInterval kNetworkingTimeoutSeconds = 10.0f; //请求超时设置（单位：秒）

//网络请求类型
typedef NS_ENUM(NSUInteger, LPApiRequestType) {
    LPApiRequestTypeGet = 0,    //Get 请求
    LPApiRequestTypePost,       //Post 请求
};

typedef NS_ENUM(NSUInteger, LPNetworkStatus) {
    StatusUnknown           = -1,   //未知网络
    StatusNotReachable      = 0,    //没有网络
    StatusReachableViaWWAN  = 1,    //手机自带网络
    StatusReachableViaWiFi  = 2     //wifi
};


typedef void(^LPCallback)(id responseObject, NSError *error);
/** 上传或者下载的进度, Progress.completedUnitCount:当前大小 - Progress.totalUnitCount:总大小*/
typedef void (^LPHttpProgress)(NSProgress *progress);

@interface LPNetWorkManager : NSObject
/**
 *  请求头
 */
@property (nonatomic, strong) NSDictionary *headers;

/**
 *  获取网络
 */
@property (nonatomic,assign)LPNetworkStatus networkStats;

+ (NSMutableArray *)allTasks;

+ (instancetype)sharedManager;

- (NSURLSessionDataTask *)callApiWithUrl:(NSString *)url params:(NSDictionary *)params requestType:(LPApiRequestType)requestType callBack:(LPCallback)callback;

- (NSURLSessionDownloadTask *)downloadWithUrl:(NSString *)url params:(NSDictionary *)params progress:(LPHttpProgress)progress success:(void(^)(NSString *filePath))success callBack:(LPCallback)callback;

@end

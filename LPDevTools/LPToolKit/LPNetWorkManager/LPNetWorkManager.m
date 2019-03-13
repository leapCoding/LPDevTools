//
//  LPNetWorkManager.m
//  LPNetWork
//
//  Created by lipeng on 17/3/24.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import "LPNetWorkManager.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"

@interface LPNetWorkManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;   //通用会话管理器

@end

@implementation LPNetWorkManager

static NSMutableArray *requestTasks;
+ (NSMutableArray *)allTasks {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (requestTasks == nil) {
            requestTasks = [[NSMutableArray alloc] init];
        }
    });
    return requestTasks;
}

/**
 *  创建及获取单例对象的方法
 *
 *  @return 管理请求的单例对象
 */
+ (instancetype)sharedManager {
    static LPNetWorkManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LPNetWorkManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        [self initSessionManager];
    }
    return self;
}

- (void)initSessionManager {
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    // 设置全局会话管理实例
    _sessionManager = [AFHTTPSessionManager manager];
    
    // 设置请求序列化器
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    requestSerializer.timeoutInterval = kNetworkingTimeoutSeconds;
    _sessionManager.requestSerializer = requestSerializer;
    
    // 设置请求头
    NSDictionary *headers = @{@"Authorization":@"Basic ",@"X-Message-Sender":@"529MALL",@"FromAPP":@"0",@"PlatformType":@"0",@"AppVersion":@"1.0.0"};
    [headers enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (obj) {
            [_sessionManager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
        }
    }];
    
    // 设置响应序列化器，解析Json对象
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    responseSerializer.removesKeysWithNullValues = YES; // 清除返回数据的 NSNull
    responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                      @"text/html",
                                                                      @"text/json",
                                                                      @"text/plain",
                                                                      @"text/javascript",
                                                                      @"text/xml",
                                                                      @"image/*"]]; // 设置接受数据的格式
    _sessionManager.responseSerializer = responseSerializer;
    // 设置安全策略
    self.sessionManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];;
}

- (void)setHeaders:(NSDictionary *)headers {
    _headers = headers;
    [_headers enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (obj) {
            [_sessionManager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
        }
    }];
}

#pragma mark 网络监听
- (void)startMonitoring {
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status){
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                [LPNetWorkManager sharedManager].networkStats=StatusUnknown;
                break;
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                [LPNetWorkManager sharedManager].networkStats=StatusNotReachable;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                [LPNetWorkManager sharedManager].networkStats=StatusReachableViaWWAN;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                [LPNetWorkManager sharedManager].networkStats=StatusReachableViaWiFi;
                break;
        }
    }];
    [mgr startMonitoring];
}

- (NSURLSessionDataTask *)callApiWithUrl:(NSString *)url params:(NSDictionary *)params requestType:(LPApiRequestType)requestType callBack:(LPCallback)callback {
    // url长度为0时，返回错误
    if (!url || url.length == 0)
    {
        if (callback) {
            callback(nil,nil);
        }
        return nil;
    }
    
    // 会话管理对象为空时
    if (!_sessionManager)
    {
        [self initSessionManager];
    }
    
    __block NSURLSessionDataTask * urlSessionDataTask;
    // 请求成功时的回调
    void (^successWrap)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        if (!responseObject || (![responseObject isKindOfClass:[NSDictionary class]] && ![responseObject isKindOfClass:[NSArray class]])) // 若解析数据格式异常，返回错误
        {
            if (callback)
            {
                callback(nil,nil);
            }
        }
        else // 若解析数据正常，判断API返回的code，
        {
            if (callback) {
                callback(responseObject,nil);
            }
        }
    };
    
    // 请求失败时的回调
    void (^failureWrap)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        if (callback) {
            callback(nil,error);
        }
    };

    // 检查url
    if (![NSURL URLWithString:url]) {
        url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    
    if (requestType == LPApiRequestTypeGet) {
        urlSessionDataTask = [_sessionManager GET:url parameters:params progress:nil success:successWrap failure:failureWrap];
    }else if (requestType == LPApiRequestTypePost) {
        urlSessionDataTask = [_sessionManager POST:url parameters:params progress:nil success:successWrap failure:failureWrap];
    }
    return urlSessionDataTask;
}

- (NSURLSessionDownloadTask *)downloadWithUrl:(NSString *)url params:(NSDictionary *)params progress:(LPHttpProgress)progress success:(void(^)(NSString *filePath))success callBack:(LPCallback)callback {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    __block NSURLSessionDownloadTask * urlSessionDataTask = nil;
    urlSessionDataTask = [_sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //下载进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(downloadProgress) : nil;
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //拼接缓存目录
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"Download"];
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //创建Download目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        //返回文件位置的URL路径
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if(callback && error) {callback(nil,error) ; return ;};
        success ? success(filePath.absoluteString /** NSURL->NSString*/) : nil;
        
    }];
    //开始下载
    [urlSessionDataTask resume];
    return urlSessionDataTask;
}

@end

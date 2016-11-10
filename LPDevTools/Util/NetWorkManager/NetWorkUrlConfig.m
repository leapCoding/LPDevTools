//
//  NetWorkUrlConfig.m
//  LPDevTools
//
//  Created by lipeng on 16/11/7.
//  Copyright © 2016年 lpdev.com. All rights reserved.
//

#import "NetWorkUrlConfig.h"
#import "NetWorkRequest.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "AFNetworking.h"
#import "MJExtension.h"

@implementation NetWorkUrlConfig

+ (NSString *)urlString:(NetWorkRequestUrl)url {
    switch (url) {
        case NetWorkRequestUrl_None:
            return @"";
            break;
            
        default:
            break;
    }
}

+ (NetWorkUrlConfig *)sharedManager {
    static NetWorkUrlConfig *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

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

+ (void)cancelAllRequest {
    @synchronized(self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(NSURLSessionDataTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task isKindOfClass:[NSURLSessionDataTask class]]) {
                [task cancel];
            }
        }];
        [[self allTasks] removeAllObjects];
    };
}

+ (void)cancelRequestWithURL:(NetWorkRequestUrl )url {
    NSString *urlString = [NetWorkUrlConfig urlString:url];
    @synchronized(self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(NSURLSessionDataTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task isKindOfClass:[NSURLSessionDataTask class]]
                && [task.currentRequest.URL.absoluteString hasSuffix:urlString]) {
                [task cancel];
                [[self allTasks] removeObject:task];
                return;
            }
        }];
    };
}

+ (AFHTTPSessionManager *)manager {
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    /**
     *  默认请求和返回的数据类型
     */
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    
    /**
     *  取出NULL值
     */
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
    [serializer setRemovesKeysWithNullValues:YES];
    
    NSDictionary *headers = @{@"X-Message-Sender":@"Afc-Web-API",@"Terminal":@"1",@"AppVersion":@"1"};
    [headers enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (obj) {
            [manager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
        }
    }];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];
    manager.requestSerializer.timeoutInterval = kNetworkingTimeoutSeconds;
    
    return manager;
}

- (void)requestWithUrl:(NetWorkRequestUrl)url
            parameters:(NSDictionary *)parameters
            httpMethod:(NetWorkRequestType)httpMethod
             className:(NSString *)className
         responseBlock:(ResponseBlock)responseBlock{
    NetWorkRequest *request = [[NetWorkRequest alloc]initWithUrl:url params:parameters className:className rquestType:httpMethod];
    [self request:request responseBlock:responseBlock];
}

- (void)request:(NetWorkRequest *)request responseBlock:(ResponseBlock)responseBlock {
    if (![NetWorkUrlConfig detectNetworkStaus]) {
        NetWorkResponse *response = [[NetWorkResponse alloc] init];
        response.code = NetWorkResponseStatusFailed;
        response.message = kDefaultErrorTips;
        responseBlock(response);
        return;
    }
    
    NSString *method = [request requestMethod];
    
    NSString *urlString = [NetWorkUrlConfig urlString:request.requestUrl];
    
    AFHTTPSessionManager *manager = [NetWorkUrlConfig manager];
    
    __block NSMutableDictionary *param = [[NSMutableDictionary  alloc] initWithDictionary:request.params];
    
    __block NSMutableURLRequest *urlRequest = [manager.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:urlString relativeToURL:manager.baseURL] absoluteString] parameters:param error:nil];
    
    __block NSURLSessionDataTask *task = [manager dataTaskWithRequest:urlRequest completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (responseBlock) {
            
            DebugLog(@"\n%@ %@\n%@\n%@\n%@",method, error ? @"Error" : @"Success", urlString, [self lp_description:param], error ? error : [self lp_description:responseObject]);
            NetWorkResponse *response = nil;
            if (error) {
                response = [[NetWorkResponse alloc] init];
                response.code = NetWorkResponseStatusFailed;
                response.message = kDefaultErrorTips;
            }else{
                response = [[NetWorkResponse alloc] initWithResult:responseObject request:request];
            }
            responseBlock(response);
            
            [[NetWorkUrlConfig allTasks] removeObject:task];
        }
    }];
    [task resume];
    if (task) {
        [[NetWorkUrlConfig allTasks] addObject:task];
    }

}

- (NSString*)lp_description:(NSDictionary *)dic {
    NSString *desc = [dic description];
    NSString *encode = [NSString stringWithCString:[desc cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
    //    NSString *encode = [[NSString alloc] initWithData:[desc dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES] encoding:NSNonLossyASCIIStringEncoding];
    
    if (!encode) {
        encode = [NSString stringWithCString:[desc cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSWindowsCP1251StringEncoding];
    }
    return encode ? encode : desc;
}

#pragma mark - 网络状态的检测
+ (BOOL)detectNetworkStaus {
    
    __block BOOL networkStaus = YES;
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable){
            networkStaus = NO;
        }else if (status == AFNetworkReachabilityStatusUnknown){
            networkStaus = NO;
        }else if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi){
            networkStaus = YES;
        }
    }];
    return networkStaus;
}


@end

@implementation NetWorkResponse

- (instancetype)initWithResult:(NSDictionary *)result request:(NetWorkRequest *)request {
    if (![result isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        
        _code = [result[@"code"] integerValue];
        _message = result[@"msg"];
        _data = result[@"data"];
        
        if (![self isSuccess]) {
            return self;
        }
        
        if (request.className.length > 0) {
            Class class = NSClassFromString(request.className);
            NSAssert(class, @"Class Not Exists");
            
            __block id data = _data;
            if ([data isKindOfClass:[NSDictionary class]]) {
                NSArray *defaults = @[@"list"];
                [defaults enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([_data.allKeys containsObject:obj]) {
                        data = _data[obj];
                        *stop = YES;
                    }
                }];
            }
            
            if (data == nil || [data isEqual:[NSNull null]]) {
                data = [data isKindOfClass:[NSArray class]] ? @{} : @[];
            }
            
            self.result =
            [data isKindOfClass:[NSDictionary class]] ? [class mj_objectWithKeyValues:data] : [class mj_objectArrayWithKeyValuesArray:data];
            
            NSAssert(_result, @"Parse error!");
        }
    }
    return self;
}

- (BOOL)isSuccess {
    return _code == 0;
}

@end

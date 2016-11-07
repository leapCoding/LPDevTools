//
//  NetWorkRequest.h
//  LPDevTools
//
//  Created by lipeng on 16/11/7.
//  Copyright © 2016年 lpdev.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetWorkUrlConfig.h"

@interface NetWorkRequest : NSObject

@property (assign, nonatomic) NetWorkRequestUrl requestUrl;
@property (assign, nonatomic) NetWorkRequestType requestType;
@property (strong, nonatomic) NSDictionary *params;//请求参数
@property (copy, nonatomic) NSString *className;//模型类名
@property (assign, nonatomic) BOOL useCache;

- (instancetype)initWithUrl:(NetWorkRequestUrl)url
                     params:(NSDictionary *)params;

- (instancetype)initWithUrl:(NetWorkRequestUrl)url
                     params:(NSDictionary *)params
                  className:(NSString *)className;

- (instancetype)initWithUrl:(NetWorkRequestUrl)url
                     params:(NSDictionary *)params
                  className:(NSString *)className
                 rquestType:(NetWorkRequestType)requestType;

- (NSString *)requestType;

@end

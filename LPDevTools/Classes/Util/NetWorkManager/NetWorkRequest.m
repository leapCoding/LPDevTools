//
//  NetWorkRequest.m
//  LPDevTools
//
//  Created by lipeng on 16/11/7.
//  Copyright © 2016年 lpdev.com. All rights reserved.
//

#import "NetWorkRequest.h"

@implementation NetWorkRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        self.requestType = NetWorkRequestTypeGet;
    }
    return self;
}

- (instancetype)initWithUrl:(NetWorkRequestUrl)url params:(NSDictionary *)params className:(NSString *)className rquestType:(NetWorkRequestType)requestType {
    self = [super init];
    if (self) {
        self.requestUrl = url;
        self.params = params;
        self.className = className;
        self.requestType = requestType;
    }
    return self;
}

- (instancetype)initWithUrl:(NetWorkRequestUrl)url params:(NSDictionary *)params className:(NSString *)className {
    return [[[self class] alloc] initWithUrl:url params:params className:className rquestType:NetWorkRequestTypeGet];;
}

- (instancetype)initWithUrl:(NetWorkRequestUrl)url params:(NSDictionary *)params {
    return [[[self class] alloc] initWithUrl:url params:params className:nil];
}

- (NSString *)requestType {
    return @[@"GET",@"POST"][_requestType];
}

@end

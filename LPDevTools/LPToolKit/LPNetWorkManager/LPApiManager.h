//
//  LPApiManager.h
//  LPNetWork
//
//  Created by lipeng on 17/3/24.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPNetWorkManager.h"

@class LPNetWorkResponse;
@interface LPApiManager : NSObject

typedef void (^ResponseBlock)(LPNetWorkResponse *response);
/** get请求 */
+ (instancetype)getUrl:(NSString *)url
    parameters:(NSDictionary *)parameters
     className:(Class)className
 responseBlock:(ResponseBlock)responseBlock;
/** post请求 */
+ (instancetype)postUrl:(NSString *)url
            parameters:(NSDictionary *)parameters
             className:(Class)className
         responseBlock:(ResponseBlock)responseBlock;

//图片压缩处理
- (NSArray *)imageCompression:(NSArray *)images;

+ (void)cancelAllRequest;

+ (void)cancelRequestWithURL:(NSString *)url;

@end

//接口返回数据对象
@interface LPNetWorkResponse : NSObject

@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, assign) NSInteger code;
/** 解析后的对象/数组 */
@property (nonatomic, strong) id result;

- (instancetype)initWithResult:(NSDictionary *)result className:(Class)className;

- (BOOL)isSuccess;

@end

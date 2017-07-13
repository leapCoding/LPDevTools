//
//  LPLocationManager.h
//  LPDevTools
//
//  Created by 李鹏 on 2017/7/12.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//
/**
 ************************************************
 ******请求用户权限,需要在info.plist中添加两个值******
 ******NSLocationAlwaysUsageDescription**********
 ******NSLocationWhenInUseUsageDescription*******
 ************************************************
 */
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

/**
 定位模型
 */
@interface LPLocationModel : NSObject
/** 当前定位的经度纬度 */
@property (nonatomic, assign) CLLocationCoordinate2D currentLocation;
/** 地理位置信息 */
@property (nonatomic, strong) NSString *locatedAddress;
/** 位置名 */
@property (nonatomic, strong) NSString *name;
/** 城市名 */
@property (nonatomic, strong) NSString *city;

@end

typedef void (^complateBlock) (BOOL isSuccess, LPLocationModel *locationModel);

typedef void (^complateArrayBlock) (BOOL isSuccess, NSArray *locationModels);


@interface LPLocationManager : NSObject

+ (instancetype)shareInstance;

@end

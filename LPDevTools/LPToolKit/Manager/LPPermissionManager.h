//
//  LPPermissionManager.h
//  LPDevTools
//
//  Created by 李鹏 on 2017/11/23.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 定位权限状态，参考：CLAuthorizationStatus
 
 - LocationAuthorizationStatus_NotDetermined: 用户从未进行过授权等处理，首次访问相应内容会提示用户进行授权
 - LocationAuthorizationStatus_Authorized: 一直允许获取定位 ps：< iOS8用
 - LocationAuthorizationStatus_Denied: 拒绝
 - LocationAuthorizationStatus_Restricted: 应用没有相关权限，且当前用户无法改变这个权限，比如:家长控制
 - LocationAuthorizationStatus_NotSupport: 硬件等不支持
 - LocationAuthorizationStatus_AuthorizedAlways: 一直允许获取定位
 - LocationAuthorizationStatus_AuthorizedWhenInUse: 在使用时允许获取定位
 */
typedef NS_ENUM(NSUInteger, LP_LocationAuthorizationStatus){
    LP_LocationAuthorizationStatus_NotDetermined         = 0,
    LP_LocationAuthorizationStatus_Authorized            = 1,
    LP_LocationAuthorizationStatus_Denied                = 2,
    LP_LocationAuthorizationStatus_Restricted            = 3,
    LP_LocationAuthorizationStatus_NotSupport            = 4,
    LP_LocationAuthorizationStatus_AuthorizedAlways      = 5,
    LP_LocationAuthorizationStatus_AuthorizedWhenInUse   = 6,
};

/**
 定位权限 block
 
 @param status 定位权限状态
 */
typedef void(^LP_PrivacyOfLocationResultBlock)(LP_LocationAuthorizationStatus status);

@interface LPPermissionManager : NSObject

+ (instancetype)shareInstance;

#pragma mark - LocationServices
- (void)lp_checkAndRequestPrivacyOfLocationServicesWithBlock:(LP_PrivacyOfLocationResultBlock)block;


@end

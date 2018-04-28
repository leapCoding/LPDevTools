//
//  LPPermissionManager.m
//  LPDevTools
//
//  Created by 李鹏 on 2017/11/23.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import "LPPermissionManager.h"

// Import required frameworks
#import <CoreLocation/CoreLocation.h>

@implementation LPPermissionManager

+ (instancetype)shareInstance {
    static LPPermissionManager *permissionManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        permissionManager = [[self alloc]init];
    });
    return permissionManager;
}

#pragma mark - LocationServices
- (void)lp_checkAndRequestPrivacyOfLocationServicesWithBlock:(LP_PrivacyOfLocationResultBlock)block {
    BOOL isLocationServicesEnabled = [CLLocationManager locationServicesEnabled];
    if (isLocationServicesEnabled) {
        //定位服务不可用
        [self lp_executeLocationServicesWithBlock:block locationAuthorizationStatus:LP_LocationAuthorizationStatus_NotSupport];
    }else {
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        switch (status) {
            case kCLAuthorizationStatusNotDetermined: {
                
            }
                break;
            case kCLAuthorizationStatusRestricted: {
                
            }
                break;
                
            default:
                break;
        }
    }
}

#pragma mark - Location Services CallBack
- (void)lp_executeLocationServicesWithBlock:(LP_PrivacyOfLocationResultBlock)block locationAuthorizationStatus:(LP_LocationAuthorizationStatus)locationAuthorizationStatus
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (block)
        {
            block(locationAuthorizationStatus);
        }
    });
}

@end

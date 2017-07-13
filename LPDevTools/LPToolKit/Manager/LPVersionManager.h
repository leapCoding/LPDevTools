//
//  LPVersionManager.h
//  WYJCore
//
//  Created by 李鹏 on 2017/7/12.
//  Copyright © 2017年 WYJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPVersionManager : NSObject

+ (instancetype)shareManager;

- (void)start;

@end

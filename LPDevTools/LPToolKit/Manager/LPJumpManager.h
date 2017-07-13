//
//  LPJumpManager.h
//  WYJCore
//
//  Created by 李鹏 on 2017/7/11.
//  Copyright © 2017年 WYJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPJumpManager : NSObject

+ (void)jumpToController:(NSDictionary *)params;
+ (void)jumpToController:(NSDictionary *)params popOther:(BOOL)pop;

@end

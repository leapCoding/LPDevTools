//
//  NSTimer+LPTools.m
//  WYJCore
//
//  Created by 李鹏 on 2017/7/5.
//  Copyright © 2017年 WYJ. All rights reserved.
//

#import "NSTimer+LPTools.h"

@implementation NSTimer (LPTools)

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *timer))block repeats:(BOOL)yesOrNo {
    return [self scheduledTimerWithTimeInterval:seconds target:self selector:@selector(blockInvoke:) userInfo:[block copy] repeats:yesOrNo];
}

+ (void)blockInvoke:(NSTimer *)timer {
    if ([timer userInfo]) {
        void (^block)(NSTimer *timer) = (void (^)(NSTimer *timer))[timer userInfo];
        block(timer);
    }
}

@end

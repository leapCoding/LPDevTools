//
//  NSTimer+Block.m
//  LPDevTools
//
//  Created by lipeng on 16/11/7.
//  Copyright © 2016年 lpdev.com. All rights reserved.
//

#import "NSTimer+Block.h"

@implementation NSTimer (Block)

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      block:(void(^)())block
                                    repeats:(BOOL)repeats
{
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(timerUpdateWithBlock:)
                                       userInfo:[block copy]
                                        repeats:repeats];
}

+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)interval
                             block:(void(^)())block
                           repeats:(BOOL)repeats
{
    return [self timerWithTimeInterval:interval
                                target:self
                              selector:@selector(timerUpdateWithBlock:)
                              userInfo:[block copy]
                               repeats:repeats];
}

+ (void)timerUpdateWithBlock:(NSTimer*)timer{
    
    void (^timerBlock)() = timer.userInfo;
    if(timerBlock){
        
        timerBlock();
    }
}

@end

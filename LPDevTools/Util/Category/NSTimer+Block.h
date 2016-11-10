//
//  NSTimer+Block.h
//  LPDevTools
//
//  Created by lipeng on 16/11/7.
//  Copyright © 2016年 lpdev.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Block)

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      block:(void(^)())block
                                    repeats:(BOOL)repeats;

+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)interval
                             block:(void(^)())block
                           repeats:(BOOL)repeats;

@end

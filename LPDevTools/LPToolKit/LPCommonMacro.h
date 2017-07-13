//
//  LPCommonMacro.h
//  WYJCore
//
//  Created by 李鹏 on 2017/7/11.
//  Copyright © 2017年 WYJ. All rights reserved.
//

#ifndef LPCommonMacro_h
#define LPCommonMacro_h

typedef void (^VoidBlock)(void);
typedef void (^BoolBlock)(BOOL);
typedef void (^StringBlock)(NSString *);
typedef void (^NSArrayBlock)(NSArray *);

#define kScreen_Bounds [UIScreen mainScreen].bounds
#define kScreen_Height CGRectGetHeight([UIScreen mainScreen].bounds)
#define kScreen_Width CGRectGetWidth([UIScreen mainScreen].bounds)
#define kKeyWindow [UIApplication sharedApplication].keyWindow

#ifndef ASLog
#if DEBUG
#define DebugLog(s, ...) NSLog(@"%s(Line %d): %@", __FUNCTION__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])
#else
#define DebugLog(fmt, ...)
#endif
#endif

#define LPWeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
#define LPStrongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak;

//#define kAppleID 934320453

//#define kAppURL [NSString stringWithFormat:@"http://itunes.apple.com/app/id%d?mt=8",kAppleID]
//#define kAppInfoURL [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",kAppleID];

#endif /* LPCommonMacro_h */

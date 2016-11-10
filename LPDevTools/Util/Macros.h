//
//  Macros.h
//  LPDevTools
//
//  Created by lipeng on 16/11/10.
//  Copyright © 2016年 lpdev.com. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

//app专属链接
#define KAppScheme @"AppScheme:"

#define kAppleID 934320453

#define kAppURL [NSString stringWithFormat:@"http://itunes.apple.com/app/id%d?mt=8",kAppleID]
#define kAppInfoURL [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",kAppleID];

#define kScreen_Bounds [UIScreen mainScreen].bounds
#define kScreen_Height CGRectGetHeight([UIScreen mainScreen].bounds)
#define kScreen_Width CGRectGetWidth([UIScreen mainScreen].bounds)
#define kKeyWindow [UIApplication sharedApplication].keyWindow

// Get dispatch_get_main_queue()
#define kMainThread (dispatch_get_main_queue())

// Get default dispatch_get_global_queue
#define kGlobalThread dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

// Fast to get iOS system version
#define kIOSVersion ([UIDevice currentDevice].systemVersion.floatValue)

// More fast way to get app delegate
#define kAppDelegate ((AppDelegate *)[[UIApplication  sharedApplication] delegate])

//版本号
#define kVersion_Coding [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
#define kVersionBuild_Coding [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]

#pragma mark - System Singletons

// More easy way to get user default object.
#define kUserDefaults [NSUserDefaults standardUserDefaults]

// More easy way to get NSNotificationCenter object.
#define kNotificationCenter  [NSNotificationCenter defaultCenter]

// More easy way to get [NSFileManager defaultManager]
#define kFileManager [NSFileManager defaultManager]

// More easy way to post a notification from notification center.
#define kPostNotificationWithName(notificationName) \
[kNotificationCenter postNotificationName:notificationName object:nil userInfo:nil]

// More easy way to post a notification with user info from notification center.
#define kPostNotificationWithNameAndUserInfo(notificationName, userInfo) \
[kNotificationCenter postNotificationName:notificationName object:nil userInfo:userInfo]

#pragma mark - Load Image

// More easy way to load an image.
#define kImage(Name) ([UIImage imageNamed:Name])

// More easy to load an image from file.
#define kImageOfFile(Name) ([UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:Name ofType:nil]])

#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
#define StrongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak;

#ifndef ASLog
#if DEBUG
#define DebugLog(s, ...) NSLog(@"%s(Line %d): %@", __FUNCTION__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])
#else
#define DebugLog(fmt, ...)
#endif
#endif

#endif /* Macros_h */

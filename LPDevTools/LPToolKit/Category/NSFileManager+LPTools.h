//
//  NSFileManager+LPTools.h
//  LPDevTools
//
//  Created by 李鹏 on 2017/10/17.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (LPTools)

+ (NSURL *)documentsURL;

+ (NSString *)documentsPath;

+ (NSURL *)libraryURL;

+ (NSString *)libraryPath;

+ (NSURL *)cachesURL;

+ (NSString *)cachesPath;

@end

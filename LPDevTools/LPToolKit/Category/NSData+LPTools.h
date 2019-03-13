//
//  NSData+LPTools.h
//  LPDevTools
//
//  Created by 李鹏 on 2019/3/12.
//  Copyright © 2019 lpdev.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (LPTools)

+ (NSString *)contentTypeForImageData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END

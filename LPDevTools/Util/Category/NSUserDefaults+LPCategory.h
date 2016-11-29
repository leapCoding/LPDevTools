//
//  NSUserDefaults+LPCategory.h
//  LPTools
//
//  Created by lipeng on 16/8/24.
//  Copyright © 2016年 lpdev.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (LPCategory)

/**
 *	Set safe object to the user defaults, it will filter all nil or Null object,
 *  to prevent app crashing.
 *
 *	@param value				The object to be saved.
 *	@param key          The only key.
 */
- (BOOL)setSafeObject:(id)value forKey:(NSString *)key;

@end

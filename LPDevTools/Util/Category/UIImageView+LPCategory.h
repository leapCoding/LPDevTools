//
//  UIImageView+LPCategory.h
//  LPTools
//
//  Created by lipeng on 16/7/6.
//  Copyright © 2016年 lpdev.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (LPCategory)

- (void) setOnTap:(void(^)())block;

- (void)loadPortrait:(NSURL *)portraitURL;

@end

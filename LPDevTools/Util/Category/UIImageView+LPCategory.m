//
//  UIImageView+LPCategory.m
//  LPTools
//
//  Created by lipeng on 16/7/6.
//  Copyright © 2016年 lpdev.com. All rights reserved.
//

#import "UIImageView+LPCategory.h"
#import "UIImageView+WebCache.h"
#import <objc/runtime.h>

static char overviewKey;

@implementation UIImageView (LPCategory)

- (void)loadPortrait:(NSURL *)portraitURL
{
    [self sd_setImageWithURL:portraitURL placeholderImage:[UIImage imageNamed:@"portrait_loading"] options:0];
}

- (void) setOnTap:(void(^)())block {
    
    [self setBlock:block];
    
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesturePearls =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
    [self addGestureRecognizer:tapGesturePearls];
    
}

- (void)setBlock:(void(^)())block {
    objc_setAssociatedObject (self, &overviewKey,block,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void(^)())block {
    return objc_getAssociatedObject(self, &overviewKey);
}

- (void)onTap {
    void(^block)();
    block = [self block];
    block();
}

@end

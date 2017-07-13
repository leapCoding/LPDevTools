//
//  UIScrollView+LPRefresh.h
//  LPDevTools
//
//  Created by 李鹏 on 2017/7/12.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (LPRefresh)

@property (nonatomic, strong) NSNumber *page_;
@property (nonatomic, strong) NSNumber *pageSize_;

@end

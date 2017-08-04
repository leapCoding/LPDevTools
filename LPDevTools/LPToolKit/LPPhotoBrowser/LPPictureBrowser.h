//
//  LPPictureBrowser.h
//  LPDevTools
//
//  Created by 李鹏 on 2017/8/1.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPPictureBrowser : UIView

/// 所有的图片对象
@property (nonatomic, strong) NSArray *pictures;

/// 当前展示的图片索引
@property (nonatomic, assign) NSUInteger currentPhotoIndex;

- (void)show;

@end

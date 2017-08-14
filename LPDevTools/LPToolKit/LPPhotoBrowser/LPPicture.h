//
//  LPPicture.h
//  LPDevTools
//
//  Created by 李鹏 on 2017/8/2.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPPicture : NSObject

/**    图片所在的imageView    */
@property (nonatomic, strong) UIImageView *imageView;

/**    imageView默认图片 url为空时默认使用placeholderImage   */
@property (nonatomic, strong) UIImage *placeholderImage;

/**    图片的URL    */
@property (nonatomic, copy) NSString *picurl;

/**    图片索引    */
@property (nonatomic, assign) NSInteger index;

@end

//
//  UIImage+LPTools.h
//  WYJCore
//
//  Created by 李鹏 on 2017/7/5.
//  Copyright © 2017年 WYJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LPTools)

/**
 *  view生成图片
 */
+ (UIImage *)imageFromView:(UIView *)view;

/**
 *  根据颜色生成图片
 */
+ (UIImage *)imageWithColor:(UIColor *)aColor;

/**
 *  根据颜色生成指定大小的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame;

/**
 *  获取图片
 */
+ (UIImage *)drawImageWithImageNamed:(NSString *)name;

/**
 *  给图片加文字水印
 */
+ (UIImage *)waterImageWithImage:(UIImage *)image text:(NSString *)text textPoint:(CGPoint)point attributedString:(NSDictionary * )attributed;

/**
 *  给图片加图片水印
 */
+ (UIImage *)waterImageWithImage:(UIImage *)image waterImage:(UIImage *)waterImage waterImageRect:(CGRect)rect;

/**
 *  截取圆形图片
 */
+ (UIImage *)clipCircleImageWithImage:(UIImage *)image circleRect:(CGRect)rect;

/**
 *  截取带边框的圆形图片
 */
+ (UIImage *)clipCircleImageWithImage:(UIImage *)image circleRect:(CGRect)rect borderWidth:(CGFloat)borderW borderColor:(UIColor *)borderColor;

/**
 *  擦除区域的大小位置 
 *  用法[self.wipeImageV.image pq_wipeImageWithView:self.wipeImageV currentPoint:[pan locationInView:self.wipeImageV] size:CGSizeMake(20, 20)];
 */
- (UIImage *)pq_wipeImageWithView:(UIView *)view currentPoint:(CGPoint)nowPoint size:(CGSize)size;

/**
 *  图片裁剪
 */
+ (UIImage *)cutImage:(UIImage *)image size:(CGSize)asize;

/**
 *  图片按给定的比例缩放
 */
-(UIImage *)scaledToSize:(CGSize)size;

/**
 *  修正图片方向
 */
+(UIImage *)rotateImage:(UIImage *)aImage;

/**
 *  压缩图片质量到指定大小（图片会比较清晰）
 */
+ (UIImage *)compressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength;

/**
 *  压缩图片尺寸到指定大小（图片会模糊）
 */
+ (UIImage *)compressImageSize:(UIImage *)image toByte:(NSUInteger)maxLength;

/**
 *  压缩图片 质量和尺寸结合压缩，
 */
+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength;

@end

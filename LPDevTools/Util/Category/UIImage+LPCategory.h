//
//  UIImage+LPCategory.h
//  LPTools
//
//  Created by lipeng on 16/7/5.
//  Copyright © 2016年 lpdev.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LPCategory)

/** 根据颜色生成纯色图片*/
+ (UIImage *)imageWithColor:(UIColor *)color;

/** 取图片某一像素的颜色 */
- (UIColor *)colorAtPixel:(CGPoint)point;

/** 灰度图片 */
- (UIImage *)convertToGrayImage;

/** 纠正图片的方向 */
- (UIImage *)fixOrientation;

/** 按给定的方向旋转图片 */
- (UIImage*)rotate:(UIImageOrientation)orient;

/** 垂直翻转 */
- (UIImage *)flipVertical;

/** 水平翻转 */
- (UIImage *)flipHorizontal;

/** 将图片旋转degrees角度 */
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

/** 将图片旋转radians弧度 */
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;

/** 裁剪图片 */
+ (UIImage *)cutImage:(UIImage*)image size:(CGSize)asize;

/** 压缩图片至指定像素 */
- (UIImage *)rescaleImageToPX:(CGFloat )toPX;

/** 截取当前image对象rect区域内的图像 */
- (UIImage *)subImageWithRect:(CGRect)rect;

/** UIView转化为UIImage */
+ (UIImage *)imageFromView:(UIView *)view;

/** 将两个图片生成一张图片 */
+ (UIImage*)mergeImage:(UIImage*)firstImage withImage:(UIImage*)secondImage;

+ (UIImage *)imageWithContentsOfFileNamed:(NSString *)name;

+ (CGSize)fitSize:(CGSize)thisSize inSize:(CGSize)aSize;

//- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;

@end

//
//  LPPictureCollectionViewCell.m
//  LPDevTools
//
//  Created by 李鹏 on 2017/8/1.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import "LPPictureCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "LPPicture.h"

@interface LPPictureCollectionViewCell ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

// 当前显示图片的控件
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) LPPicture *picture;

@property (nonatomic, assign) BOOL doubleClicks;

@end

@implementation LPPictureCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    /// UIScrollView自带缩放功能，方便实现缩放
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    scrollView.backgroundColor = [UIColor redColor];
    scrollView.showsVerticalScrollIndicator = false;
    scrollView.showsHorizontalScrollIndicator = false;
    scrollView.alwaysBounceVertical = true;
    scrollView.maximumZoomScale = 2;
    scrollView.delegate = self;
    [self.contentView addSubview:scrollView];
    _scrollView = scrollView;
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.clipsToBounds = true;
    imageView.frame = self.bounds;
    imageView.userInteractionEnabled = true;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_scrollView addSubview:imageView];
    _imageView = imageView;
    
    // 添加监听事件
    UITapGestureRecognizer *doubleTapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleClick:)];
    doubleTapGes.numberOfTapsRequired = 2;
    [imageView addGestureRecognizer:doubleTapGes];
    
    UITapGestureRecognizer *sigleTapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sigleClick:)];
    [self.scrollView addGestureRecognizer:sigleTapGes];
    
    [sigleTapGes requireGestureRecognizerToFail:doubleTapGes];
    
}

- (void)refreshCellWithPictures:(LPPicture *)picture showAnim:(BOOL)showAnim {
    _picture = picture;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:picture.picurl] placeholderImage:picture.placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        _imageView.frame = [self getImageActualFrame:[self setPictureSize:image.size]];
        _scrollView.contentSize = _imageView.frame.size;
    }];
    
    if (picture.imageView && showAnim) {
        CGRect newImageViewFrame = [picture.imageView.superview convertRect:picture.imageView.frame toView:[UIApplication sharedApplication].keyWindow];
        self.imageView.frame = newImageViewFrame;
        [UIView animateWithDuration:0.20 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.imageView.frame = [self getImageActualFrame:[self setPictureSize:picture.imageView.image.size]];
        } completion:nil];
    }
    
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGPoint center = _imageView.center;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height) ? (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    center.y = scrollView.contentSize.height * 0.5 + offsetY;
    _imageView.center = center;
    
    // 如果是缩小，保证在屏幕中间
//    if (scrollView.zoomScale < scrollView.minimumZoomScale) {
//        CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width) ? (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
//        center.x = scrollView.contentSize.width * 0.5 + offsetX;
//        _imageView.center = center;
//    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

#pragma mark - 监听方法

- (void)sigleClick:(UITapGestureRecognizer *)ges {
    CGRect oldRect = _picture.imageView.frame;
    CGRect newImageViewFrame = [[UIApplication sharedApplication].keyWindow convertRect:_imageView.frame toView:_picture.imageView.superview];
    _picture.imageView.frame = newImageViewFrame;
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        _picture.imageView.frame = oldRect;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

    
    UIView *view = ges.view;
    [view.superview.superview.superview.superview removeFromSuperview];
}

- (void)doubleClick:(UITapGestureRecognizer *)ges {
    CGFloat newScale = 1.0;
    if (self.scrollView.zoomScale <= 1.0) {
        newScale = 2.0;
    }
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[ges locationInView:ges.view]];
    [self.scrollView zoomToRect:zoomRect animated:YES];
}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center{
    CGRect zoomRect;
    zoomRect.size.height = self.frame.size.height / scale;
    zoomRect.size.width  = self.frame.size.width  / scale;
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    return zoomRect;
}

- (CGSize)setPictureSize:(CGSize)pictureSize {
    if (CGSizeEqualToSize(pictureSize, CGSizeZero)) {
        return pictureSize;
    }
    // 计算实际的大小
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat scale = screenW / pictureSize.width;
    CGFloat height = scale * pictureSize.height;
    return CGSizeMake(screenW, height);
}

- (CGRect)getImageActualFrame:(CGSize)imageSize {
    CGFloat x = 0;
    CGFloat y = 0;
    
    if (imageSize.height < [UIScreen mainScreen].bounds.size.height) {
        y = ([UIScreen mainScreen].bounds.size.height - imageSize.height) / 2;
    }
    return CGRectMake(x, y, imageSize.width, imageSize.height);
}

@end

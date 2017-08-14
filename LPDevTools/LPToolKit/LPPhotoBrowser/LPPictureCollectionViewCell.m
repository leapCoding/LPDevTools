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

@property (nonatomic, assign) CGPoint lastContentOffset;

@property (nonatomic, assign) CGFloat scale;

@property (nonatomic, assign) CGFloat offsetY;

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
    scrollView.backgroundColor = [UIColor clearColor];
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
    
    if (picture.picurl) {
        //网络图片
        [_imageView sd_setImageWithURL:[NSURL URLWithString:picture.picurl] placeholderImage:picture.placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            _imageView.frame = [self getImageActualFrame:[self setPictureSize:image.size]];
            _scrollView.contentSize = _imageView.frame.size;
        }];
    }else {
        //本地图片
        _imageView.image = picture.placeholderImage;
        _imageView.frame = [self getImageActualFrame:[self setPictureSize:picture.placeholderImage.size]];
        _scrollView.contentSize = _imageView.frame.size;
    }
    
    //第一次显示放大动画效果
    if (picture.imageView && showAnim) {
        CGRect newImageViewFrame = [picture.imageView.superview convertRect:picture.imageView.frame toView:[UIApplication sharedApplication].keyWindow];
        self.imageView.frame = newImageViewFrame;
        [UIView animateWithDuration:0.20 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.imageView.frame = [self getImageActualFrame:[self setPictureSize:picture.imageView.image.size]];
        } completion:nil];
    }
}

//图片滑出界面时取消放大效果
- (void)collectionViewDidEndDisplayCell {
    if (self.scrollView.zoomScale > 1.0) {
        CGRect zoomRect = [self zoomRectForScale:1.0 withCenter:CGPointMake(0, 0)];
        [self.scrollView zoomToRect:zoomRect animated:YES];
    }
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGPoint center = _imageView.center;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height) ? (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    center.y = scrollView.contentSize.height * 0.5 + offsetY;
    _imageView.center = center;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    self.lastContentOffset = scrollView.contentOffset;
    // 保存 offsetY
    _offsetY = scrollView.contentOffset.y;

    // 正在动画
    if ([self.imageView.layer animationForKey:@"transform"] != nil) {
        return;
    }
    // 用户正在缩放
    if (_scrollView.zoomBouncing || _scrollView.zooming) {
        return;
    }

    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    if (_scrollView.contentSize.height > screenH) {
        // 代表没有滑动到底部
        if (_scrollView.contentOffset.y > 0 && _scrollView.contentOffset.y <= _scrollView.contentSize.height - screenH) {
            return;
        }
    }
    
    _scale = fabs(_lastContentOffset.y) / screenH;
    
    // 如果内容高度 > 屏幕高度
    // 并且偏移量 > 内容高度 - 屏幕高度
    // 那么就代表滑动到最底部了
    if (_scrollView.contentSize.height > screenH && _scrollView.contentOffset.y > _scrollView.contentSize.height - screenH) {
        _scale = (_scrollView.contentOffset.y - (_scrollView.contentSize.height - screenH)) / screenH;
    }
    
    // 条件1：拖动到顶部再继续往下拖.
    // 条件2：拖动到顶部再继续往上拖
    // 两个条件都满足才去设置 scale -> 针对于长图
    if (_scrollView.contentSize.height > screenH) {
        if (_scrollView.contentOffset.y < 0 || _scrollView.contentOffset.y > _scrollView.contentSize.height - screenH) {
            [_delegate pictureCell:self scale:_scale];
        }
    }else {
        [_delegate pictureCell:self scale:_scale];
    }
    
    //如果用户松手
    if (scrollView.dragging == false) {
        if (_scale > 0.15 && _scale <= 1) {
            //关闭图片
            [self sigleClick:[self.scrollView.gestureRecognizers firstObject]];
            
            [scrollView setContentOffset:_lastContentOffset animated:false];
        }
    }
}

- (void)setLastContentOffset:(CGPoint)lastContentOffset {
    // 如果用户没有在拖动，并且绽放比 > 0.15
    if (!(_scrollView.dragging == false && _scale > 0.15)) {
        _lastContentOffset = lastContentOffset;
    }
}

#pragma mark - 监听方法

- (void)sigleClick:(UITapGestureRecognizer *)ges {
    UIView *bottomView = ges.view.superview.superview.superview;
    
    CGRect oldRect = _picture.imageView.frame;
    if (_scrollView.contentOffset.x != 0 || _scrollView.contentOffset.y != 0) {
        oldRect = CGRectMake(oldRect.origin.x + _scrollView.contentOffset.x, oldRect.origin.y + _scrollView.contentOffset.y, oldRect.size.width, oldRect.size.height);
    }
//    CGRect newImageViewFrame = [[UIApplication sharedApplication].keyWindow convertRect:_imageView.frame toView:_picture.imageView.superview];
//    _picture.imageView.frame = newImageViewFrame;
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
//        _picture.imageView.frame = oldRect;
        _imageView.frame = oldRect;
        bottomView.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [bottomView.superview removeFromSuperview];
    }];
}

- (void)doubleClick:(UITapGestureRecognizer *)ges {
    CGFloat newScale = 1.0;
    if (self.scrollView.zoomScale <= 1.0) {
        newScale = 2.0;
    }
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[ges locationInView:ges.view]];
    [self.scrollView zoomToRect:zoomRect animated:YES];
}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
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

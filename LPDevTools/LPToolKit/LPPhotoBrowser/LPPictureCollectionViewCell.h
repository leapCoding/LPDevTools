//
//  LPPictureCollectionViewCell.h
//  LPDevTools
//
//  Created by 李鹏 on 2017/8/1.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const LPPictureCollectionViewCellKey = @"LPPictureCollectionViewCell";

@class LPPictureCollectionViewCell;
@protocol LPPictureCollectionViewCellDelegate <NSObject>

- (void)pictureCell:(LPPictureCollectionViewCell *)pictureCell scale:(CGFloat)scale;

@end

@class LPPicture;
@interface LPPictureCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) id<LPPictureCollectionViewCellDelegate>delegate;

- (void)refreshCellWithPictures:(LPPicture *)picture showAnim:(BOOL)showAnim;

- (void)collectionViewDidEndDisplayCell;

@end

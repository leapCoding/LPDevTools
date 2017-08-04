//
//  LPPictureCollectionViewCell.h
//  LPDevTools
//
//  Created by 李鹏 on 2017/8/1.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const LPPictureCollectionViewCellKey = @"LPPictureCollectionViewCell";

@class LPPicture;
@interface LPPictureCollectionViewCell : UICollectionViewCell

- (void)refreshCellWithPictures:(LPPicture *)picture showAnim:(BOOL)showAnim;

@end

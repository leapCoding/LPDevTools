//
//  LPSlideBarItem.h
//  LPDevTools
//
//  Created by 李鹏 on 2017/9/5.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LPSlideBarItemDelegate;

@interface LPSlideBarItem : UIView

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, weak) id<LPSlideBarItemDelegate> delegate;

- (void)setItemTitle:(NSString *)title;
- (void)setItemTitleFont:(UIFont *)font;
- (void)setItemTitleColor:(UIColor *)color;
- (void)setItemSelectedTileFont:(UIFont *)font;
- (void)setItemSelectedTitleColor:(UIColor *)color;

+ (CGFloat)widthForTitle:(NSString *)title;

@end

@protocol LPSlideBarItemDelegate <NSObject>

- (void)slideBarItemSelected:(LPSlideBarItem *)item;

@end

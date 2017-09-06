//
//  LPSlideBar.h
//  LPDevTools
//
//  Created by 李鹏 on 2017/9/5.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LPSlideBarItemSelectedCallback)(NSUInteger idx);

@interface LPSlideBar : UIView

// All the titles of LPSilderBar
@property (nonatomic, copy) NSArray *itemsTitle;

// Default is false
@property (nonatomic, assign) BOOL showRightButton;

// All the item's text color of the normal state
@property (nonatomic, strong) UIColor *itemColor;

// The selected item's text color
@property (nonatomic, strong) UIColor *itemSelectedColor;

// All the item's text size of the normal state
@property (nonatomic, strong) UIFont *itemFont;

// The selected item's text size
@property (nonatomic, strong) UIFont *itemSelectedFont;

// The slider color
@property (nonatomic, strong) UIColor *sliderColor;

@property (nonatomic, assign) CGFloat scrollViewSpacing;

// Add the callback deal when a slide bar item be selected
- (void)slideBarItemSelectedCallback:(LPSlideBarItemSelectedCallback)callback;

// Set the slide bar item at index to be selected
- (void)selectSlideBarItemAtIndex:(NSUInteger)index;

- (void)moveIndexWithProgress:(float)propress;

@end

//
//  UIView+HUD.h
//  LPDevTools
//
//  Created by lipeng on 16/11/25.
//  Copyright © 2016年 lpdev.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HUD)

- (void)showLoadHUD;

- (void)showLoadHUDTitle:(NSString *)string;

- (void)showTip:(NSString *)string;

- (void)hideHUD;

@end

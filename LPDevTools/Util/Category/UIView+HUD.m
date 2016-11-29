//
//  UIView+HUD.m
//  LPDevTools
//
//  Created by lipeng on 16/11/25.
//  Copyright © 2016年 lpdev.com. All rights reserved.
//

#import "UIView+HUD.h"
#import "MBProgressHUD.h"

@implementation UIView (HUD)

- (void)showLoadHUD {
    [self showLoadHUDTitle:@""];
}

- (void)showLoadHUDTitle:(NSString *)string {
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.contentColor = [UIColor whiteColor];
        hud.bezelView.color = [[UIColor blackColor]colorWithAlphaComponent:0.9];
        hud.label.text = string;
    });
}

- (void)showTip:(NSString *)string {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    // Set the annular determinate mode to show task progress.
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = string;
    [hud hideAnimated:YES afterDelay:2.f];
}

- (void)hideHUD {
    [MBProgressHUD hideHUDForView:self animated:YES];
}


@end

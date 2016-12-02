//
//  AppDelegate.h
//  MACProject
//
//  Created by MacKun on 15/9/10.
//  Copyright (c) 2015年 MacKun. All rights reserved.
//

#import "AppleSystemService.h"

@implementation AppleSystemService

+ (void)directPhoneCallWithPhoneNum:(NSString *)phoneNum {
    
    NSURL *url = [NSURL URLWithString:[@"tel:" stringByAppendingString:phoneNum]];
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
}

+ (void)phoneCallWithPhoneNum:(NSString *)phoneNum contentView:(UIView *)view {
    
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[@"tel:" stringByAppendingString:phoneNum]]]];
    [view addSubview:callWebview];
}

+ (void)jumpToAppReviewPageWithAppId:(NSString *)appId {

    NSURL *url = [NSURL URLWithString:[@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=" stringByAppendingString:appId]];
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
}

+ (void)sendEmailToAddress:(NSString *)address {
    NSURL *url = [NSURL URLWithString:[@"mailto://" stringByAppendingString:address]];
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
}

+ (UIImage *)launchImage {

    UIImage               *lauchImage      = nil;
    NSString              *viewOrientation = nil;
    CGSize                 viewSize        = [UIScreen mainScreen].bounds.size;
    UIInterfaceOrientation orientation     = [[UIApplication sharedApplication] statusBarOrientation];
    
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        
        viewOrientation = @"Landscape";
        
    } else {
    
        viewOrientation = @"Portrait";
    }
    
    NSArray *imagesDictionary = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary *dict in imagesDictionary) {
        
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
        
            lauchImage = [UIImage imageNamed:dict[@"UILaunchImageName"]];
        }
    }

    return lauchImage;
}

@end

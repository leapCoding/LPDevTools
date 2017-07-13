//
//  LPVersionManager.m
//  WYJCore
//
//  Created by 李鹏 on 2017/7/12.
//  Copyright © 2017年 WYJ. All rights reserved.
//
#define kVersion @"version"

#import "LPVersionManager.h"
#import "LPAPPKeyConfig.h"
#import "LPAPPConfig.h"
#import "UIApplication+LPTools.h"

@implementation LPVersionManager

+ (instancetype)shareManager {
    static LPVersionManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (void)start {
    NSString *appstoreUrlStr = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",@([LPAPPKeyConfig sharedInstance].appId)];
    NSString *appVersion = [UIApplication sharedApplication].appVersion;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:appstoreUrlStr]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSArray *results = dic[@"results"];
        if (!results) return ;
        NSDictionary *finalDict = [results firstObject];
        NSString *version = finalDict[@"version"];
        
        //拿本地保存的版本号和当前版本号相比，不一样就重置版本提示次数
        if (![[[NSUserDefaults standardUserDefaults] objectForKey:kVersion] isEqualToString:appVersion]) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[LPAPPConfig firstUpdateKey]];
        }
        //只提示一次
        if (![[[NSUserDefaults standardUserDefaults]  objectForKey:[LPAPPConfig firstUpdateKey]]boolValue]) return;
        
        if ([appVersion compare:version] == NSOrderedAscending) {
            //            UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"更新" message:@"有新版本需要更新，是否更新！" cancelButtonItem:[RIButtonItem itemWithLabel:@"取消" action:^(){}] otherButtonItems:[RIButtonItem itemWithLabel:@"更新" action:^(){
            //                NSString *urlstr = [NSString stringWithFormat:@"https://itunes.apple.com/app/id%@",KWYJAppId];
            //                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlstr]];
            //            }], nil];
            //            [aler show];
            
            
            [[NSUserDefaults standardUserDefaults] setObject:appVersion forKey:kVersion];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:[LPAPPConfig firstUpdateKey]];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }];
}


@end

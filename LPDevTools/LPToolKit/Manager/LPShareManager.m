//
//  LPShareManager.m
//  LPDevTools
//
//  Created by 李鹏 on 2017/7/12.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import "LPShareManager.h"
#import <UMSocialCore/UMSocialCore.h>
#import "LPAPPKeyConfig.h"

@implementation LPShareManager

+ (instancetype)shareManager {
    static LPShareManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (void)lp_registerApp {
    /* 打开日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    //    [UMSocialGlobal shareInstance].isClearCacheWhenGetUserInfo = NO;
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:[LPAPPKeyConfig sharedInstance].umengKey];
    
    [self configUSharePlatforms];
}

- (void)configUSharePlatforms {
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:[LPAPPKeyConfig sharedInstance].wxKey appSecret:[LPAPPKeyConfig sharedInstance].wxSecret redirectURL:@"http://mobile.umeng.com/social"];
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     100424468.no permission of union id
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:[LPAPPKeyConfig sharedInstance].qqId/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];

    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:[LPAPPKeyConfig sharedInstance].sinaKey  appSecret:[LPAPPKeyConfig sharedInstance].sinaSecret redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
}

- (BOOL)lp_handleOpenURL:(NSURL *)url {
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    return result;
}

- (BOOL)lp_openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    return result;
}

- (BOOL)lp_openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    return result;
}

- (void)shareToPlatformType:(SharePlatformType)platformType {
    NSArray *platforms = @[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ)];
    
    NSString *title = @"我正在使用519真.快，高档白酒应有尽有！";
    NSString *descr = @"519真.快聚焦高端白酒市场、真品保证、价格实惠、送货便捷（15分钟到货）";
    NSString *url = @"http://app.mall519.com/download/";
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UIImage *thumImage = [UIImage imageNamed:@"icon_logo"];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:descr thumImage:thumImage];
    //设置网页地址
    shareObject.webpageUrl = url;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:[platforms[platformType] integerValue] messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        [self alertWithError:error PlatformType:platformType];
    }];
}

//分享回调
- (void)sharedCallBack:(SharePlatformType)platformType {
    
//    [WYJApiManager postUrl:WYJAPIMethod_SharedCallBack parameters:@{@"ShareType":@(platformType)} className:nil responseBlock:^(LPNetWorkResponse *response) {
//        NSArray *array = [response isSuccess]? @[@"取消",@"去查看"] : @[@"确定"];
//        [[WYJPopViewManager shareInstance] showTipViewTitle:@"分享成功" content:response.message items:array block:^(NSInteger index) {
//            if (index == 1) {
//                [WYJJumpManager jump2Controller:@{@"page":@"WYJMyCouponViewController"} popOther:YES];
//            }
//            [[WYJPopViewManager shareInstance]hide];
//        }];
//    }];
}

- (void)alertWithError:(NSError *)error PlatformType:(SharePlatformType)platformType
{
    NSString *result = nil;
    if (!error) {
//        [self sharedCallBack:platformType];
        return;
    }
    else{
        NSMutableString *str = [NSMutableString string];
        if (error.userInfo) {
            for (NSString *key in error.userInfo) {
                [str appendFormat:@"%@\n",error.userInfo[key]];
            }
        }
        if (error) {
            result = [NSString stringWithFormat:@"%@",str];
        }
        else{
            result = [NSString stringWithFormat:@"分享失败"];
        }
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享"
                                                    message:result
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    //    [alert show];
}


@end

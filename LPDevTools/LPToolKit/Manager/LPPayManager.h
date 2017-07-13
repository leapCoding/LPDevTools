//
//  LPPayManager.h
//  LPDevTools
//
//  Created by 李鹏 on 2017/7/12.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WYJWECHATURLNAME @"weixin"
#define WYJALIPAYURLNAME @"zhifubao"

/**
 *  回调状态
 */
typedef NS_ENUM(NSInteger, PayErrCode){
    PayErrCodeSuccess,//成功
    PayErrCodeFailure,//失败
    PayErrCodeCancel//取消
};

typedef void(^LPCompleteCallBack)(PayErrCode errCode,NSString *errStr);

@interface LPPayManager : NSObject

/**
 *  单例管理
 */
+ (instancetype)shareManager;
/**
 *  检测是否安装微信客户端
 */
- (BOOL)WXAppInstalled;
/**
 *  处理跳转url，回到应用，需要在delegate中实现
 */
- (BOOL)lp_handleUrl:(NSURL *)url;
/**
 *  注册App，需要在 didFinishLaunchingWithOptions 中调用
 */
- (void)lp_registerApp;
/**
 *  发起支付
 *
 * @param orderMessage 传入订单信息,如果是字符串，则对应是跳转支付宝支付；如果传入PayReq 对象，这跳转微信支付,注意，不能传入空字符串或者nil
 * @param callBack     回调，有返回状态信息
 */
- (void)lp_payWithOrderMessage:(id)orderMessage callBack:(LPCompleteCallBack)callBack;

@end

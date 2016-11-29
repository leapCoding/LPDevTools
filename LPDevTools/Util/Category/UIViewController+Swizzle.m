//
//  UIViewController+Swizzle.m
//  Coding_iOS
//
//  Created by 王 原闯 on 14-8-1.
//  Copyright (c) 2014年 Coding. All rights reserved.
//
#import "UIViewController+Swizzle.h"
#import "ObjcRuntime.h"
//#import <RDVTabBarController/RDVTabBarController.h>


@implementation UIViewController (Swizzle)

- (void)runtimePush:(NSDictionary *)params {
    // 类名
    NSString *class =[NSString stringWithFormat:@"%@", params[@"class"]]; const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
    // 从一个字串返回一个类
    Class newClass = objc_getClass(className); if (!newClass) {
        // 创建一个类
        Class superClass = [NSObject class];
        newClass = objc_allocateClassPair(superClass, className, 0);
        // 注册你创建的这个类
        objc_registerClassPair(newClass); }
    // 创建对象
    id instance = [[newClass alloc] init];
    // 对该对象赋值属性
    NSDictionary * propertys = params[@"property"];
    [propertys enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        // 检测这个对象是否存在该属性
        if ([self checkIsExistPropertyWithInstance:instance verifyPropertyName:key]) {
            // 利用kvc赋值
            [instance setValue:obj forKey:key];
        }
    }];
    // 跳转到对应的控制器
    [self.navigationController pushViewController:instance animated:YES];
}

/**
 *  检测对象是否存在该属性
 */
- (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName { unsigned int outCount, i;
    
    // 获取对象里的属性列表
    objc_property_t * properties = class_copyPropertyList([instance
                                                           class], &outCount);
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property =properties[i];
        //  属性名转成字符串
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        // 判断该属性是否存在
        if ([propertyName isEqualToString:verifyPropertyName]) {
            free(properties);
            return YES;
        }
    }
    free(properties);
    
    return NO;
}
    
//- (void)customViewDidAppear:(BOOL)animated{
//    if ([NSStringFromClass([self class]) rangeOfString:@"AFCProjectViewController"].location != NSNotFound) {
//        [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
//        DebugLog(@"setTabBarHidden:NO --- customViewDidAppear : %@", NSStringFromClass([self class]));
//    }
//    [self customViewDidAppear:animated];
//}

- (void)customViewWillDisappear:(BOOL)animated{
//    返回按钮
//    if (!self.navigationItem.backBarButtonItem
//        && self.navigationController.viewControllers.count > 1) {//设置返回按钮(backBarButtonItem的图片不能设置；如果用leftBarButtonItem属性，则iOS7自带的滑动返回功能会失效)
//        self.navigationItem.backBarButtonItem = [self backButton];
//    }
    [self customViewWillDisappear:animated];
}

- (void)customviewWillAppear:(BOOL)animated{
//    if ([[self.navigationController childViewControllers] count] > 1) {
//        [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
//    }else {
//        [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
//    }
//    DebugLog(@"customviewWillAppear : %@", NSStringFromClass([self class]));
    [self customviewWillAppear:animated];
}

- (void)customDealloc {
    DebugLog(@"--- customDealloc : %@", NSStringFromClass([self class]));
}


#pragma mark BackBtn M
- (UIBarButtonItem *)backButton{
    NSDictionary*textAttributes;
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title = @"返回";
    temporaryBarButtonItem.target = self;
    if ([temporaryBarButtonItem respondsToSelector:@selector(setTitleTextAttributes:forState:)]){
        textAttributes = @{
//                           NSFontAttributeName: [UIFont boldSystemFontOfSize:kBackButtonFontSize],
                           NSForegroundColorAttributeName: [UIColor whiteColor],
                           };
        
        [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    }
    temporaryBarButtonItem.action = @selector(goBack_Swizzle);
    return temporaryBarButtonItem;
}

- (void)goBack_Swizzle
{
    [self.navigationController popViewControllerAnimated:YES];
}

+ (void)load{
    swizzleAllViewController();
}
@end

void swizzleAllViewController()
{
//    Swizzle([UIViewController class], @selector(viewDidAppear:), @selector(customViewDidAppear:));
    Swizzle([UIViewController class], @selector(viewWillDisappear:), @selector(customViewWillDisappear:));
    Swizzle([UIViewController class], @selector(viewWillAppear:), @selector(customviewWillAppear:));
//    Swizzle([UIViewController class], NSSelectorFromString(@"dealloc"), @selector(customDealloc));
}

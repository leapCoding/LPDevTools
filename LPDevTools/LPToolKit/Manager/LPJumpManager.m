//
//  LPJumpManager.m
//  WYJCore
//
//  Created by 李鹏 on 2017/7/11.
//  Copyright © 2017年 WYJ. All rights reserved.
//

#import "LPJumpManager.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "UIViewController+LPTools.h"
#import "NSString+LPTools.h"

@interface LPJumpManager ()

@property (nonatomic, copy) NSString *className;
@property (nonatomic, strong) NSDictionary *property;

@end

@implementation LPJumpManager

- (instancetype)initWithDictionary:(NSDictionary *)data{
    if (self = [super init]) {
        NSString *page = [NSString isEmpty:data[@"page"]] ? @"" : data[@"page"];
        self.className = [page stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSDictionary *property = data[@"property"];
        if ([property isKindOfClass:[NSDictionary class]]) {
            self.property = property;
        }
        
    }
    return self;
}

+ (void)jumpToController:(NSDictionary *)params popOther:(BOOL)pop {
    if (params == nil || ![params isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    LPJumpManager *manager = [[LPJumpManager alloc] initWithDictionary:params];
    id instance = [self createViewController:manager];
    
    if (![instance isKindOfClass:[UIViewController class]]) {
        return;
    }
    
    UINavigationController *pushClassStance = [UIViewController topViewController].navigationController;
    if (pop) {
        [pushClassStance setViewControllers:@[[pushClassStance.viewControllers firstObject], instance] animated:YES];
    }else{
        [pushClassStance pushViewController:instance animated:YES];
    }
}

+ (void)jumpToController:(NSDictionary *)params {
    [self jumpToController:params popOther:NO];
}

+ (id)createViewController:(LPJumpManager *)manager {
    NSString *class = manager.className;
    const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
    
    Class newClass = objc_getClass(className);
    if (!newClass)
    {
        Class superClass = [NSObject class];
        newClass = objc_allocateClassPair(superClass, className, 0);
        objc_registerClassPair(newClass);
    }
    id instance = [[newClass alloc] init];
    
    NSDictionary *propertys = manager.property;
    [propertys enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([self checkIsExistPropertyWithInstance:instance verifyPropertyName:key]) {
            [instance setValue:obj forKey:key];
        }
    }];
    
    return instance;
}


+ (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName
{
    unsigned int outCount, i;
    
    objc_property_t * properties = class_copyPropertyList([instance
                                                           class], &outCount);
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        
        if ([propertyName isEqualToString:verifyPropertyName]) {
            free(properties);
            return YES;
        }
    }
    free(properties);
    
    return NO;
}


@end

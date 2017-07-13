//
//  LPDataStoreManager.h
//  LPDevTools
//
//  Created by 李鹏 on 2017/7/12.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPDataStoreManager : NSObject

+ (instancetype)shareManager;

- (void)storeHistoryData:(NSMutableArray *)searchs;

- (NSArray *)getHistoryData;

- (void)removeHistorys;

@end

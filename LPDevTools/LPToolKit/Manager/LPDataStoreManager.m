//
//  LPDataStoreManager.m
//  LPDevTools
//
//  Created by 李鹏 on 2017/7/12.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import "LPDataStoreManager.h"
#import "YTKKeyValueStore.h"

@interface LPDataStoreManager ()

@property (nonatomic, strong) YTKKeyValueStore *keyValueStore;

@end

@implementation LPDataStoreManager

+ (instancetype)shareManager {
    static LPDataStoreManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _keyValueStore = [[YTKKeyValueStore alloc]initDBWithName:@"WYJAgents.db"];
        [_keyValueStore createTableWithName:@"histtory_Table"];
    }
    return self;
}

- (void)storeHistoryData:(NSMutableArray *)searchs {
    if (searchs.count>5) {
        [searchs removeLastObject];
    }
    NSString *keyID = [NSString stringWithFormat:@"%@",@""];
    [_keyValueStore putObject:searchs withId:keyID intoTable:@"histtory_Table"];
}

- (NSArray *)getHistoryData {
    NSString *keyID = [NSString stringWithFormat:@"%@",@""];
    NSArray *array = [_keyValueStore getObjectById:keyID fromTable:@"histtory_Table"];
    return array;
}

- (void)removeHistorys {
    NSString *keyID = [NSString stringWithFormat:@"%@",@""];
    [_keyValueStore deleteObjectById:keyID fromTable:@"histtory_Table"];
}


@end

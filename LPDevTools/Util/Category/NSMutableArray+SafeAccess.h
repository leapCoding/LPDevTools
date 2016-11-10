//
//  NSMutableArray+SafeAccess.h
//  LPDevTools
//
//  Created by lipeng on 16/10/28.
//  Copyright © 2016年 lpdev.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (SafeAccess)

- (id)lp_objectAtIndex:(NSUInteger)index;
- (void)lp_addObject:(id)anObject;
- (void)lp_insertObject:(id)anObject atIndex:(NSUInteger)index;
- (void)lp_removeObjectAtIndex:(NSUInteger)index;
- (void)lp_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

@end

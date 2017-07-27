//
//  NSArray+SIXCheck.m
//  testIM
//
//  Created by li’Pro on 2017/7/27.
//  Copyright © 2017年 6room. All rights reserved.
//

#import "NSArray+SIXCheck.h"

@implementation NSArray (SIXCheck)

/**
 * 检测 index 是否越界，越界返回 nil
 */
- (id)objectCheckAtIndex:(NSUInteger)index {
    if (index < self.count) {
        return [self objectAtIndex:index];
    }
    return nil;
}

@end

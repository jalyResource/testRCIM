//
//  NSArray+SIXCheck.h
//  testIM
//
//  Created by li’Pro on 2017/7/27.
//  Copyright © 2017年 6room. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (SIXCheck)
/**
 * 检测 index 是否越界，越界返回 nil
 */
- (id)objectCheckAtIndex:(NSUInteger)index ;

@end

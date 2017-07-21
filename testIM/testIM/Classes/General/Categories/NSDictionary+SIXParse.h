//
//  NSDictionary+SIXParse.h
//  testIM
//
//  Created by li’Pro on 2017/7/21.
//  Copyright © 2017年 wzl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SIXParse)

- (NSString *)parseStringWithKey:(NSString *)key ;

- (NSInteger)parseIntegerWithKey:(NSString *)key ;

@end

//
//  NSDictionary+SIXParse.m
//  testIM
//
//  Created by li’Pro on 2017/7/21.
//  Copyright © 2017年 wzl. All rights reserved.
//

#import "NSDictionary+SIXParse.h"

@implementation NSDictionary (SIXParse)

- (NSString *)parseStringWithKey:(NSString *)key {
    id obj = [self valueForKey:key];
    if ( [NSNull null] == obj) {
        return nil;
    }
    if ( [obj isKindOfClass:[NSNumber class]] ) {
        return [obj stringValue];
    }
    
    return obj;
}

- (NSInteger)parseIntegerWithKey:(NSString *)key {
    id obj = [self valueForKey:key];
    
    if ( [NSNull null] == obj) {
        return 0;
    }
    
    return [obj integerValue];
}

@end

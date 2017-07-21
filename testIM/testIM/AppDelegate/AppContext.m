//
//  AppContext.m
//  testIM
//
//  Created by li’Pro on 2017/7/20.
//  Copyright © 2017年 wzl. All rights reserved.
//

#import "AppContext.h"


#define RONGCLOUD_IM_APPKEY @"n19jmcy59f1q9" //online key

@implementation AppContext

+ (void)setUpDidFinishLaunchingWithOptions {
    [[RCIM sharedRCIM]initWithAppKey:RONGCLOUD_IM_APPKEY];
}

@end

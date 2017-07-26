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
    [self setUpRCIM];
}
+ (void)setUpRCIM {
    [[RCIM sharedRCIM]initWithAppKey:RONGCLOUD_IM_APPKEY];
    
    //设置用户信息源和群组信息源
    [RCIM sharedRCIM].userInfoDataSource = SHAREIMDataSource;
    [RCIM sharedRCIM].groupInfoDataSource = SHAREIMDataSource;
    [RCIM sharedRCIM].groupUserInfoDataSource = SHAREIMDataSource;
    [RCIM sharedRCIM].groupMemberDataSource = SHAREIMDataSource;
    [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
    //设置名片消息功能中联系人信息源和群组信息源
//    [RCContactCardKit shareInstance].contactsDataSource = SHAREIMDataSource;
//    [RCContactCardKit shareInstance].groupDataSource = SHAREIMDataSource;
    
    // 自定义消息类型
    [[RCIM sharedRCIM] registerMessageType:[SIXTipMessageContent class]];
    [[RCIM sharedRCIM] registerMessageType:[SIXProductMessageContent class]];

    
    
}

@end

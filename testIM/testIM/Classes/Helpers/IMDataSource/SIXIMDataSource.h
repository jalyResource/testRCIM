//
//  SIXIMDataSource.h
//  testIM
//
//  Created by li’Pro on 2017/7/24.
//  Copyright © 2017年 6room. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RongCloudIM/RongIMKit/RCIM.h>

#define SHAREIMDataSource [SIXIMDataSource shareIMDataSource]

@interface SIXIMDataSource : NSObject<
    RCIMUserInfoDataSource, RCIMGroupInfoDataSource, RCIMGroupUserInfoDataSource, RCIMGroupMemberDataSource
>

+ (instancetype)shareIMDataSource ;

@end

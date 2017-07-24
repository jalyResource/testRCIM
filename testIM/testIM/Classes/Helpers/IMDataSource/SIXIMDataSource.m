//
//  SIXIMDataSource.m
//  testIM
//
//  Created by li’Pro on 2017/7/24.
//  Copyright © 2017年 6room. All rights reserved.
//

#import "SIXIMDataSource.h"

@implementation SIXIMDataSource

+ (instancetype)shareIMDataSource {
    static SIXIMDataSource *ins = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ins = [[SIXIMDataSource alloc] init];
    });
    
    return ins;
}

#pragma -mark 
#pragma -mark RCIMUserInfoDataSource
/*!
 获取用户信息
 
 @param userId      用户ID
 @param completion  获取用户信息完成之后需要执行的Block [userInfo:该用户ID对应的用户信息]
 
 @discussion SDK通过此方法获取用户信息并显示，请在completion中返回该用户ID对应的用户信息。
 在您设置了用户信息提供者之后，SDK在需要显示用户信息的时候，会调用此方法，向您请求用户信息用于显示。
 */
- (void)getUserInfoWithUserId:(NSString *)userId
                   completion:(void (^)(RCUserInfo *userInfo))completion {
    NSString *ID = [[SIXUserManager shareUserManager] getDefaultUserId];
    NSString *name = [[SIXUserManager shareUserManager] getDefaultName];
    NSString *portrait = [[SIXUserManager shareUserManager] getDefaultPortrait];
    RCUserInfo *u = [[RCUserInfo alloc] initWithUserId:ID name:name portrait:portrait];
    completion(u);
}



#pragma -mark 
#pragma -mark RCIMGroupInfoDataSource
/*!
 获取群组信息
 
 @param groupId     群组ID
 @param completion  获取群组信息完成之后需要执行的Block [groupInfo:该群组ID对应的群组信息]
 
 @discussion SDK通过此方法获取用户信息并显示，请在completion的block中返回该用户ID对应的用户信息。
 在您设置了用户信息提供者之后，SDK在需要显示用户信息的时候，会调用此方法，向您请求用户信息用于显示。
 */
- (void)getGroupInfoWithGroupId:(NSString *)groupId
                     completion:(void (^)(RCGroup *groupInfo))completion {
    
}



@end



























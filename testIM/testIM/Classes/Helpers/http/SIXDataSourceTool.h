//
//  SIXDataSourceTool.h
//  testIM
//
//  Created by li’Pro on 2017/7/24.
//  Copyright © 2017年 6room. All rights reserved.
//  封装获取用户、群组信息

#import <Foundation/Foundation.h>

@interface SIXDataSourceTool : NSObject

/**
 * 根据userId获取单个用户信息
 */
+ (void)getUserInfoByUserID:(NSString *)userID completion:(void (^)(RCUserInfo *user))completion ;

/**
 * 根据id获取单个群组
 */
+ (void)getGroupByID:(NSString *)groupID successCompletion:(void (^)(RCGroup *group))completion ;

@end

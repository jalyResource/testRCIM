//
//  SIXDataSourceTool.h
//  testIM
//
//  Created by li’Pro on 2017/7/24.
//  Copyright © 2017年 6room. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SIXDataSourceTool : NSObject

/**
 * 根据userId获取单个用户信息
 */
+ (void)getUserInfoByUserID:(NSString *)userID completion:(void (^)(RCUserInfo *user))completion ;

@end

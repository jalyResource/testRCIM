//
//  SIXDataSourceTool.m
//  testIM
//
//  Created by li’Pro on 2017/7/24.
//  Copyright © 2017年 6room. All rights reserved.
//

#import "SIXDataSourceTool.h"

@implementation SIXDataSourceTool

/**
 * 根据userId获取单个用户信息
 */
+ (void)getUserInfoByUserID:(NSString *)userID completion:(void (^)(RCUserInfo *user))completion {

    [AFHttpTool getUserInfo:userID success:^(id response) {
        if (response) {
            NSString *code = [NSString stringWithFormat:@"%@", response[@"code"]];
            if ([code isEqualToString:@"200"]) {
                NSDictionary *dic = response[@"result"];
                RCUserInfo *user = [RCUserInfo new];
                user.userId = dic[@"id"];
                user.name = [dic objectForKey:@"nickname"];
                user.portraitUri = [dic objectForKey:@"portraitUri"];
                if (!user.portraitUri || user.portraitUri.length <= 0) {
                    user.portraitUri = @"";
                }
                
                if (completion) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(user);
                    });
                }
            } else {
                RCUserInfo *user = [RCUserInfo new];
                user.userId = userID;
                user.name = [NSString stringWithFormat:@"name%@", userID];
                user.portraitUri = @"";
                
                if (completion) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(user);
                    });
                }
            }
        } else {
            RCUserInfo *user = [RCUserInfo new];
            user.userId = userID;
            user.name = [NSString stringWithFormat:@"name%@", userID];
            user.portraitUri = @"";
            
            if (completion) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(user);
                });
            }
        }
    } failure:^(NSError *err) {
        ;
    }];
}






@end

























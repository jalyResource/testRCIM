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

/**
 * 根据id获取单个群组
 */
+ (void)getGroupByID:(NSString *)groupID successCompletion:(void (^)(RCGroup *group))completion {
    [AFHttpTool getGroupByID:groupID
                     success:^(id response) {
                         NSString *code = [NSString stringWithFormat:@"%@", response[@"code"]];
                         NSDictionary *result = response[@"result"];
                         if (result && [code isEqualToString:@"200"]) {
                             
                             NSString *groupId = [result objectForKey:@"id"];
                             NSString *groupName = [result objectForKey:@"name"];
                             NSString *portraitUri = [result objectForKey:@"portraitUri"];
                             if (!portraitUri || portraitUri.length <= 0) {
                                 portraitUri = @"";
                             }
//                             NSString *creatorId = [result objectForKey:@"creatorId"];
                             NSString *introduce = [result objectForKey:@"introduce"];
                             if (!introduce) {
                                 introduce = @"";
                             }
                             
                             RCGroup *group = [[RCGroup alloc] initWithGroupId:groupId groupName:groupName portraitUri:@""];
                             completion(group);
                             
                         } else {
                             if (completion) {
                                 completion(nil);
                             }
                         }
                     }
                     failure:^(NSError *err) {

                     }];
}





@end

























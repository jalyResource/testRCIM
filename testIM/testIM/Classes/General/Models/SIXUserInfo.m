//
//  SIXUserInfo.m
//  testIM
//
//  Created by li’Pro on 2017/7/25.
//  Copyright © 2017年 6room. All rights reserved.
//

#import "SIXUserInfo.h"

@implementation SIXUserInfo

+ (instancetype)userInfoWithDic:(NSDictionary *)dic {
    SIXUserInfo *model = [[self alloc] init];
    model.ID = [dic parseStringWithKey:@"id"];
    model.nickname = [dic parseStringWithKey:@"nickname"];
    model.phone = [dic parseStringWithKey:@"phone"];
    model.portraitUri = [dic parseStringWithKey:@"portraitUri"];
    model.region = [dic parseStringWithKey:@"region"];
    
    return model;
}
/*
 id = TcnJXvflj;
 nickname = Jaly2012;
 phone = 13651023662;
 portraitUri = "http://7xogjk.com1.z0.glb.clouddn.com/TcnJXvflj1500517892245656006";
 region = 86;
 */
@end

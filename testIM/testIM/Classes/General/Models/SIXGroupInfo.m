//
//  SIXGroupInfo.m
//  testIM
//
//  Created by li’Pro on 2017/7/26.
//  Copyright © 2017年 6room. All rights reserved.
//

#import "SIXGroupInfo.h"

@implementation SIXGroupInfo

+ (instancetype)groupInfoWithDic:(NSDictionary *)dic {
    SIXGroupInfo *model = [[SIXGroupInfo alloc] init];
    
    return model;
}
/*
 (lldb) po response
 {
     code = 200;
     result =     {
         bulletin = "<null>";
         creatorId = TcnJXvflj;
         deletedAt = "<null>";
         id = rzfeQaXUK;
         maxMemberCount = 500;
         memberCount = 2;
         name = "\U8ba8\U8bba\U7ec4";
         portraitUri = "";
     };
 }
 
 (lldb) 
 */

+ (NSArray<SIXGroupInfo *> *)groupArrayWithDicArray:(NSArray<NSDictionary *> *)arrDic {
    return nil;
}

@end

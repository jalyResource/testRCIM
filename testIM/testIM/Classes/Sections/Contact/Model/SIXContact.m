//
//  SIXContact.m
//  testIM
//
//  Created by li’Pro on 2017/7/25.
//  Copyright © 2017年 6room. All rights reserved.
//

#import "SIXContact.h"

@implementation SIXContact

- (NSString *)getShowingName {
    if (nil != self.displayName && 0 != self.displayName.length) {
        return self.displayName;
    }
    return self.user.nickname;
}

+ (NSArray<SIXContact *> *)contactArrayWithDicArray:(NSArray<NSDictionary *> *)arrDic {
    if (0 == arrDic.count) {
        return nil;
    }
    NSMutableArray<SIXContact *> *arrModel = [[NSMutableArray alloc] initWithCapacity:arrDic.count];
    
    for (NSDictionary *dic in arrDic) {
        [arrModel addObject:[self contactWithDic:dic]];
    }
    
    
    return arrModel.copy;
}

+ (instancetype)contactWithDic:(NSDictionary *)dic {
    SIXContact *model = [[self alloc] init];
    model.displayName = [dic parseStringWithKey:@"displayName"];
    model.message = [dic parseStringWithKey:@"message"];
    model.status = [dic parseIntegerWithKey:@"status"];
    model.updatedAt = [dic parseStringWithKey:@"updatedAt"];
    model.user = [SIXUserInfo userInfoWithDic:(NSDictionary *)dic[@"user"]];
    
    return model;
}
/*
 displayName = "";
 message = "\U6211\U662fJaly2012";
 status = 20;
 updatedAt = "2017-07-20T09:24:38.000Z";
 user =             {
 id = TcnJXvflj;
 nickname = Jaly2012;
 phone = 13651023662;
 portraitUri = "http://7xogjk.com1.z0.glb.clouddn.com/TcnJXvflj1500517892245656006";
 region = 86;
 };
 */

@end

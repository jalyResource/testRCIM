//
//  SIXChatRoom.m
//  testIM
//
//  Created by li’Pro on 2017/7/26.
//  Copyright © 2017年 6room. All rights reserved.
//

#import "SIXChatRoom.h"

@implementation SIXChatRoom


+ (instancetype)chatRoomWithDic:(NSDictionary *)dic {
    SIXChatRoom *model = [[self alloc] init];
    model.ID = [dic parseStringWithKey:@"id"];
    model.name = [dic parseStringWithKey:@"name"];
    model.type = [dic parseStringWithKey:@"type"];
    
    return model;
}

/*
 id = OIBbeKlkx;
 name = "\U804a\U5929\U5ba4 I";
 type = chatroom;
 */

@end

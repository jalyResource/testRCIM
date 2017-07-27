//
//  SIXChatRoom.h
//  testIM
//
//  Created by li’Pro on 2017/7/26.
//  Copyright © 2017年 6room. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SIXChatRoom : NSObject

@property (copy, nonatomic) NSString *ID;

@property (copy, nonatomic) NSString *name;

@property (copy, nonatomic) NSString *type;

+ (instancetype)chatRoomWithDic:(NSDictionary *)dic ;

/*
 id = OIBbeKlkx;
 name = "\U804a\U5929\U5ba4 I";
 type = chatroom;
 */
@end

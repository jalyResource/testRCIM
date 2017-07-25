//
//  SIXContact.h
//  testIM
//
//  Created by li’Pro on 2017/7/25.
//  Copyright © 2017年 6room. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SIXContact : NSObject
@property (copy, nonatomic) NSString *displayName;
@property (copy, nonatomic) NSString *message;
@property (assign, nonatomic) NSUInteger status;
@property (copy, nonatomic) NSString *updatedAt;
@property (strong, nonatomic) SIXUserInfo *user;

- (NSString *)getShowingName ;

+ (instancetype)contactWithDic:(NSDictionary *)dic ;
+ (NSArray<SIXContact *> *)contactArrayWithDicArray:(NSArray<NSDictionary *> *)arrDic ;

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

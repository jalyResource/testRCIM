//
//  SIXUserInfo.h
//  testIM
//
//  Created by li’Pro on 2017/7/25.
//  Copyright © 2017年 6room. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SIXUserInfo : NSObject
@property (copy, nonatomic) NSString *ID;
@property (copy, nonatomic) NSString *nickname;
@property (copy, nonatomic) NSString *phone;
@property (copy, nonatomic) NSString *portraitUri;
@property (copy, nonatomic) NSString *region;

+ (instancetype)userInfoWithDic:(NSDictionary *)dic ;
/*
 id = TcnJXvflj;
 nickname = Jaly2012;
 phone = 13651023662;
 portraitUri = "http://7xogjk.com1.z0.glb.clouddn.com/TcnJXvflj1500517892245656006";
 region = 86;
 */
@end

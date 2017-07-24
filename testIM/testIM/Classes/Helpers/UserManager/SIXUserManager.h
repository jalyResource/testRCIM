//
//  SIXUserManager.h
//  testIM
//
//  Created by li’Pro on 2017/7/21.
//  Copyright © 2017年 wzl. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SIXUserManager : NSObject

+ (instancetype)shareUserManager ;


- (void)savaUserPhone:(NSString *)phone psw:(NSString *)psw userId:(NSString *)userId token:(NSString *)token ;
- (void)saveUserName:(NSString *)name portrait:(NSString *)portrait ;

- (NSString *)getDefaultPhone ;

- (NSString *)getDefaultName ;

- (NSString *)getDefaultPortrait ;

- (NSString *)getDefaultPassword ;

- (NSString *)getDefaultUserId ;

- (NSString *)getDefaultToken ;
    
    

@end

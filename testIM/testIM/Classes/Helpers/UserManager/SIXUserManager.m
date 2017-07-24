//
//  SIXUserManager.m
//  testIM
//
//  Created by li’Pro on 2017/7/21.
//  Copyright © 2017年 wzl. All rights reserved.
//

#import "SIXUserManager.h"

@interface SIXUserManager () <RCIMUserInfoDataSource>

@end

@implementation SIXUserManager

+ (instancetype)shareUserManager {
    static SIXUserManager *ins = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ins = [[SIXUserManager alloc] init];
    });
    
    return ins;
}

- (void)savaUserPhone:(NSString *)phone psw:(NSString *)psw userId:(NSString *)userId token:(NSString *)token {
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:@"phone"];
    [[NSUserDefaults standardUserDefaults] setObject:psw forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"userId"];
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)saveUserName:(NSString *)name portrait:(NSString *)portrait {
    [[NSUserDefaults standardUserDefaults] setObject:portrait forKey:@"portrait"];
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"name"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)getDefaultPhone {
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"phone"];
}

- (NSString *)getDefaultPassword {
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"password"];
}

- (NSString *)getDefaultUserId {
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"userId"];
}

- (NSString *)getDefaultToken {
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"token"];
}


#pragma -mark 
#pragma -mark RCIMUserInfoDataSource
/*!
 获取用户信息
 
 @param userId      用户ID
 @param completion  获取用户信息完成之后需要执行的Block [userInfo:该用户ID对应的用户信息]
 
 @discussion SDK通过此方法获取用户信息并显示，请在completion中返回该用户ID对应的用户信息。
 在您设置了用户信息提供者之后，SDK在需要显示用户信息的时候，会调用此方法，向您请求用户信息用于显示。
 */
- (void)getUserInfoWithUserId:(NSString *)userId
                   completion:(void (^)(RCUserInfo *userInfo))completion {
//    NSString *ID = [self getDefaultUserId];
//    NSString *name = [self getdef];
//    NSString *portrait = [self getDefaultUserId];
//    RCUserInfo *u = [RCUserInfo alloc] initWithUserId:<#(NSString *)#> name:<#(NSString *)#> portrait:<#(NSString *)#>
}

@end






















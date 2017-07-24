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

- (NSString *)getDefaultName {
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"name"];
}

- (NSString *)getDefaultPortrait {
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"portrait"];
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




@end






















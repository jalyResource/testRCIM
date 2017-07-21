//
//  SIXUserManager.m
//  testIM
//
//  Created by li’Pro on 2017/7/21.
//  Copyright © 2017年 wzl. All rights reserved.
//

#import "SIXUserManager.h"

@implementation SIXUserManager

+ (void)savaUserId:(NSString *)userId token:(NSString *)token {
    [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"userId"];
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end

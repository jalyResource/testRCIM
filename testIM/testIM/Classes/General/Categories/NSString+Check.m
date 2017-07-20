//
//  NSString+Check.m
//  testIM
//
//  Created by li’Pro on 2017/7/20.
//  Copyright © 2017年 wzl. All rights reserved.
//

#import "NSString+Check.h"

@implementation NSString (Check)

/**
 * 验证手机号码
 */
+ (BOOL)validateMobile:(NSString *)mobile {
    if (mobile.length == 0) {
        NSString *message = @"手机号码不能为空！";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        return NO;
    }
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest =
    [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    if (![phoneTest evaluateWithObject:mobile]) {
        NSString *message = @"手机号码格式不正确！";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        return NO;
    }
    return YES;
}

@end

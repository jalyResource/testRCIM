//
//  NSString+Check.h
//  testIM
//
//  Created by li’Pro on 2017/7/20.
//  Copyright © 2017年 wzl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Check)

/**
 * 验证手机号码
 */
+ (BOOL)validateMobile:(NSString *)mobile ; 

@end

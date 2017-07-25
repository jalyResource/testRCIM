//
//  SIXTipMessageContent.h
//  testIM
//
//  Created by li’Pro on 2017/7/25.
//  Copyright © 2017年 6room. All rights reserved.
//

#import <RongIMLib/RongIMLib.h>

@interface SIXTipMessageContent : RCMessageContent

@property (copy, nonatomic) NSString *tipText;

+ (instancetype)tipMessageContentWithTipText:(NSString *)text ;

@end

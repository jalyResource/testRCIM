//
//  SIXTipMessageCell.h
//  testIM
//
//  Created by li’Pro on 2017/7/25.
//  Copyright © 2017年 6room. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>
@class SIXTipMessageContent;

@interface SIXTipMessageCell : RCMessageBaseCell

@property (strong, nonatomic) SIXTipMessageContent *tipMessage;

@end
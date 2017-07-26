//
//  SIXConversationModel.m
//  testIM
//
//  Created by li’Pro on 2017/7/25.
//  Copyright © 2017年 6room. All rights reserved.
//

#import "SIXConversationModel.h"
#import <RongIMKit/RCPluginBoardView.h>


@implementation SIXConversationModel

-(void)pluginBoardView:(RCPluginBoardView*)pluginBoardView clickedItemWithTag:(NSInteger)tag {
    switch (tag) {
        case EnumSendMessageTypeTip: {
            SIXTipMessageContent *msgContent = [SIXTipMessageContent tipMessageContentWithTipText:@"this is test Text"];
            
            [[RCIM sharedRCIM] sendMessage:self.conversationType targetId:self.targetId content:msgContent pushContent:msgContent.tipText pushData:msgContent.tipText success:^(long messageId) {
                DLog(@"\n\n\n   ---- send success");
            } error:^(RCErrorCode nErrorCode, long messageId) {
                DLog(@"\n\n\n   ---- send faile");
            }];
            break;
        }
        case EnumSendMessageTypeProduct: {
            SIXProductMessageContent *msgContent = [SIXProductMessageContent productUrl:@"http://book.kongfz.com/1937/724862070/" imageUrl:@"http://www.kfzimg.com/G05/M00/E0/6A/p4YBAFl0oOOAWveMAACmzqWYd6w264_b.jpg" name:@"中华民国十四年宛平袁励祯 手写医案 药方一册" price:14000.00];
            
            [[RCIM sharedRCIM] sendMessage:self.conversationType targetId:self.targetId content:msgContent pushContent:msgContent.name pushData:msgContent.name success:^(long messageId) {
                DLog(@"\n\n\n   ---- send success");
            } error:^(RCErrorCode nErrorCode, long messageId) {
                DLog(@"\n\n\n   ---- send faile");
            }];
            break;
        }
    }
}
@end

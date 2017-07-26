//
//  SIXConversationModel.h
//  testIM
//
//  Created by li’Pro on 2017/7/25.
//  Copyright © 2017年 6room. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RCPluginBoardView;

typedef NS_ENUM(NSUInteger, EnumSendMessageType) {
    EnumSendMessageTypeTip     = 101, // 提示消息
    EnumSendMessageTypeProduct = 102, // 商品连接
};

@interface SIXConversationModel : NSObject

/*!
 会话类型
 */
@property(nonatomic, assign) RCConversationType conversationType;
/*!
 目标会话ID
 */
@property(nonatomic, strong) NSString *targetId;

#pragma -mark 
#pragma -mark public
-(void)pluginBoardView:(RCPluginBoardView*)pluginBoardView clickedItemWithTag:(NSInteger)tag ;

@end

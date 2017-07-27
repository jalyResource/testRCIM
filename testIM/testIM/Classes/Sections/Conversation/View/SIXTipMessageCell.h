//
//  SIXTipMessageCell.h
//  testIM
//
//  Created by li’Pro on 2017/7/25.
//  Copyright © 2017年 6room. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>
@class SIXTipMessageContent;
@class SIXTipMessageCell;

@protocol SIXTipMessageCellDelegate <NSObject>

@optional
- (void)tipMessageCell:(SIXTipMessageCell *)tipMessageCell didTapTipText:(NSString *)text ;

@end

@interface SIXTipMessageCell : RCMessageBaseCell

@property (weak, nonatomic) id<SIXTipMessageCellDelegate> tipDelegate;

@end

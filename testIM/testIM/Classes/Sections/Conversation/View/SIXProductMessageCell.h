//
//  SIXProductMessageCell.h
//  testIM
//
//  Created by li’Pro on 2017/7/25.
//  Copyright © 2017年 6room. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>
@class SIXProductMessageCell;

@protocol SIXProductMessageCellDelegate <NSObject>

@optional
- (void)productMessageCell:(SIXProductMessageCell *)productMessageCell didTapProductModel:(RCMessageModel *)messageModel ;

@end

@interface SIXProductMessageCell : RCMessageCell

@property (weak, nonatomic) id<SIXProductMessageCellDelegate> productDelegate;

@end

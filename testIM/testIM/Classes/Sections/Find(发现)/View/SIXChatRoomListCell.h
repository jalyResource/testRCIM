//
//  SIXChatRoomListCell.h
//  testIM
//
//  Created by li’Pro on 2017/7/27.
//  Copyright © 2017年 6room. All rights reserved.
//

#import "SIXTableViewCell.h"
@class SIXChatRoom;

@interface SIXChatRoomListCell : SIXTableViewCell

@property (strong, nonatomic) SIXChatRoom *chatRoom;

- (void)setImageName:(NSString *)imgName ;

@end

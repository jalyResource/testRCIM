//
//  SIXFindVCModel.h
//  testIM
//
//  Created by li’Pro on 2017/7/26.
//  Copyright © 2017年 6room. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIXChatRoom.h"

@interface SIXFindVCModel : NSObject

@property (strong, nonatomic) NSArray<SIXChatRoom *> *arrChatRoom;

+ (instancetype)shareFindVCModel ;


@end

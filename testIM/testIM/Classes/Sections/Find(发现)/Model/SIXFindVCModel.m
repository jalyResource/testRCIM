//
//  SIXFindVCModel.m
//  testIM
//
//  Created by li’Pro on 2017/7/26.
//  Copyright © 2017年 6room. All rights reserved.
//

#import "SIXFindVCModel.h"
#import "SIXConversationViewController.h"

@interface SIXFindVCModel ()

@property (copy, nonatomic) NSArray<NSString *> *arrIconImgName;
@end

@implementation SIXFindVCModel

+ (instancetype)shareFindVCModel {
    static SIXFindVCModel *ins = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ins = [[self alloc] init];
    });
    
    return ins;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arrIconImgName = @[@"find_icon_chat_room1", @"find_icon_chat_room2", @"find_icon_chat_room3", @"find_icon_chat_room4"];
    }
    return self;
}



/**
 * public
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrChatRoom.count;
}

- (SIXChatRoom *)modelAtIndexPath:(NSIndexPath *)indexPath {
    return [self.arrChatRoom objectCheckAtIndex:indexPath.row];
}
- (NSString *)imageNameAtIndexPath:(NSIndexPath *)indexPath {
    return [self.arrIconImgName objectCheckAtIndex:indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        return 88;
    }
    
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath fromVC:(__kindof SIXViewController *)viewController {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SIXChatRoom *chatRoom = [self.arrChatRoom objectCheckAtIndex:indexPath.row];
    NSString *chatroomId = chatRoom.ID;
    
    SIXConversationViewController *chatVC = [[SIXConversationViewController alloc] initWithConversationType:ConversationType_CHATROOM targetId:chatroomId];
    
    chatVC.title = chatRoom.name;
    
    [viewController.navigationController pushViewController:chatVC animated:YES];
}


@end

                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    
                                                                                                    

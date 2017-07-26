//
//  SIXConversationListViewController.m
//  testIM
//
//  Created by li’Pro on 2017/7/21.
//  Copyright © 2017年 wzl. All rights reserved.
//

#import "SIXConversationListViewController.h"
#import "SIXConversationViewController.h"

@interface SIXConversationListViewController ()

@end

@implementation SIXConversationListViewController

#pragma -mark 
#pragma -mark life cycle
- (id)init {
    self = [super init];
    if (self) {
        //设置要显示的会话类型
        [self setDisplayConversationTypes:@[
                                            @(ConversationType_PRIVATE),
                                            @(ConversationType_DISCUSSION),
                                            @(ConversationType_APPSERVICE),
                                            @(ConversationType_PUBLICSERVICE),
                                            @(ConversationType_GROUP),
                                            @(ConversationType_SYSTEM)
                                            ]];
        
        //聚合会话类型
        [self setCollectionConversationType:@[ @(ConversationType_SYSTEM) ]];
        
    }
    return self;
}

- (void)viewDidLoad {
    //重写显示相关的接口，必须先调用super，否则会屏蔽SDK默认的处理
    [super viewDidLoad];
    self.tabBarController.navigationItem.title = @"会话";
    self.conversationListTableView.tableFooterView = [UIView new];
}

#pragma -mark 
#pragma -mark override method
//重写RCConversationListViewController的onSelectedTableRow事件
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
    
    SIXConversationViewController *conversationVC = [[SIXConversationViewController alloc]init];
    conversationVC.conversationType = model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.title = model.conversationTitle;
    conversationVC.conversationModel = model;
    
    [self.navigationController pushViewController:conversationVC animated:YES];
}
/*
    即将显示Cell的回调

    @param cell        即将显示的Cell
    @param indexPath   该Cell对应的会话Cell数据模型在数据源中的索引值

    @discussion 您可以在此回调中修改Cell的一些显示属性。
*/
- (void)willDisplayConversationTableCell:(RCConversationBaseCell *)cell
                             atIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:[RCConversationCell class]]) {
        RCConversationCell *conCell = (RCConversationCell *)cell;
        conCell.conversationTitle.textColor = [UIColor colorWithHex:0x333333];
    } 
}

@end
























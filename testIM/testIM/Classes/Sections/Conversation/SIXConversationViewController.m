//
//  SIXConversationViewController.m
//  testIM
//
//  Created by li’Pro on 2017/7/24.
//  Copyright © 2017年 6room. All rights reserved.
//

#import "SIXConversationViewController.h"
#import "SIXTipMessageContent.h"
#import "SIXTipMessageCell.h"

@interface SIXConversationViewController ()

@end

@implementation SIXConversationViewController

#pragma -mark 
#pragma -mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self six_setUp];
    [self six_setView];
    [self six_loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.defaultInputType = RCChatSessionInputBarInputVoice;
}
#pragma -mark 
#pragma -mark private
- (void)six_setUp {
//    [self.chatSessionInputBarControl setInputBarType:RCChatSessionInputBarControlDefaultType style:RC_CHAT_INPUT_BAR_STYLE_SWITCH_CONTAINER_EXTENTION];
    // 注册 自定义 cell
    [self registerClass:[SIXTipMessageCell class] forMessageClass:[SIXTipMessageContent class]];
    
}
- (void)six_setView {
    UIButton *btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    btnRight.frame = CGRectMake(0, 0, 44, 44);
    [btnRight setTitle:@"tipMsg" forState:UIControlStateNormal];
    [btnRight setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnRight addTarget:self action:@selector(headerRightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnRight];
}
- (void)six_loadData {
    
}

#pragma -mark 
#pragma -mark event response
- (void)headerRightButtonClicked {
    SIXTipMessageContent *msgContent = [SIXTipMessageContent tipMessageContentWithTipText:@"this is test Text"];
    
    [[RCIM sharedRCIM] sendMessage:self.model.conversationType targetId:self.model.targetId content:msgContent pushContent:msgContent.tipText pushData:msgContent.tipText success:^(long messageId) {
        DLog(@"\n\n\n   ---- send success");
    } error:^(RCErrorCode nErrorCode, long messageId) {
        DLog(@"\n\n\n   ---- send faile");
    }];
}

#pragma -mark 
#pragma -mark override
/*!
 即将显示消息Cell的回调
 
 @param cell        消息Cell
 @param indexPath   该Cell对应的消息Cell数据模型在数据源中的索引值
 
 @discussion 您可以在此回调中修改Cell的显示和某些属性。
 */
- (void)willDisplayMessageCell:(RCMessageBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath {
//    cell.baseContentView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.7];
    if ([cell isKindOfClass:[SIXTipMessageCell class]]) {
        
        SIXTipMessageCell *tipCell = (SIXTipMessageCell *)cell;
        
        if (indexPath.row < self.conversationDataRepository.count) {
            
            RCMessageModel *cellModel = self.conversationDataRepository[indexPath.row];
            if ([cellModel.content isKindOfClass:[SIXTipMessageContent class]]) {
                SIXTipMessageContent *tipMessage = (SIXTipMessageContent *)cellModel.content;
                tipCell.tipMessage = tipMessage;
            }
        }
    }
}



@end

























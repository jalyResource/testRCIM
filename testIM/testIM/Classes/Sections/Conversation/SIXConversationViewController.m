//
//  SIXConversationViewController.m
//  testIM
//
//  Created by li’Pro on 2017/7/24.
//  Copyright © 2017年 6room. All rights reserved.
//

#import "SIXConversationViewController.h"
#import "SIXConversationModel.h"
/** 自定义 cell */
#import "SIXTipMessageCell.h"
#import "SIXProductMessageCell.h"

@interface SIXConversationViewController ()

@property (strong, nonatomic) SIXConversationModel *vcModel;

@end

@implementation SIXConversationViewController

#pragma -mark 
#pragma -mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUp];
    [self setView];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.defaultInputType = RCChatSessionInputBarInputVoice;
}

- (void)setUp {
//    [self.chatSessionInputBarControl setInputBarType:RCChatSessionInputBarControlDefaultType style:RC_CHAT_INPUT_BAR_STYLE_SWITCH_CONTAINER_EXTENTION];
    // 注册 自定义 cell
    [self registerClass:[SIXTipMessageCell class] forMessageClass:[SIXTipMessageContent class]];
    [self registerClass:[SIXProductMessageCell class] forMessageClass:[SIXProductMessageContent class]];
}

- (void)setView {
    UIButton *btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    btnRight.frame = CGRectMake(0, 0, 44, 44);
    [btnRight setTitle:@"tipMsg" forState:UIControlStateNormal];
    [btnRight setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnRight addTarget:self action:@selector(headerRightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnRight];
    
    // + 扩展区域
    [self.chatSessionInputBarControl.pluginBoardView insertItemWithImage:[UIImage imageNamed:@"conversation_plugin_tipText"] title:@"提示消息" tag:101];
    [self.chatSessionInputBarControl.pluginBoardView insertItemWithImage:[UIImage imageNamed:@"conversation_plugin_product"] title:@"商品" tag:102];
}
- (void)loadData {
    
}

#pragma -mark 
#pragma -mark event response
- (void)headerRightButtonClicked {
    SIXTipMessageContent *msgContent = [SIXTipMessageContent tipMessageContentWithTipText:@"this is test Text"];
    
//    [[RCIM sharedRCIM] sendMessage:self.model.conversationType targetId:self.model.targetId content:msgContent pushContent:msgContent.tipText pushData:msgContent.tipText success:^(long messageId) {
//        DLog(@"\n\n\n   ---- send success");
//    } error:^(RCErrorCode nErrorCode, long messageId) {
//        DLog(@"\n\n\n   ---- send faile");
//    }];
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
    
    RCMessageContent *msgContent = nil;
    if (indexPath.row < self.conversationDataRepository.count) {
        RCMessageModel *cellModel = self.conversationDataRepository[indexPath.row];
        msgContent = cellModel.content;
    }

    
    if ([cell isKindOfClass:[SIXTipMessageCell class]]) {        
        SIXTipMessageCell *tipCell = (SIXTipMessageCell *)cell;
        tipCell.messageContent = msgContent;
    } else if ([cell isKindOfClass:[SIXProductMessageCell class]]) {        
        SIXProductMessageCell *productCell = (SIXProductMessageCell *)cell;
        productCell.messageContent = msgContent;
    }
}

/*!
 扩展功能板的点击回调
 
 @param pluginBoardView 输入扩展功能板View
 @param tag             输入扩展功能(Item)的唯一标示
 */
-(void)pluginBoardView:(RCPluginBoardView*)pluginBoardView clickedItemWithTag:(NSInteger)tag {
    if (tag < 9999 && tag > 999) {
        [super pluginBoardView:pluginBoardView clickedItemWithTag:tag];
    } else {
        [self.vcModel pluginBoardView:pluginBoardView clickedItemWithTag:tag];
    }
}


#pragma -mark 
#pragma -mark getter
- (SIXConversationModel *)vcModel {
    if (!_vcModel) {
        _vcModel = [[SIXConversationModel alloc] init];
        _vcModel.conversationType = self.conversationModel.conversationType;
        _vcModel.targetId = self.conversationModel.targetId;
    }
    return _vcModel;
}

@end

























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

@interface SIXConversationViewController ()<
    SIXTipMessageCellDelegate, SIXProductMessageCellDelegate
>

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
    
    if (ConversationType_PRIVATE == self.conversationType || ConversationType_CUSTOMERSERVICE == self.conversationType) {
        self.displayUserNameInCell = NO;
    }
    
    // + 扩展区域
    if (ConversationType_PRIVATE == self.conversationType || ConversationType_DISCUSSION == self.conversationType || ConversationType_GROUP == self.conversationType) {
        [self.chatSessionInputBarControl.pluginBoardView insertItemWithImage:[UIImage imageNamed:@"conversation_plugin_tipText"] title:@"提示消息" tag:101];
        [self.chatSessionInputBarControl.pluginBoardView insertItemWithImage:[UIImage imageNamed:@"conversation_plugin_product"] title:@"商品" tag:102];
    }
}

- (void)setView {
    UIButton *btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    btnRight.frame = CGRectMake(0, 0, 44, 44);
    [btnRight setTitle:@"tipMsg" forState:UIControlStateNormal];
    [btnRight setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnRight addTarget:self action:@selector(headerRightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnRight];
}

- (void)loadData {
    
}

#pragma -mark 
#pragma -mark event response
- (void)headerRightButtonClicked {
//    SIXTipMessageContent *msgContent = [SIXTipMessageContent tipMessageContentWithTipText:@"this is test Text"];
    
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
    
    RCMessageModel *cellModel = nil;
    if (indexPath.row < self.conversationDataRepository.count) {
        cellModel = self.conversationDataRepository[indexPath.row];
    }

    
    if ([cell isKindOfClass:[SIXTipMessageCell class]]) {        
        SIXTipMessageCell *tipCell = (SIXTipMessageCell *)cell;
        tipCell.tipDelegate = self;
        [cell setModel:cellModel];
    } else if ([cell isKindOfClass:[SIXProductMessageCell class]]) {        
        SIXProductMessageCell *productCell = (SIXProductMessageCell *)cell;
        productCell.productDelegate = self;
        [cell setModel:cellModel];
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

/*!
 长按Cell中的消息内容的回调
 
 @param model 消息Cell的数据模型
 @param view  长按区域的View
 
 @discussion SDK在此长按事件中，会默认展示菜单。
 您在重写此回调时，如果想保留SDK原有的功能，需要注意调用super。
 */
//- (void)didLongTouchMessageCell:(RCMessageModel *)model
//                         inView:(UIView *)view {
//    
//    [super didLongTouchMessageCell:model inView:view];
//}
//
///*!
// 获取长按Cell中的消息时的菜单
// 
// @param model 消息Cell的数据模型
// 
// @discussion SDK在此长按事件中，会展示此方法返回的菜单。
// 您在重写此回调时，如果想保留SDK原有的功能，需要注意调用super。
// */
//- (NSArray<UIMenuItem *> *)getLongTouchMessageCellMenuList:(RCMessageModel *)model{
//    NSArray *array = [super getLongTouchMessageCellMenuList:model];
//    
//    return array;
//}


#pragma -mark 
#pragma -mark SIXTipMessageCellDelegate
- (void)tipMessageCell:(SIXTipMessageCell *)tipMessageCell didTapTipText:(NSString *)text {
    [self.vcModel alertMessage:text fromVC:self];
}

#pragma -mark 
#pragma -mark SIXProductMessageCellDelegate
- (void)productMessageCell:(SIXProductMessageCell *)productMessageCell didTapProductModel:(RCMessageModel *)messageModel {
    SIXProductMessageContent *productModel = (SIXProductMessageContent *)messageModel.content;
    [super didTapUrlInMessageCell:productModel.url model:messageModel];
}
- (void)productMessageCell:(SIXProductMessageCell *)productMessageCell deleteMessage:(RCMessageModel *)model {
    [self deleteMessage:model];
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

























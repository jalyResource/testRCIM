//
//  SIXConversationViewController.m
//  testIM
//
//  Created by li’Pro on 2017/7/24.
//  Copyright © 2017年 6room. All rights reserved.
//  ad 

#import "SIXConversationViewController.h"
#import "SIXConversationModel.h"
/** 自定义 cell */
#import "SIXTipMessageCell.h"
#import "SIXProductMessageCell.h"

@interface SIXConversationViewController ()<
    SIXTipMessageCellDelegate, SIXProductMessageCellDelegate
>

@property (strong, nonatomic) SIXConversationModel *vcModel;
/** UI */
@property (strong, nonatomic) UIButton *btnMedal;

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
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (ConversationType_CHATROOM == self.conversationType) {
        [self scrollToBottomAnimated:YES];
    }
}

- (void)dealloc {
    [self.conversationMessageCollectionView removeObserver:self forKeyPath:@"frame"];
}

#pragma -mark 
#pragma -mark private
- (void)setUp {
    // 注册 自定义 cell
    [self registerClass:[SIXTipMessageCell class] forMessageClass:[SIXTipMessageContent class]];
    [self registerClass:[SIXProductMessageCell class] forMessageClass:[SIXProductMessageContent class]];
    
    if (ConversationType_GROUP == self.conversationType || ConversationType_PRIVATE == self.conversationType || ConversationType_CUSTOMERSERVICE == self.conversationType) {
        self.displayUserNameInCell = NO;
    }
    
    // + 扩展区域
    if (ConversationType_PRIVATE == self.conversationType || ConversationType_DISCUSSION == self.conversationType || ConversationType_GROUP == self.conversationType) {
        [self.chatSessionInputBarControl.pluginBoardView insertItemWithImage:[UIImage imageNamed:@"conversation_plugin_tipText"] title:@"提示消息" tag:101];
        [self.chatSessionInputBarControl.pluginBoardView insertItemWithImage:[UIImage imageNamed:@"conversation_plugin_product"] title:@"商品" tag:102];
    }
    
    // 监听
    [self.conversationMessageCollectionView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)setView {
    // 最后一条消息下方留一行
    UIEdgeInsets insets = self.conversationMessageCollectionView.contentInset;
    insets.bottom += 85;
    self.conversationMessageCollectionView.contentInset = insets;
    
//    UIButton *btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
//    btnRight.frame = CGRectMake(0, 0, 44, 44);
//    [btnRight setTitle:@"tipMsg" forState:UIControlStateNormal];
//    [btnRight setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btnRight addTarget:self action:@selector(headerRightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnRight];
    
    // 添加 “奖单” 按钮
    if (ConversationType_PRIVATE == self.conversationType) {
        [self.conversationMessageCollectionView addSubview:self.btnMedal];
        CGRect frame = self.conversationMessageCollectionView.bounds;
        frame.origin.x = frame.size.width - 15 - 50;
        frame.origin.y = frame.size.height - 10 - 50;
        frame.size = CGSizeMake(50, 50);
        self.btnMedal.frame = frame;
        frame = [self.conversationMessageCollectionView convertRect:frame toView:self.view];
        self.btnMedal.frame = frame;
        [self.view addSubview:self.btnMedal];
    }
}

- (void)loadData {
    
}

#pragma -mark 
#pragma -mark event response
- (void)headerRightButtonClicked {
}

- (void)btnMedalClicked:(UIButton *)sender {
//    NSLog(@"%s", __func__);
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
//        [cell setModel:cell9Model];
    } else if ([cell isKindOfClass:[SIXProductMessageCell class]]) {        
        SIXProductMessageCell *productCell = (SIXProductMessageCell *)cell;
        productCell.productDelegate = self;
//        [cell setModel:cellModel];
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


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//    NSLog(@"path: %@ \n  %@", keyPath, change);
    if ([keyPath isEqualToString:@"frame"]) {
        if (ConversationType_PRIVATE == self.conversationType) {
            static CGFloat width = 55;
            CGRect frame = [[change objectForKey:@"new"] CGRectValue];
            frame.origin.x = frame.size.width - 10 - width;
            frame.origin.y = frame.size.height - 10;
            frame.size = CGSizeMake(width, width);
            self.btnMedal.frame = frame;
        }
    }
}


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

- (UIButton *)btnMedal {
    if (!_btnMedal) {
        _btnMedal = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnMedal setImage:[UIImage imageNamed:@"chat_icon_jiangdan"] forState:UIControlStateNormal];
        [_btnMedal addTarget:self action:@selector(btnMedalClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnMedal;
}

@end

























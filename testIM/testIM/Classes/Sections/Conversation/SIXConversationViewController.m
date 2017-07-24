//
//  SIXConversationViewController.m
//  testIM
//
//  Created by li’Pro on 2017/7/24.
//  Copyright © 2017年 6room. All rights reserved.
//

#import "SIXConversationViewController.h"

@interface SIXConversationViewController ()

@end

@implementation SIXConversationViewController

#pragma -mark 
#pragma -mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self six_setUp];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.defaultInputType = RCChatSessionInputBarInputVoice;
}
#pragma -mark 
#pragma -mark private
- (void)six_setUp {
//    [self.chatSessionInputBarControl setInputBarType:RCChatSessionInputBarControlDefaultType style:RC_CHAT_INPUT_BAR_STYLE_SWITCH_CONTAINER_EXTENTION];
    
    
}



@end

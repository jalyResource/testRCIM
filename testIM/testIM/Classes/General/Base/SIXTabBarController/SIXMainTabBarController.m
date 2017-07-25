//
//  SIXTabBarController.m
//  testIM
//
//  Created by li’Pro on 2017/7/20.
//  Copyright © 2017年 wzl. All rights reserved.
//

#import "SIXMainTabBarController.h"
#import "SIXConversationListViewController.h"
#import "SIXContactViewController.h"

@interface SIXMainTabBarController ()

@end

@implementation SIXMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpSubViewController];
    [self setUpSubItem];
}


#pragma -mark 
#pragma -mark private
- (void)setUpSubViewController {
    SIXConversationListViewController *conversationListVC = [[SIXConversationListViewController alloc] init];
    conversationListVC.tabBarItem.title = @"会话";
    conversationListVC.tabBarItem.image = [UIImage imageNamed:@"tab_btn_chat_list_normal"];
    conversationListVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_btn_chat_list_selected"];
    ///  通讯录 发现我的
    
    SIXContactViewController *contactVC = [[SIXContactViewController alloc] init];
    contactVC.tabBarItem.title = @"通讯录";
    contactVC.tabBarItem.image = [UIImage imageNamed:@"tab_btn_contact_normal"];
    contactVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_btn_contact_selected"];
    
    NSArray<UIViewController *> *arrVC = @[conversationListVC, contactVC];
    self.viewControllers = arrVC;
}

- (void)setUpSubItem {
    
}


@end

























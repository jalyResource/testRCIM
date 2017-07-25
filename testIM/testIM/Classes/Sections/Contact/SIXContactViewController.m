//
//  SIXContactViewController.m
//  testIM
//
//  Created by li’Pro on 2017/7/25.
//  Copyright © 2017年 6room. All rights reserved.
//

#import "SIXContactViewController.h"
#import "SIXContactVCModel.h"
#import "SIXContactCell.h"
#import "SIXConversationViewController.h"
#import "SIXContact.h"


@interface SIXContactViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) SIXContactVCModel *vcModel;

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation SIXContactViewController

#pragma -mark 
#pragma -mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self six_setView];
    [self six_loadData];
}

#pragma -mark 
#pragma -mark private

- (void)six_setView {
    self.tabBarController.navigationItem.title = @"通讯录";
    [self.view addSubview:self.tableView];
}

- (void)six_loadData {
    [self showLoading];
    [self.vcModel fetchFriendListCompletion:^(EnumHttpCode code, NSString *text) {
        [self hiddenLoading];
        if (EnumHttpCodeSuccess == code) {
            [self.tableView reloadData];
        } else {
            
        }
    }];
}

#pragma -mark 
#pragma -mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.vcModel numberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.vcModel tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SIXContactCell *cell = [tableView dequeueReusableCellWithIdentifier:[SIXContactCell six_reuseIdentifier]];
    SIXContact *model = [self.vcModel contactAtIndexPath:indexPath];
    cell.contact = model;
    
    return cell;
}

#pragma -mark 
#pragma -mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SIXContact *model = [self.vcModel contactAtIndexPath:indexPath];
    
    SIXConversationViewController *conversationVC = [[SIXConversationViewController alloc]init];
    conversationVC.conversationType = ConversationType_PRIVATE;
    conversationVC.targetId = model.user.ID;
    conversationVC.title = model.user.nickname;
    
    [self.navigationController pushViewController:conversationVC animated:YES];
}



#pragma -mark 
#pragma -mark getter and setter
- (SIXContactVCModel *)vcModel {
    if (!_vcModel) {
        _vcModel = [[SIXContactVCModel alloc] init];
    }
    return _vcModel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        CGRect frame = CGRectMake(0, 0, SIX_SCREEN_WIDTH, SIX_SCREEN_HEIGHT);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        [_tableView registerClass:[SIXContactCell class] forCellReuseIdentifier:[SIXContactCell six_reuseIdentifier]];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

@end

























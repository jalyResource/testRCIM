//
//  SIXFindViewController.m
//  testIM
//
//  Created by li’Pro on 2017/7/26.
//  Copyright © 2017年 6room. All rights reserved.
//

#import "SIXFindViewController.h"
#import "SIXChatRoomListCell.h"
#import "SIXFindVCModel.h"


@interface SIXFindViewController ()<UITableViewDelegate, UITableViewDataSource>

/** UI */
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UILabel *lblChatRoom;

/** data */
@property (strong, nonatomic) SIXFindVCModel *vcModel;

@end

@implementation SIXFindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUp];
    [self setView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title = @"发现";
}

- (void)setUp {
    
}

- (void)setView {
    [self.view addSubview:self.tableView];
    self.tableView.frame = [UIScreen mainScreen].bounds;
}

- (void)loadData {
    
}

#pragma -mark 
#pragma -mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.vcModel tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SIXChatRoomListCell *cell = [tableView dequeueReusableCellWithIdentifier:[SIXChatRoomListCell six_reuseIdentifier]];
    cell.chatRoom = [self.vcModel modelAtIndexPath:indexPath];
    [cell setImageName:[self.vcModel imageNameAtIndexPath:indexPath]];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.vcModel numberOfSectionsInTableView:tableView];
}

#pragma -mark 
#pragma -mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.vcModel tableView:tableView didSelectRowAtIndexPath:indexPath fromVC:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.lblChatRoom.height;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.lblChatRoom;
}

#pragma -mark 
#pragma -mark getter

- (UITableView *)tableView {
    if (!_tableView) {
        CGRect frame = CGRectMake(0, 0, SIX_SCREEN_WIDTH, SIX_SCREEN_HEIGHT);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        [_tableView registerClass:[SIXChatRoomListCell class] forCellReuseIdentifier:[SIXChatRoomListCell six_reuseIdentifier]];
        
        _tableView.rowHeight = 66;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (SIXFindVCModel *)vcModel {
    if (!_vcModel) {
        _vcModel = [SIXFindVCModel shareFindVCModel];
    }
    return _vcModel;
}

- (UILabel *)lblChatRoom {
    if (!_lblChatRoom) {
        _lblChatRoom = [[UILabel alloc] init];
        _lblChatRoom.frame = CGRectMake(0, 0, SIX_SCREEN_WIDTH, 30);
        _lblChatRoom.backgroundColor = LINE_COLOR_EE;
        
        _lblChatRoom.text = @"      聊天室";
        _lblChatRoom.textColor = TEXT_COLOR_33;
        _lblChatRoom.font = [UIFont systemFontOfSize:14];
        _lblChatRoom.textAlignment = NSTextAlignmentLeft; 

    }
    return _lblChatRoom;
}
@end

























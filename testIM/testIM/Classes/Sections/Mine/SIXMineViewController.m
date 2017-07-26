//
//  SIXMineViewController.m
//  testIM
//
//  Created by li’Pro on 2017/7/26.
//  Copyright © 2017年 6room. All rights reserved.
//

#import "SIXMineViewController.h"
#import "SIXMineVCModel.h"




@interface SIXMineViewController ()<UITableViewDelegate, UITableViewDataSource>
/** UI */
@property (strong, nonatomic) UITableView *tableView;

/** data */
@property (strong, nonatomic) SIXMineVCModel *vcModel;

@end

@implementation SIXMineViewController
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
    self.tabBarController.navigationItem.title = @"我的";
//    DLog(@"\n\n\n naviController: %@ \n\n", self.navigationController);
}

- (void)setUp {
    self.view.backgroundColor = [UIColor orangeColor];
}

- (void)setView {
    [self.view addSubview:self.tableView];
    self.tableView.frame = [UIScreen mainScreen].bounds;
    
    self.tableView.tableHeaderView = ({
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIX_SCREEN_WIDTH, 10)];
        v.backgroundColor = [UIColor clearColor];
        v;
    });
}

- (void)loadData {
    
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
    EnumMineCellType type = [self.vcModel cellTypeAtIndexPath:indexPath];
    
    SIXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[SIXMineNormalCell six_reuseIdentifier]];
    
    switch (type) {
        case EnumMineCellTypeInfo: {
            cell = [tableView dequeueReusableCellWithIdentifier:[SIXMineInfoCell six_reuseIdentifier]];
            NSString *name = [[SIXUserManager shareUserManager] getDefaultName];
            NSString *portrait = [[SIXUserManager shareUserManager] getDefaultPortrait];
            
            [((SIXMineInfoCell *)cell) setName:name portrait:portrait]; 
            break;
        }
        case EnumMineCellTypeFeedback: {
            [((SIXMineNormalCell *)cell) setText:@"意见反馈"];
            break;
        }
        case EnumMineCellTypeLogout: {
            [((SIXMineNormalCell *)cell) setText:@"退出登录"];
            break;
        }
    }
    
    return cell;
}

#pragma -mark 
#pragma -mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.vcModel tableView:tableView didSelectRowAtIndexPath:indexPath fromVC:self];
    /*
     SIXContact *model = [self.vcModel contactAtIndexPath:indexPath];
     
     SIXConversationViewController *conversationVC = [[SIXConversationViewController alloc]init];
     conversationVC.conversationType = ConversationType_PRIVATE;
     conversationVC.targetId = model.user.ID;
     conversationVC.title = model.user.nickname;
     
     [self.navigationController pushViewController:conversationVC animated:YES];

     */
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.vcModel tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.5;
}





#pragma -mark 
#pragma -mark getter and setter

- (SIXMineVCModel *)vcModel {
    if (!_vcModel) {
        _vcModel = [[SIXMineVCModel alloc] init];
    }
    return _vcModel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        CGRect frame = CGRectMake(0, 0, SIX_SCREEN_WIDTH, SIX_SCREEN_HEIGHT);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        [_tableView registerClass:[SIXMineInfoCell class] forCellReuseIdentifier:[SIXMineInfoCell six_reuseIdentifier]];
        [_tableView registerClass:[SIXMineNormalCell class] forCellReuseIdentifier:[SIXMineNormalCell six_reuseIdentifier]];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}


@end

























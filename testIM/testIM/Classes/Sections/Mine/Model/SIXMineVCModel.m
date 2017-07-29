//
//  SIXMineVCModel.m
//  testIM
//
//  Created by li’Pro on 2017/7/26.
//  Copyright © 2017年 6room. All rights reserved.
//

#import "SIXMineVCModel.h"
#import "SIXCustomerServiceViewController.h"
#import "AppDelegate.h"
#import "SIXUserInfoViewController.h"

// 融云客服 id
#define RC_CUSTOMER_SERVICE_ID @"KEFU146001495753714"


@interface SIXMineVCModel ()

@property (copy, nonatomic) NSArray<NSNumber *> *arrCellType;

@end

@implementation SIXMineVCModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arrCellType = @[@(EnumMineCellTypeFeedback), @(EnumMineCellTypeLogout)];
    }
    return self;
}

/**
 * public
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0 == section) {
        return 1;
    }
    return self.arrCellType.count;
}

- (EnumMineCellType)cellTypeAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        return EnumMineCellTypeInfo;
    } else if (1 == indexPath.section) {
        return [self.arrCellType[indexPath.row] integerValue];
    }
    // 
    return EnumMineCellTypeInfo;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        return 88;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath fromVC:(__kindof SIXViewController *)viewController {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (0 == indexPath.section) {
        SIXUserInfoViewController *userInfoVC = [[SIXUserInfoViewController alloc] init];
        [viewController.navigationController pushViewController:userInfoVC animated:YES];
    } else
    if (1 == indexPath.section) {
        switch (indexPath.row) {
            case 0: {
                [self chatWithCustomerService:RC_CUSTOMER_SERVICE_ID fromVC:viewController];
                break;
            }
            case 1: {
                [self logout];
                break;
            }        
        }
    }
}

#pragma -mark 
#pragma -mark private
- (void)logout {
    [[SIXUserManager shareUserManager] logout];
    [[RCIM sharedRCIM] logout];
    
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate changeRootViewControllerType:EnumRootVCTypeLogin];
}

- (void)chatWithCustomerService:(NSString *)kefuId  fromVC:(__kindof SIXViewController *)viewController {
    SIXCustomerServiceViewController *chatService = [[SIXCustomerServiceViewController alloc] init];
    // live800  KEFU146227005669524   live800的客服ID
    // zhichi   KEFU146001495753714   智齿的客服ID
    chatService.conversationType = ConversationType_CUSTOMERSERVICE;
    
    chatService.targetId = kefuId;
    
    //上传用户信息，nickname是必须要填写的
    RCCustomerServiceInfo *csInfo = [[RCCustomerServiceInfo alloc] init];
    csInfo.userId = [RCIMClient sharedRCIMClient].currentUserInfo.userId;
    csInfo.nickName = @"昵称";
    csInfo.loginName = @"登录名称";
    csInfo.name = @"用户名称";
    csInfo.grade = @"11级";
    csInfo.gender = @"男";
    csInfo.birthday = @"2016.5.1";
    csInfo.age = @"36";
    csInfo.profession = @"software engineer";
    csInfo.portraitUrl =
    [RCIMClient sharedRCIMClient].currentUserInfo.portraitUri;
    csInfo.province = @"beijing";
    csInfo.city = @"beijing";
    csInfo.memo = @"这是一个好顾客!";
    
    csInfo.mobileNo = @"13800000000";
    csInfo.email = @"test@example.com";
    csInfo.address = @"北京市北苑路北泰岳大厦";
    csInfo.QQ = @"88888888";
    csInfo.weibo = @"my weibo account";
    csInfo.weixin = @"myweixin";
    
    csInfo.page = @"卖化妆品的页面来的";
    csInfo.referrer = @"客户端";
    csInfo.enterUrl = @"testurl";
    csInfo.skillId = @"技能组";
    csInfo.listUrl = @[@"用户浏览的第一个商品Url",
                       @"用户浏览的第二个商品Url"];
    csInfo.define = @"自定义信息";
    
    chatService.csInfo = csInfo;
    chatService.title = @"客服";
    
    [viewController.navigationController pushViewController:chatService animated:YES];
}

@end

























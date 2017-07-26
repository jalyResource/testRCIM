//
//  SIXLoginVCModel.m
//  testIM
//
//  Created by li’Pro on 2017/7/26.
//  Copyright © 2017年 6room. All rights reserved.
//

#import "SIXLoginVCModel.h"
#import "AppDelegate.h"
#import "RCDUtilities.h"
#import "SIXFindVCModel.h"

@interface SIXLoginVCModel ()

@property (assign, nonatomic) NSUInteger loginFailureTimes;

@end

@implementation SIXLoginVCModel


- (void)loadLocalData {
    self.phone = [[SIXUserManager shareUserManager] getDefaultPhone];
    self.password = [[SIXUserManager shareUserManager] getDefaultPassword];
    self.strToken = [[SIXUserManager shareUserManager] getDefaultToken];
    self.userId = [[SIXUserManager shareUserManager] getDefaultUserId];
}


/**
 * 连接融云 服务器
 */
- (void)connectedRCloudServer {
    [self.viewController showLoading];
    [[RCIM sharedRCIM] connectWithToken:self.strToken success:^(NSString *userId) {
        [self.viewController hiddenLoading];
        
        [[SIXUserManager shareUserManager] savaUserPhone:self.phone psw:self.password userId:self.userId token:self.strToken];
        
        [self connectedSuccessToRCServerUserId:userId];
        
    } error:^(RCConnectErrorCode status) {
        [self.viewController hiddenLoading];
        NSLog(@"登陆的错误码为:%lu", status);
    } tokenIncorrect:^{
        [self.viewController hiddenLoading];
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
        if (_loginFailureTimes < 1) {
            _loginFailureTimes++;
            [AFHttpTool getTokenSuccess:^(id response) {
                self.strToken = response[@"result"][@"token"];
                //                NSString *userId = response[@"result"][@"userId"];
                
                [self connectedRCloudServer];
            } failure:^(NSError *err) {
                DLog(@"%@", err);
            }];
        }
    }];
}

/**
 * 连接服务器成功后的处理操作
 */
- (void)connectedSuccessToRCServerUserId:(NSString *)userId {
    [self.viewController showLoading];
    [AFHttpTool getUserInfo:userId success:^(id response) {
        [self.viewController hiddenLoading];
        
        if ([response[@"code"] intValue] == 200) {
            NSDictionary *result = response[@"result"];
            
            NSString *nickname = result[@"nickname"];
            NSString *portraitUri = result[@"portraitUri"];
            
            [[SIXUserManager shareUserManager] saveUserName:nickname portrait:portraitUri];
            RCUserInfo *user = [[RCUserInfo alloc] initWithUserId:userId
                                                             name:nickname
                                                         portrait:portraitUri];
            if (!user.portraitUri || user.portraitUri.length <= 0) {
                user.portraitUri = [RCDUtilities defaultUserPortrait:user];
            }
            
            [[RCIM sharedRCIM] refreshUserInfoCache:user withUserId:userId];
            [RCIM sharedRCIM].currentUserInfo = user;
            //            [RCIM sharedRCIM].userInfoDataSource = [SIXUserManager shareUserManager];
            // 获取“发现” 列表的聊天室 的数据
            [self fetchSquareInfo];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                [delegate changeRootViewControllerType:EnumRootVCTypeMainTab];
            });
        }
    } failure:^(NSError *err) {
        [self.viewController hiddenLoading];
    }];
    /*
     {
     code = 200;
     result =     {
     id = dOl3N7KX1;
     nickname = momo;
     portraitUri = "";
     };
     }
     
     */
}

/**
 * 获取“发现” 列表的聊天室 的数据
 */
- (void)fetchSquareInfo {
    [self.viewController showLoading];
    [AFHttpTool getSquareInfoSuccess:^(id response) {
        [self.viewController hiddenLoading];
        
        NSInteger code = [response parseIntegerWithKey:@"code"];
        if (200 == code) {
            NSArray<NSDictionary *> *arrResult = [response objectForKey:@"result"];
            
            NSMutableArray<SIXChatRoom *> *arrChatRoom = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in arrResult) {
                NSString *type = [dic parseStringWithKey:@"type"];
                if ([type isEqualToString:@"chatroom"]) {
                    SIXChatRoom *room = [SIXChatRoom chatRoomWithDic:dic];
                    [arrChatRoom addObject:room];
                }
            }
            [SIXFindVCModel shareFindVCModel].arrChatRoom = arrChatRoom;
        }
        
    } Failure:^(NSError *err) {
        [self.viewController hiddenLoading];
    }];
}

@end

























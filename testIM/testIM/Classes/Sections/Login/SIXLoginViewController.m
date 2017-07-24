//
//  SIXLoginViewController.m
//  testIM
//
//  Created by li’Pro on 2017/7/21.
//  Copyright © 2017年 wzl. All rights reserved.
//

#import "SIXLoginViewController.h"
#import "AFHttpTool.h"
#import "AppDelegate.h"
#import "RCDUtilities.h"


@interface SIXLoginViewController ()
/** UI */
@property (strong, nonatomic) UITextField *txtPhone;
@property (strong, nonatomic) UITextField *txtPwd;

@property (strong, nonatomic) UIButton *btnLogin;
@property (strong, nonatomic) UIButton *btnUser1;
@property (strong, nonatomic) UIButton *btnUser2;

/** Data */
@property (copy, nonatomic) NSString *strToken;
@property (copy, nonatomic) NSString *phone;
@property (copy, nonatomic) NSString *password;
@property (copy, nonatomic) NSString *userId;

@property (assign, nonatomic) NSUInteger loginFailureTimes;

@end


@implementation SIXLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    [self adjustLoginState];
}

- (void)loadData {
    self.phone = [[SIXUserManager shareUserManager] getDefaultPhone];
    self.password = [[SIXUserManager shareUserManager] getDefaultPassword];
    self.strToken = [[SIXUserManager shareUserManager] getDefaultToken];
    self.userId = [[SIXUserManager shareUserManager] getDefaultUserId];
}

/**
 * 根据 本地 缓存的用户数据，判断是否已经登录
 */
- (void)adjustLoginState {
    if (0 != self.userId.length && 0!=self.strToken.length && 0!=self.password.length) {
        // 已经登录，利用 token 连接融云服务器
        [self connectedRCloudServer];
    } else {
        // 未登录状态，添加 UI
        [self addData];
    }
}

- (void)addData {
    [self.view addSubview:self.txtPhone];
    [self.view addSubview:self.txtPwd];
    [self.view addSubview:self.btnLogin];
    
    [self.view addSubview:self.btnUser1];
    [self.view addSubview:self.btnUser2];
    
    CGFloat margin = 30;
    CGFloat width = SIX_SCREEN_WIDTH - margin * 2;
    CGFloat height = 35;
    
    self.txtPhone.frame = CGRectMake(margin, 80, width, height);
    self.txtPwd.frame = CGRectMake(margin, 80 + 40, width, height);
    self.btnLogin.frame = CGRectMake(margin, CGRectGetMaxY(self.txtPwd.frame) + 40, width, height);
    
    self.btnUser1.frame = CGRectMake(margin, CGRectGetMaxY(self.btnLogin.frame) + 50, width/2 - margin, height);
    self.btnUser2.frame = CGRectMake(CGRectGetMaxX(self.btnUser1.frame) + margin * 2 , CGRectGetMaxY(self.btnLogin.frame) + 50, width/2 - margin, height);
}



#pragma -mark 
#pragma -mark event response
- (void)btnLoginClicked:(UIButton *)sender {
    NSString *phone = self.txtPhone.text;
    NSString *pwd = self.txtPwd.text;
    
    if ( 0 == phone.length || 0 == pwd.length) {
        return;
    }
    self.phone = phone;
    self.password = pwd;
    
    [self showLoading];
    [AFHttpTool loginWithPhone:phone password:pwd region:@"86" success:^(id response) {
        [self hiddenLoading];
        NSInteger code = [((NSDictionary *)response) parseIntegerWithKey:@"code"];
        if (200 == code) {
            NSDictionary *dicResult = [((NSDictionary *)response) objectForKey:@"result"];
            self.strToken = [dicResult parseStringWithKey:@"token"];
            self.userId = [dicResult parseStringWithKey:@"id"];
            
            [self connectedRCloudServer];
        } else {
            DLog(@"login error code : %lu", code);
        }
    } failure:^(NSError *err) {
        [self hiddenLoading];
        NSLog(@"login error: %@", err.userInfo);
    }];
    /*
     {
         code = 200;
         result =     {
             id = dOl3N7KX1;
             token = "pE0+d9lJf/cG5zDbfNaT8nxpRjANxKgfakOnYLFljI+9f8BoZjYD2yPZnhSOlBSHU7V/y0N5cAqKIbowfrZGGw==";
         };
     }

     */
}

- (void)btnUser1Clicked:(UIButton *)sender {
    self.txtPhone.text = @"13651037787";
    self.txtPwd.text = @"123456";
}
- (void)btnUser2Clicked:(UIButton *)sender {
    self.txtPhone.text = @"13651023662";
    self.txtPwd.text = @"123321";
}

#pragma -mark 
#pragma -mark private 
/**
 * 连接融云 服务器
 */
- (void)connectedRCloudServer {
    [self showLoading];
    [[RCIM sharedRCIM] connectWithToken:self.strToken success:^(NSString *userId) {
        [self hiddenLoading];
        
        [[SIXUserManager shareUserManager] savaUserPhone:self.phone psw:self.password userId:self.userId token:self.strToken];
        
        [self connectedSuccessToRCServerUserId:userId];
        
    } error:^(RCConnectErrorCode status) {
        [self hiddenLoading];
        NSLog(@"登陆的错误码为:%lu", status);
    } tokenIncorrect:^{
        [self hiddenLoading];
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
    [self showLoading];
    [AFHttpTool getUserInfo:userId success:^(id response) {
        [self hiddenLoading];
        
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
    
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                [delegate changeRootViewControllerType:EnumRootVCTypeMainTab];
            });
        }
    } failure:^(NSError *err) {
        [self hiddenLoading];
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


#pragma -mark 
#pragma -mark getter and setter
- (UIButton *)btnLogin {
    if (!_btnLogin) {
        _btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnLogin setBackgroundColor:[UIColor blueColor]];
        [_btnLogin setTitle:@"登录" forState:UIControlStateNormal];
        [_btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnLogin addTarget:self action:@selector(btnLoginClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnLogin;
}

- (UIButton *)btnUser1 {
    if (!_btnUser1) {
        _btnUser1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnUser1 setBackgroundColor:[UIColor blueColor]];
        [_btnUser1 setTitle:@"User 1" forState:UIControlStateNormal];
        [_btnUser1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnUser1 addTarget:self action:@selector(btnUser1Clicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnUser1;
}

- (UIButton *)btnUser2 {
    if (!_btnUser2) {
        _btnUser2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnUser2 setBackgroundColor:[UIColor blueColor]];
        [_btnUser2 setTitle:@"User 2" forState:UIControlStateNormal];
        [_btnUser2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnUser2 addTarget:self action:@selector(btnUser2Clicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnUser2;
}

- (UITextField *)txtPhone {
    if (!_txtPhone) {
        _txtPhone = [[UITextField alloc] init];
        _txtPhone.placeholder = @"请输入手机号";
    }
    return _txtPhone;
}

- (UITextField *)txtPwd {
    if (!_txtPwd) {
        _txtPwd = [[UITextField alloc] init];
        _txtPwd.placeholder = @"请输入密码";
        _txtPwd.secureTextEntry = YES;
    }
    return _txtPwd;
}

@end

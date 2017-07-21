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

/** Data */
@property (strong, nonatomic) NSString *strToken;

@property (assign, nonatomic) NSUInteger loginFailureTimes;

@end


@implementation SIXLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addData];
}

- (void)addData {
    [self.view addSubview:self.txtPhone];
    [self.view addSubview:self.txtPwd];
    [self.view addSubview:self.btnLogin];
    
    [self.view addSubview:self.btnUser1];
    
    CGFloat margin = 30;
    CGFloat width = SIX_SCREEN_WIDTH - margin * 2;
    CGFloat height = 35;
    
    self.txtPhone.frame = CGRectMake(margin, 80, width, height);
    self.txtPwd.frame = CGRectMake(margin, 80 + 40, width, height);
    self.btnLogin.frame = CGRectMake(margin, CGRectGetMaxY(self.txtPwd.frame) + 40, width, height);
    
    self.btnUser1.frame = CGRectMake(margin, CGRectGetMaxY(self.btnLogin.frame) + 20, width/2 - margin, height);
}

#pragma -mark 
#pragma -mark event response
- (void)btnLoginClicked:(UIButton *)sender {
    NSString *phone = self.txtPhone.text;
    NSString *pwd = self.txtPwd.text;
    
    if ( 0 == phone.length || 0 == pwd.length) {
        return;
    }
    
    [AFHttpTool loginWithPhone:phone password:pwd region:@"86" success:^(id response) {
        NSInteger code = [((NSDictionary *)response) parseIntegerWithKey:@"code"];
        if (200 == code) {
            NSDictionary *dicResult = [((NSDictionary *)response) objectForKey:@"result"];
            self.strToken = [dicResult parseStringWithKey:@"token"];
            [self connectedRCloudServer];
        } else {
            DLog(@"login error code : %lu", code);
        }
    } failure:^(NSError *err) {
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

#pragma -mark 
#pragma -mark private 
- (void)connectedRCloudServer {
    
    [[RCIM sharedRCIM] connectWithToken:self.strToken success:^(NSString *userId) {
        [SIXUserManager savaUserId:userId token:self.strToken];
//        NSLog(@"%@", [NSThread currentThread]);
        [self connectedSuccessToRCServerUserId:userId];
        
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%lu", status);
    } tokenIncorrect:^{
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


- (void)connectedSuccessToRCServerUserId:(NSString *)userId {
    [AFHttpTool getUserInfo:userId success:^(id response) {
        if ([response[@"code"] intValue] == 200) {
            NSDictionary *result = response[@"result"];
            
            NSString *nickname = result[@"nickname"];
            NSString *portraitUri = result[@"portraitUri"];
            RCUserInfo *user = [[RCUserInfo alloc] initWithUserId:userId
                                                             name:nickname
                                                         portrait:portraitUri];
            if (!user.portraitUri || user.portraitUri.length <= 0) {
                user.portraitUri = [RCDUtilities defaultUserPortrait:user];
            }
            [[RCIM sharedRCIM] refreshUserInfoCache:user withUserId:userId];
            [RCIM sharedRCIM].currentUserInfo = user;
            
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                [delegate changeRootViewControllerType:EnumRootVCTypeMainTab];
            });
            
            
//            [[RCDataBaseManager shareInstance] insertUserToDB:user];
//            
//            [DEFAULTS setObject:user.portraitUri forKey:@"userPortraitUri"];
//            [DEFAULTS setObject:user.name forKey:@"userNickName"];
//            [DEFAULTS synchronize];
        }
    } failure:^(NSError *err) {
        ;
    }];
    
    
    
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

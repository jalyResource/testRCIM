//
//  SIXLoginViewController.m
//  testIM
//
//  Created by li’Pro on 2017/7/21.
//  Copyright © 2017年 wzl. All rights reserved.
//

#import "SIXLoginViewController.h"
#import "AFHttpTool.h"


@interface SIXLoginViewController ()

@property (strong, nonatomic) UITextField *txtPhone;
@property (strong, nonatomic) UITextField *txtPwd;

@property (strong, nonatomic) UIButton *btnLogin;
@property (strong, nonatomic) UIButton *btnUser1;

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

- (void)btnLoginClicked:(UIButton *)sender {
    NSString *phone = self.txtPhone.text;
    NSString *pwd = self.txtPwd.text;
    
    if ( 0 == phone.length || 0 == pwd.length) {
        return;
    }
    
    [AFHttpTool loginWithPhone:phone password:pwd region:@"86" success:^(id response) {
        NSLog(@"success: %@", response);
    } failure:^(NSError *err) {
        NSLog(@"error: %@", err.userInfo);
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

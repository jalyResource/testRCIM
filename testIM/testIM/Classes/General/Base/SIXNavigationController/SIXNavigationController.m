//
//  SIXNavigationController.m
//  sixLive
//
//  Created by li’Pro on 2017/6/27.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXNavigationController.h"

@interface SIXNavigationController ()

@end

@implementation SIXNavigationController

+ (void)initialize {
    //统一导航条样式
    UIFont *font = [UIFont systemFontOfSize:18.f];
    NSDictionary *textAttributes = @{
                                     NSFontAttributeName : font,
                                     NSForegroundColorAttributeName : TEXT_COLOR_33
                                     };
    // Display attributes for the bar’s title text.
    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];
    
    [[UINavigationBar appearance] setTintColor:TEXT_COLOR_33];
//    [[UINavigationBar appearance] setBarTintColor:TEXT_COLOR_33];
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end













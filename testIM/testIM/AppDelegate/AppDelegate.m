//
//  AppDelegate.m
//  testIM
//
//  Created by li’Pro on 2017/7/20.
//  Copyright © 2017年 wzl. All rights reserved.
//

#import "AppDelegate.h"
#import "AppContext.h"
#import "SIXLoginViewController.h"


@interface AppDelegate ()
@property (strong, nonatomic) SIXNavigationController *rootNavigationController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [AppContext setUpDidFinishLaunchingWithOptions];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    SIXLoginViewController *vc = [[SIXLoginViewController alloc] init];
    
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    NSLog(@"didFinishLaunchingWithOptions RC Statu: %ld", [RCIM sharedRCIM].getConnectionStatus);
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    NSLog(@"applicationDidEnterBackground RC Statu: %ld", [RCIM sharedRCIM].getConnectionStatus);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"applicationDidEnterBackground RC Statu: %ld", [RCIM sharedRCIM].getConnectionStatus);
    });
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    NSLog(@"applicationWillEnterForeground RC Statu: %ld", [RCIM sharedRCIM].getConnectionStatus);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"applicationWillEnterForeground RC Statu: %ld", [RCIM sharedRCIM].getConnectionStatus);
    });
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma -mark 
#pragma -mark public
- (void)changeRootViewControllerType:(EnumRootVCType)type {
    switch (type) {
        case EnumRootVCTypeLogin: {
            self.window.rootViewController = [[SIXLoginViewController alloc] init];
            _rootNavigationController = nil;
            [self.window makeKeyAndVisible];
            break;
        }
        case EnumRootVCTypeMainTab: {
            self.window.rootViewController = self.rootNavigationController;
            [self.window makeKeyAndVisible];
            break;
        }
    }
}



#pragma -mark 
#pragma -mark getter
- (SIXNavigationController *)rootNavigationController {
    if (!_rootNavigationController) {
        SIXMainTabBarController *tabVC = [[SIXMainTabBarController alloc] init];
        _rootNavigationController = [[SIXNavigationController alloc] initWithRootViewController:tabVC];
    }
    return _rootNavigationController;
}

@end
































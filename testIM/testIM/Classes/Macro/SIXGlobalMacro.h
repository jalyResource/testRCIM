//
//  SIXGlobalMacro.h
//  sixLive
//
//  Created by li’Pro on 2017/6/27.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#ifndef SIXGlobalMacro_h
#define SIXGlobalMacro_h



#define WS __weak typeof(self) ws = self;


/*
 *  屏幕宽度
 */
#define SIX_SCREEN_WIDTH ([[UIScreen mainScreen]bounds].size.width)

/*
 *  屏幕高度  
 */
#define SIX_SCREEN_HEIGHT ([[UIScreen mainScreen]bounds].size.height)

/*
 *  状态栏高度  
 */
#define SIX_STATUSBAR_HEIGHT [UIApplication sharedApplication].statusBarFrame.size.height

/*
 *  导航栏高度  
 */
#define SIX_NAVIGATIONBAR_HEIGHT 45.0


/**
 * 切换程序根控制器 的类型
 */
typedef NS_ENUM(NSUInteger, EnumRootVCType) {
    EnumRootVCTypeMainTab = 0, // 登录后的 tab vc
    EnumRootVCTypeLogin   = 1  // 登录界面
};



/** 自定义 log */
#ifdef DEBUG
    #define DLog(...) NSLog(__VA_ARGS__);
#else
    #define DLog(...);
#endif


#endif /* SIXGlobalMacro_h */

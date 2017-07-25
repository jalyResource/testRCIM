//
//  SIXEnum.h
//  testIM
//
//  Created by li’Pro on 2017/7/25.
//  Copyright © 2017年 6room. All rights reserved.
//

#ifndef SIXEnum_h
#define SIXEnum_h

typedef NS_ENUM(NSUInteger, EnumHttpCode) {
    EnumHttpCodeFaile   =  402, // 失败
    EnumHttpCodeSuccess =  001 // 成功
};



/**
 * 切换程序根控制器 的类型
 */
typedef NS_ENUM(NSUInteger, EnumRootVCType) {
    EnumRootVCTypeMainTab = 0, // 登录后的 tab vc
    EnumRootVCTypeLogin   = 1  // 登录界面
};

typedef void(^RequestCompletionBlock)(EnumHttpCode code, NSString *text);




#endif /* SIXEnum_h */

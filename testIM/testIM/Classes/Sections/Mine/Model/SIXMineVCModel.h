//
//  SIXMineVCModel.h
//  testIM
//
//  Created by li’Pro on 2017/7/26.
//  Copyright © 2017年 6room. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIXMineInfoCell.h"
#import "SIXMineNormalCell.h"

typedef NS_ENUM(NSUInteger, EnumMineCellType) {
    EnumMineCellTypeInfo     = 1, // 个人信息
    EnumMineCellTypeLogout   = 2, // 退出登录
    EnumMineCellTypeFeedback = 3, // 意见反馈
};

@interface SIXMineVCModel : NSObject

/**
 * public
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView ;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section ;

- (EnumMineCellType)cellTypeAtIndexPath:(NSIndexPath *)indexPath ;

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath ;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath fromVC:(__kindof SIXViewController *)viewController ;



@end

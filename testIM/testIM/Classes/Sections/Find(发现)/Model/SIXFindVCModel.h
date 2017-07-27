//
//  SIXFindVCModel.h
//  testIM
//
//  Created by li’Pro on 2017/7/26.
//  Copyright © 2017年 6room. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIXChatRoom.h"

@interface SIXFindVCModel : NSObject

@property (strong, nonatomic) NSArray<SIXChatRoom *> *arrChatRoom;

+ (instancetype)shareFindVCModel ;


/**
 * public
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView ;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section ;

//- (EnumMineCellType)cellTypeAtIndexPath:(NSIndexPath *)indexPath ;
- (SIXChatRoom *)modelAtIndexPath:(NSIndexPath *)indexPath ;
- (NSString *)imageNameAtIndexPath:(NSIndexPath *)indexPath ;

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath ;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath fromVC:(__kindof SIXViewController *)viewController ;




@end

//
//  SIXContactVCModel.h
//  testIM
//
//  Created by li’Pro on 2017/7/25.
//  Copyright © 2017年 6room. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SIXContact;

@interface SIXContactVCModel : NSObject

/**
 * public
 */
- (void)fetchFriendListCompletion:(RequestCompletionBlock)completion ;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView ;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section ;

- (SIXContact *)contactAtIndexPath:(NSIndexPath *)indexPath ;


@end

//
//  SIXLoginVCModel.h
//  testIM
//
//  Created by li’Pro on 2017/7/26.
//  Copyright © 2017年 6room. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SIXLoginVCModel : NSObject

@property (copy, nonatomic) NSString *phone;
@property (copy, nonatomic) NSString *password;
@property (copy, nonatomic) NSString *userId;

@property (copy, nonatomic) NSString *strToken;

@property (weak, nonatomic) SIXViewController *viewController;

- (void)loadLocalData ;
/**
 * 连接融云 服务器
 */
- (void)connectedRCloudServer ; 

- (void)fetchSquareInfo ;

@end

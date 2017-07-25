//
//  SIXContactVCModel.m
//  testIM
//
//  Created by li’Pro on 2017/7/25.
//  Copyright © 2017年 6room. All rights reserved.
//

#import "SIXContactVCModel.h"
#import "SIXContact.h"

@interface SIXContactVCModel ()

@property (strong, nonatomic) NSArray<SIXContact *> *arrFriend;

@end

@implementation SIXContactVCModel

- (void)fetchFriendListCompletion:(RequestCompletionBlock)completion {
    
    [AFHttpTool getFriendListFromServerSuccess:^(id response) {
        NSInteger code = [response parseIntegerWithKey:@"code"];
        if (200 == code) {
            NSArray *arrResult = [response objectForKey:@"result"];
            self.arrFriend = [SIXContact contactArrayWithDicArray:arrResult];
            
            completion(EnumHttpCodeSuccess, nil);
        } else {
            completion(EnumHttpCodeFaile, @"error");
        }
    } failure:^(NSError *error) {
        NSLog(@"error: %@", error);
    }];
    /*
     {
         code = 200;
         result =     (
            {
                 displayName = "";
                 message = "\U6211\U662fJaly2012";
                 status = 20;
                 updatedAt = "2017-07-20T09:24:38.000Z";
                 user =             {
                     id = TcnJXvflj;
                     nickname = Jaly2012;
                     phone = 13651023662;
                     portraitUri = "http://7xogjk.com1.z0.glb.clouddn.com/TcnJXvflj1500517892245656006";
                     region = 86;
                 };
             }
         );
     }

     */
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrFriend.count;
}

- (SIXContact *)contactAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.arrFriend.count) {
        return self.arrFriend[indexPath.row];
    }
    return nil;
}

@end

























//
//  SIXMineVCModel.m
//  testIM
//
//  Created by li’Pro on 2017/7/26.
//  Copyright © 2017年 6room. All rights reserved.
//

#import "SIXMineVCModel.h"

@interface SIXMineVCModel ()

@property (copy, nonatomic) NSArray<NSNumber *> *arrCellType;

@end

@implementation SIXMineVCModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arrCellType = @[@(EnumMineCellTypeFeedback), @(EnumMineCellTypeLogout)];
    }
    return self;
}

/**
 * public
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0 == section) {
        return 1;
    }
    return self.arrCellType.count;
}

- (EnumMineCellType)cellTypeAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        return EnumMineCellTypeInfo;
    } else if (1 == indexPath.section) {
        return [self.arrCellType[indexPath.row] integerValue];
    }
    // 
    return EnumMineCellTypeInfo;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        return 88;
    }
    return 44;
}

@end

























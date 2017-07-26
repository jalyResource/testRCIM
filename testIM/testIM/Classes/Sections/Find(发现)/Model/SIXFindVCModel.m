//
//  SIXFindVCModel.m
//  testIM
//
//  Created by li’Pro on 2017/7/26.
//  Copyright © 2017年 6room. All rights reserved.
//

#import "SIXFindVCModel.h"

@implementation SIXFindVCModel

+ (instancetype)shareFindVCModel {
    static SIXFindVCModel *ins = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ins = [[self alloc] init];
    });
    
    return ins;
}
@end

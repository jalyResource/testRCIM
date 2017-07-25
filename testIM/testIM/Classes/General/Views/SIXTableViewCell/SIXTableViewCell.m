//
//  SIXTableViewCell.m
//  testIM
//
//  Created by li’Pro on 2017/7/25.
//  Copyright © 2017年 6room. All rights reserved.
//

#import "SIXTableViewCell.h"

@implementation SIXTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)six_reuseIdentifier {
    return NSStringFromClass([self class]);
}
+ (CGFloat)six_cellHeight {
    return 44.;
}

@end

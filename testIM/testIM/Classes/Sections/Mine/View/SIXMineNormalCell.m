//
//  SIXMineNormalCell.m
//  testIM
//
//  Created by li’Pro on 2017/7/26.
//  Copyright © 2017年 6room. All rights reserved.
//

#import "SIXMineNormalCell.h"

@implementation SIXMineNormalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.textLabel.textColor = TEXT_COLOR_33;
        self.textLabel.textAlignment = NSTextAlignmentLeft;
    }
    return self;
}

- (void)setText:(NSString *)text ;{
    self.textLabel.text = text;
}


@end

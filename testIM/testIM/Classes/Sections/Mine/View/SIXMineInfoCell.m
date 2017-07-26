//
//  SIXMineInfoCell.m
//  testIM
//
//  Created by li’Pro on 2017/7/26.
//  Copyright © 2017年 6room. All rights reserved.
//

#import "SIXMineInfoCell.h"

@interface SIXMineInfoCell ()

@property (strong, nonatomic) UIImageView *imgViewIcon;

@property (strong, nonatomic) UILabel *lblName;

@end


@implementation SIXMineInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self.contentView addSubview:self.imgViewIcon];
        [self.contentView addSubview:self.lblName];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat margin = 15;
    CGFloat topMagin = 10;
    CGFloat iconH = self.contentView.height - 2 * topMagin;
    self.imgViewIcon.frame = CGRectMake(margin, topMagin, iconH, iconH);
    
    CGFloat lblX = CGRectGetMaxX(self.imgViewIcon.frame) + margin;
    self.lblName.frame = CGRectMake(lblX, topMagin, 200, iconH);
}


#pragma -mark 
#pragma -mark getter and setter
- (void)setName:(NSString *)name portrait:(NSString *)portrait {
    self.lblName.text = name;
    [self.imgViewIcon sd_setImageWithURL:[NSURL URLWithString:portrait]];
}

- (UILabel *)lblName {
    if (!_lblName) {
        _lblName = [[UILabel alloc] init];
        _lblName.textColor = TEXT_COLOR_33;
        _lblName.numberOfLines = 0;
        _lblName.font = [UIFont systemFontOfSize:14];
        _lblName.textAlignment = NSTextAlignmentLeft;
    }
    return _lblName;
}

- (UIImageView *)imgViewIcon {
    if (!_imgViewIcon) {
        _imgViewIcon = [[UIImageView alloc] init];
        _imgViewIcon.layer.masksToBounds = YES;
        _imgViewIcon.layer.cornerRadius = 5;
        _imgViewIcon.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _imgViewIcon.layer.borderWidth = 1.;
        _imgViewIcon.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imgViewIcon;
}

@end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

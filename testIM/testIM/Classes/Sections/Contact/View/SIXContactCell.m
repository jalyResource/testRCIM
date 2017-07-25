//
//  SIXContactCell.m
//  testIM
//
//  Created by li’Pro on 2017/7/25.
//  Copyright © 2017年 6room. All rights reserved.
//

#import "SIXContactCell.h"
#import "SIXContact.h"

@interface SIXContactCell ()

@property (strong, nonatomic) UIImageView *imgViewIcon;

@property (strong, nonatomic) UILabel *lblName;

@end

@implementation SIXContactCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.imgViewIcon];
        [self.contentView addSubview:self.lblName];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat topMargin = 5;
    CGFloat height = (self.contentView.height - topMargin * 2);
    CGRect frameIcon = CGRectMake(15, topMargin, height, height);
    self.imgViewIcon.frame = frameIcon;
    
    CGRect framelbl = CGRectMake(0, 0, 0, 0);
    framelbl.origin.x = CGRectGetMaxX(frameIcon) + 10;
    CGFloat h = 15;
    CGFloat y = (self.contentView.height - h) / 2.;
    framelbl.size.height = h;
    framelbl.origin.y = y;
    framelbl.size.width = 200;
    self.lblName.frame = framelbl;
}

- (void)setContact:(SIXContact *)contact {
    _contact = contact;
    
    [self.imgViewIcon sd_setImageWithURL:[NSURL URLWithString:contact.user.portraitUri]];
    self.lblName.text = [contact getShowingName];
    
    [self setNeedsLayout];
}


#pragma -mark 
#pragma -mark getter
- (UIImageView *)imgViewIcon {
    if (!_imgViewIcon) {
        _imgViewIcon = [[UIImageView alloc] init];
        _imgViewIcon.contentMode = UIViewContentModeScaleAspectFill;
        _imgViewIcon.layer.cornerRadius = 5.;
    }
    return _imgViewIcon;
}
- (UILabel *)lblName {
    if (!_lblName) {
        _lblName = [[UILabel alloc] init];
        _lblName.textColor = [UIColor colorWithHex:0x333333];
        _lblName.font = [UIFont systemFontOfSize:14];
        _lblName.textAlignment = NSTextAlignmentLeft;
    }
    return _lblName;
}
@end


























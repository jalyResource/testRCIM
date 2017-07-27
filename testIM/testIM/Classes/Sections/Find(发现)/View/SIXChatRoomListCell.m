//
//  SIXChatRoomListCell.m
//  testIM
//
//  Created by li’Pro on 2017/7/27.
//  Copyright © 2017年 6room. All rights reserved.
//

#import "SIXChatRoomListCell.h"
#import "SIXChatRoom.h"

@interface SIXChatRoomListCell ()

@property (strong, nonatomic) UIImageView *imgViewIcon;

@property (strong, nonatomic) UILabel *lblName;

@end
@implementation SIXChatRoomListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    self.lblName.frame = CGRectMake(lblX, topMagin, 220, iconH);
}


#pragma -mark 
#pragma -mark getter and setter
- (void)setChatRoom:(SIXChatRoom *)chatRoom {
    _chatRoom = chatRoom;
    
    self.lblName.text = chatRoom.name;
}
- (void)setImageName:(NSString *)imgName {
    self.imgViewIcon.image = [UIImage imageNamed:imgName];
}

- (UILabel *)lblName {
    if (!_lblName) {
        _lblName = [[UILabel alloc] init];
        _lblName.textColor = TEXT_COLOR_33;
        _lblName.font = [UIFont systemFontOfSize:15];
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

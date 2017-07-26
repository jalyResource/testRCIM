//
//  SIXProductMessageCell.m
//  testIM
//
//  Created by li’Pro on 2017/7/25.
//  Copyright © 2017年 6room. All rights reserved.
//

#import "SIXProductMessageCell.h"
// messageContentView 高度
static CGFloat const kMsgContviewH = 80;

@interface SIXProductMessageCell ()
@property (strong, nonatomic) UIImageView *imgViewBackground;
@property (strong, nonatomic) UIImageView *imgViewIcon;

@property (strong, nonatomic) UILabel *lblName;
@property (strong, nonatomic) UILabel *lblPrice;

@end

@implementation SIXProductMessageCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.messageContentView.backgroundColor = [UIColor whiteColor];
//        self.messageContentView.layer.borderColor = [UIColor grayColor].CGColor;
//        self.messageContentView.layer.borderWidth = 1.;
//        self.messageContentView.layer.cornerRadius = 5;
//        self.messageContentView.layer.masksToBounds = YES;
        
        
        [self.messageContentView addSubview:self.imgViewBackground];
        [self.messageContentView addSubview:self.imgViewIcon];
        [self.messageContentView addSubview:self.lblPrice];
        [self.messageContentView addSubview:self.lblName];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x = [RCIM sharedRCIM].globalConversationPortraitSize.width + 16;
    CGFloat msgContentViewMarginTotal = x * 2;
    CGFloat msgContentViewWidth = self.contentView.width - msgContentViewMarginTotal;
    CGRect frame = self.messageContentView.frame;
    frame.origin.x = x;
    frame.size = CGSizeMake(msgContentViewWidth, kMsgContviewH);
    self.messageContentView.frame = frame;
    self.imgViewBackground.frame = self.messageContentView.bounds;
    
    // icon
    CGFloat margin = 10;
    CGFloat iconW = kMsgContviewH - margin * 2;
    self.imgViewIcon.frame = CGRectMake(margin, margin, iconW, iconW);
    
    
    // name
    CGFloat nameX = margin * 2 + iconW;
    CGFloat nameW = msgContentViewWidth  - nameX - margin;
    CGFloat nameH = ( kMsgContviewH - 2 * margin ) *0.7;
    self.lblName.frame = CGRectMake(nameX, margin, nameW, nameH);
    // price
    CGFloat priceH = kMsgContviewH - margin - CGRectGetMaxY(self.lblName.frame);
    self.lblPrice.frame = CGRectMake(nameX, CGRectGetMaxY(self.lblName.frame), nameW, priceH);
}

/*!
 自定义消息 Cell 的 Size
 
 @param model               要显示的消息model
 @param collectionViewWidth cell所在的collectionView的宽度
 @param extraHeight         cell内容区域之外的高度
 
 @return 自定义消息Cell的Size
 
 @discussion 当应用自定义消息时，必须实现该方法来返回cell的Size。
 其中，extraHeight是Cell根据界面上下文，需要额外显示的高度（比如时间、用户名的高度等）。
 一般而言，Cell的高度应该是内容显示的高度再加上extraHeight的高度。
 */
+ (CGSize)sizeForMessageModel:(RCMessageModel *)model
      withCollectionViewWidth:(CGFloat)collectionViewWidth
         referenceExtraHeight:(CGFloat)extraHeight {
//    CGFloat msgContentViewMargin = ([RCIM sharedRCIM].globalConversationPortraitSize.width + 16) * 2;
//    
//    CGFloat width = collectionViewWidth - 2 * msgContentViewMargin;
    return CGSizeMake(collectionViewWidth, extraHeight + kMsgContviewH);
}

#pragma -mark 
#pragma -mark getter and setter
- (void)setModel:(RCMessageModel *)model {
    [super setModel:model];
    
    NSString *imgName = @"chat_from_bg_normal";
    if (MessageDirection_SEND == model.messageDirection) {
        imgName = @"chat_to_bg_white";
    }
    UIImage *img = [UIImage imageNamed:imgName];
    CGSize imgSize = img.size;
    img = [img stretchableImageWithLeftCapWidth:(imgSize.width * 0.5) topCapHeight:(imgSize.height * 0.8)];
    self.imgViewBackground.image = img;
    
    [self setMessageContent:model.content];
}

- (void)setMessageContent:(RCMessageContent *)messageContent {
    
    if ([messageContent isKindOfClass:[SIXProductMessageContent class]]) {
        SIXProductMessageContent *productMessage = (SIXProductMessageContent *)messageContent;
        
        self.lblName.text = productMessage.name;
        self.lblPrice.text = [NSString stringWithFormat:@"¥ %.2f", productMessage.price];
        [self.imgViewIcon sd_setImageWithURL:[NSURL URLWithString:productMessage.imageUrlString]];
        
        [self setNeedsLayout];
    }
}

- (UILabel *)lblName {
    if (!_lblName) {
        _lblName = [[UILabel alloc] init];
        _lblName.textColor = TEXT_COLOR_33;
        _lblName.numberOfLines = 0;
        _lblName.font = [UIFont systemFontOfSize:15];
        _lblName.textAlignment = NSTextAlignmentLeft;
    }
    return _lblName;
}

- (UILabel *)lblPrice {
    if (!_lblPrice) {
        _lblPrice = [[UILabel alloc] init];
        _lblPrice.textColor = TEXT_COLOR_RED;
        _lblPrice.font = [UIFont systemFontOfSize:14];
        _lblPrice.textAlignment = NSTextAlignmentLeft;
    }
    return _lblPrice;
}

- (UIImageView *)imgViewBackground {
    if (!_imgViewBackground) {
        _imgViewBackground = [[UIImageView alloc] init];
        _imgViewBackground.contentMode = UIViewContentModeScaleToFill;
    }
    return _imgViewBackground;
}

- (UIImageView *)imgViewIcon {
    if (!_imgViewIcon) {
        _imgViewIcon = [[UIImageView alloc] init];
        _imgViewIcon.layer.masksToBounds = YES;
        _imgViewIcon.layer.cornerRadius = 5;
        _imgViewIcon.layer.borderColor = [UIColor grayColor].CGColor;
        _imgViewIcon.layer.borderWidth = 1.;
        _imgViewIcon.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imgViewIcon;
}
@end

























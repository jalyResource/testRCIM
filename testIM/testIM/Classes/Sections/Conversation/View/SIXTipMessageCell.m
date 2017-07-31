//
//  SIXTipMessageCell.m
//  testIM
//
//  Created by li’Pro on 2017/7/25.
//  Copyright © 2017年 6room. All rights reserved.
//

#import "SIXTipMessageCell.h"
#import "SIXTipMessageContent.h"

static CGFloat const kTipHorizontalMargin = 15.f;

@interface SIXTipMessageCell ()

@property (strong, nonatomic) UILabel *lblTip;

@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;

@end

@implementation SIXTipMessageCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.baseContentView addSubview:self.lblTip];
        [self.contentView addGestureRecognizer:self.tapGesture];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat y = 10;
    CGFloat x = kTipHorizontalMargin;
    CGFloat width = self.baseContentView.width - 2 * x;
    CGFloat textH = [self.lblTip.text textHeightWithFont:[UIFont systemFontOfSize:13] width:width];
    self.lblTip.frame = CGRectMake(x, y, width, textH);
}

- (void)setModel:(RCMessageModel *)model {
    [super setModel:model];
    
    [self setMessageContent:model.content];
}

- (void)setMessageContent:(RCMessageContent *)messageContent {
    
    if ([messageContent isKindOfClass:[SIXTipMessageContent class]]) {
        SIXTipMessageContent *tipMessage = (SIXTipMessageContent *)messageContent;
        
        self.lblTip.text = tipMessage.tipText;
        
        [self setNeedsLayout];
    }
}

/*!
 自定义消息 Cell 的 Size
 */
+ (CGSize)sizeForMessageModel:(RCMessageModel *)model
      withCollectionViewWidth:(CGFloat)collectionViewWidth
         referenceExtraHeight:(CGFloat)extraHeight {
    SIXTipMessageContent *tipMessage = (SIXTipMessageContent *)model.content;
    
    CGFloat textW = collectionViewWidth - kTipHorizontalMargin * 2;
    CGFloat textH = [tipMessage.tipText textHeightWithFont:[UIFont systemFontOfSize:13] width:textW];
    
    return CGSizeMake(collectionViewWidth, extraHeight + textH);
}
#pragma -mark 
#pragma -mark event response
- (void)tapGestureDidClicked:(UITapGestureRecognizer *)gesture {
    CGPoint point = [gesture locationInView:self.baseContentView];
    
    if (CGRectContainsPoint(self.lblTip.frame, point)) {
        if ([self.tipDelegate respondsToSelector:@selector(tipMessageCell:didTapTipText:)]) {
            [self.tipDelegate tipMessageCell:self didTapTipText:self.lblTip.text];
        }
    }
}

#pragma -mark 
#pragma -mark getter
- (UITapGestureRecognizer *)tapGesture {
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureDidClicked:)];
    }
    return _tapGesture;
}

- (UILabel *)lblTip {
    if (!_lblTip) {
        _lblTip = [[UILabel alloc] init];
        _lblTip.textColor = [UIColor colorWithHex:0x333333];
        _lblTip.textAlignment = NSTextAlignmentCenter;
        _lblTip.font = [UIFont systemFontOfSize:13];
        _lblTip.numberOfLines = 0;
        _lblTip.userInteractionEnabled = NO;
        _lblTip.backgroundColor = [UIColor clearColor];
    }
    return _lblTip;
}

@end

























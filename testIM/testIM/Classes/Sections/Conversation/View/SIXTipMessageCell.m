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

@end

@implementation SIXTipMessageCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.baseContentView addSubview:self.lblTip];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat y = 10;
    CGFloat x = kTipHorizontalMargin;
    CGFloat width = self.baseContentView.width;
    CGFloat textH = [self.lblTip.text textHeightWithFont:[UIFont systemFontOfSize:13] width:width];
    self.lblTip.frame = CGRectMake(x, y, width, textH);
}

- (void)setMessageContent:(RCMessageContent *)messageContent {
    if ([messageContent isKindOfClass:[SIXTipMessageContent class]]) {
        SIXTipMessageContent *tipMessage = (SIXTipMessageContent *)messageContent;
        
        _messageContent = messageContent;
        self.lblTip.text = tipMessage.tipText;
        
        [self setNeedsLayout];
    }
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
    SIXTipMessageContent *tipMessage = (SIXTipMessageContent *)model.content;
    
    CGFloat textW = collectionViewWidth - kTipHorizontalMargin * 2;
    CGFloat textH = [tipMessage.tipText textHeightWithFont:[UIFont systemFontOfSize:13] width:textW];
    
    return CGSizeMake(collectionViewWidth, extraHeight + textH);
}

#pragma -mark 
#pragma -mark getter
- (UILabel *)lblTip {
    if (!_lblTip) {
        _lblTip = [[UILabel alloc] init];
        _lblTip.textColor = [UIColor colorWithHex:0x333333];
        _lblTip.textAlignment = NSTextAlignmentCenter;
        _lblTip.font = [UIFont systemFontOfSize:13];
        _lblTip.numberOfLines = 0;
    }
    return _lblTip;
}

@end

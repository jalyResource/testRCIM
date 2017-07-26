//
//  SIXProductMessageContent.h
//  testIM
//
//  Created by li’Pro on 2017/7/25.
//  Copyright © 2017年 6room. All rights reserved.
//

#import <RongIMLib/RongIMLib.h>

@interface SIXProductMessageContent : RCMessageContent
/** 商品连接 */
@property (copy, nonatomic) NSString *url;
/** 图片 */
@property (copy, nonatomic) NSString *imageUrlString;
/** 名称 */
@property (copy, nonatomic) NSString *name;
/** 价格 */
@property (assign, nonatomic) CGFloat price;

+ (instancetype)productUrl:(NSString *)url imageUrl:(NSString *)imgUrl name:(NSString *)name price:(CGFloat)price ;

@end

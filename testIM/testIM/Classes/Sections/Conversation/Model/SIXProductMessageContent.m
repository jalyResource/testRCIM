//
//  SIXProductMessageContent.m
//  testIM
//
//  Created by li’Pro on 2017/7/25.
//  Copyright © 2017年 6room. All rights reserved.
//

#import "SIXProductMessageContent.h"

@implementation SIXProductMessageContent

+ (instancetype)productUrl:(NSString *)url imageUrl:(NSString *)imgUrl name:(NSString *)name price:(CGFloat)price {
    SIXProductMessageContent *msg = [[SIXProductMessageContent alloc] init];
    msg.url = url;
    msg.imageUrlString = imgUrl;
    msg.name = name;
    msg.price = price;
    
    return msg;
}

#pragma -mark 
#pragma -mark RCMessageContentView

/*!
 返回在会话列表和本地通知中显示的消息内容摘要
 
 @return 会话列表和本地通知中显示的消息内容摘要
 
 @discussion
 如果您使用IMKit，当会话的最后一条消息为自定义消息时，需要通过此方法获取在会话列表展现的内容摘要；
 当App在后台收到消息时，需要通过此方法获取在本地通知中展现的内容摘要。
 */
- (NSString *)conversationDigest {
    return [NSString stringWithFormat:@"[商品]%@", self.name];
}

#pragma -mark 
#pragma -mark RCMessagePersistentCompatible
/*!
 返回消息的存储策略
 
 @return 消息的存储策略
 
 @discussion 指明此消息类型在本地是否存储、是否计入未读消息数。
 */
+ (RCMessagePersistent)persistentFlag {
    return MessagePersistent_ISCOUNTED;
}

#pragma -mark 
#pragma -mark RCMessageCoding
/*!
 将消息内容序列化，编码成为可传输的json数据
 
 @discussion
 消息内容通过此方法，将消息中的所有数据，编码成为json数据，返回的json数据将用于网络传输。
 */
- (NSData *)encode {
    NSMutableDictionary *dicData = [[NSMutableDictionary alloc] init];
    if (nil != self.url) {
        [dicData setObject:self.url forKey:@"url"];
    }
    if (nil != self.imageUrlString) {
        [dicData setObject:self.imageUrlString forKey:@"imageUrlString"];
    }
    if (nil != self.name) {
        [dicData setObject:self.name forKey:@"name"];
    }
    if (self.price > 0) {
        [dicData setObject:@(self.price) forKey:@"price"];
    }
    
    if (self.senderUserInfo) {
        NSMutableDictionary *dicUserInfo = [[NSMutableDictionary alloc] init];
        
        if (nil != self.senderUserInfo.userId) {
            [dicUserInfo setObject:self.senderUserInfo.userId forKey:@"userId"];
        }
        if (nil != self.senderUserInfo.name) {
            [dicUserInfo setObject:self.senderUserInfo.name forKey:@"name"];
        }
        if (nil != self.senderUserInfo.portraitUri) {
            [dicUserInfo setObject:self.senderUserInfo.portraitUri forKey:@"portraitUri"];
        }
        
        [dicData setObject:dicUserInfo forKey:@"senderUserInfo"];
    }
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dicData options:NSJSONWritingPrettyPrinted error:nil];
    return data;
}

/*!
 将json数据的内容反序列化，解码生成可用的消息内容
 
 @param data    消息中的原始json数据
 
 @discussion
 网络传输的json数据，会通过此方法解码，获取消息内容中的所有数据，生成有效的消息内容。
 */
- (void)decodeWithData:(NSData *)data {
    if (nil != data) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        if (!error) {
            self.url = dic[@"url"];
            self.imageUrlString = dic[@"imageUrlString"];
            self.name = dic[@"name"];
            self.price = [dic[@"price"] floatValue];
            
            
            NSDictionary *dicUserInfo = dic[@"senderUserInfo"];
            [self decodeUserInfo:dicUserInfo];
        }
    }
}

/*!
 返回消息的类型名
 
 @return 消息的类型名
 
 @discussion 您定义的消息类型名，需要在各个平台上保持一致，以保证消息互通。
 
 @warning 请勿使用@"RC:"开头的类型名，以免和SDK默认的消息名称冲突
 */
+ (NSString *)getObjectName {
    return @"SIX:ProductMessage";
}

/*!
 返回可搜索的关键内容列表
 
 @return 返回可搜索的关键内容列表
 
 @discussion 这里返回的关键内容列表将用于消息搜索，自定义消息必须要实现此接口才能进行搜索。
 */
- (NSArray<NSString *> *)getSearchableWords{
    return [self.name componentsSeparatedByString:@" "];
}


@end

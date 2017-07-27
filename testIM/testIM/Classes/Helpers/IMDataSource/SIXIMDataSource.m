//
//  SIXIMDataSource.m
//  testIM
//
//  Created by li’Pro on 2017/7/24.
//  Copyright © 2017年 6room. All rights reserved.
//

#import "SIXIMDataSource.h"

static NSString *const kDicGroupmemberKey = @"kDicGroupmemberKey";
static NSString *const kDicUserKey = @"kDicUserKey";


@interface SIXIMDataSource ()
/** key：群组 id， value：群组 id 列表 */
@property (strong, nonatomic) NSMutableDictionary<NSString *, NSMutableArray<NSString *> *> *dicGroupMember;

@property (strong, nonatomic) NSMutableDictionary<NSString *, RCUserInfo *> *dicUser;

@end

@implementation SIXIMDataSource

+ (instancetype)shareIMDataSource {
    static SIXIMDataSource *ins = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ins = [[SIXIMDataSource alloc] init];
    });
    
    return ins;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        self.dicGroupMember = [defaults objectForKey:kDicGroupmemberKey];
        self.dicUser = [defaults objectForKey:kDicUserKey];
        
        if (nil == self.dicGroupMember) {
            self.dicGroupMember = [[NSMutableDictionary alloc] init];
        }
        if (nil == self.dicUser) {
            self.dicUser = [[NSMutableDictionary alloc] init];
        }
    }
    return self;
}

#pragma -mark 
#pragma -mark RCIMUserInfoDataSource
/*!
 获取用户信息
 
 @param userId      用户ID
 @param completion  获取用户信息完成之后需要执行的Block [userInfo:该用户ID对应的用户信息]
 
 @discussion SDK通过此方法获取用户信息并显示，请在completion中返回该用户ID对应的用户信息。
 在您设置了用户信息提供者之后，SDK在需要显示用户信息的时候，会调用此方法，向您请求用户信息用于显示。
 */
- (void)getUserInfoWithUserId:(NSString *)userId
                   completion:(void (^)(RCUserInfo *userInfo))completion {
    // 查找缓存
    RCUserInfo *u = [self.dicUser objectForKey:userId];
    if (u) {
        completion(u);
    }
    // 网络获取
    NSString *currentUserId = [RCIM sharedRCIM].currentUserInfo.userId;
    DLog(@"getUserInfoWithUserId:%@ currentUserId:%@", userId, currentUserId);
    if ([userId isEqualToString:currentUserId]) {
        NSString *ID = [[SIXUserManager shareUserManager] getDefaultUserId];
        NSString *name = [[SIXUserManager shareUserManager] getDefaultName];
        NSString *portrait = [[SIXUserManager shareUserManager] getDefaultPortrait];
        RCUserInfo *u = [[RCUserInfo alloc] initWithUserId:ID name:name portrait:portrait];
        
        self.dicUser[userId] = u;
        
        completion(u);
    } else {
        [SIXDataSourceTool getUserInfoByUserID:userId completion:^(RCUserInfo *user) {
            self.dicUser[userId] = user;
            
            [self persistenceData];
            completion(user);
        }];
    }
}

#pragma -mark 
#pragma -mark RCIMGroupUserInfoDataSource
/*!
 获取用户在群组中的群名片信息
 
 @param userId          用户ID
 @param groupId         群组ID
 @param completion      获取群名片信息完成之后需要执行的Block [userInfo:该用户ID在群组中对应的群名片信息]
 
 @discussion 如果您使用了群名片功能，SDK需要通过您实现的群名片信息提供者，获取用户在群组中的名片信息并显示。
 */
- (void)getUserInfoWithUserId:(NSString *)userId inGroup:(NSString *)groupId completion:(void (^)(RCUserInfo *userInfo))completion {
    //在这里查询该group内的群名片信息，如果能查到，调用completion返回。如果查询不到也一定要调用completion(nil)
    if ([groupId isEqualToString:@"22"] && [userId isEqualToString:@"30806"]) {
        completion([[RCUserInfo alloc] initWithUserId:@"30806"
                                                 name:@"我在22群中的名片"
                                             portrait:nil]);
    } else {
        RCUserInfo *userInfo = [[RCUserInfo alloc] initWithUserId:userId name:@"userName" portrait:@""];
        if (self.dicUser) {
            userInfo = [self.dicUser objectForKey:userId];
        }
        completion(userInfo);
    }
}


#pragma -mark 
#pragma -mark RCIMGroupMemberDataSource
/*!
 获取当前群组成员列表的回调（需要实现用户信息提供者 RCIMUserInfoDataSource）
 
 @param groupId     群ID
 @param resultBlock 获取成功 [userIdList:群成员ID列表]
 */
- (void)getAllMembersOfGroup:(NSString *)groupId
                      result:(void (^)(NSArray<NSString *> *userIdList))resultBlock {
    __block NSMutableArray<NSString *> *arrId = [self.dicGroupMember objectForKey:groupId];
    if (nil == arrId) {
        [SIXDataSourceTool getGroupMembersWithGroupId:groupId Block:^(NSMutableArray<NSString *> *arr) {
            arrId = arr;
            self.dicGroupMember[groupId] = arr;
            
            [self persistenceData];
            resultBlock(arr);
        }];
    } else {
        resultBlock(arrId);
    }
}


#pragma -mark 
#pragma -mark RCIMGroupInfoDataSource
/*!
 获取群组信息
 
 @param groupId     群组ID
 @param completion  获取群组信息完成之后需要执行的Block [groupInfo:该群组ID对应的群组信息]
 
 @discussion SDK通过此方法获取用户信息并显示，请在completion的block中返回该用户ID对应的用户信息。
 在您设置了用户信息提供者之后，SDK在需要显示用户信息的时候，会调用此方法，向您请求用户信息用于显示。
 */
- (void)getGroupInfoWithGroupId:(NSString *)groupId
                     completion:(void (^)(RCGroup *groupInfo))completion {
//    DLog(@"getGroupInfoWithGroupId:%@", groupId);
//    RCGroup *group = [[RCGroup alloc] initWithGroupId:groupId groupName:@"groupName" portraitUri:@""];
//    completion(group);
    [SIXDataSourceTool getGroupByID:groupId successCompletion:^(RCGroup *group) {
        completion(group);
    }];
}


#pragma -mark 
#pragma -mark private
- (void)persistenceData {
//    [[NSUserDefaults standardUserDefaults] setObject:self.dicUser forKey:kDicUserKey];
//    [[NSUserDefaults standardUserDefaults] setObject:self.dicGroupMember forKey:kDicGroupmemberKey];
//    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end



























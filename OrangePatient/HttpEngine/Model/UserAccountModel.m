//
//  UserAccountModel.m
//  OrangePatient
//
//  Created by singlew on 15/3/31.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "UserAccountModel.h"

@implementation UserAccountModel
/*
 @property(nonatomic,strong) NSString *userUid;
 @property(nonatomic,strong) NSString *userOid;
 @property(nonatomic,strong) NSString *userOauthToken;
 @property(nonatomic,strong) NSString *userOauthTokenSecret;
 @property(nonatomic) NSInteger uservalidTime;
 @property(nonatomic,strong) NSString *userNickName;
 @property(nonatomic,strong) NSString *userEmail;
 @property(nonatomic,strong) NSString *userAvatar;
 @property(nonatomic,strong) NSString *userMobile;
 @property(nonatomic,strong) NSString *userImUserName;
 @property(nonatomic,strong) NSString *userImPassword;
 @property(nonatomic,strong) NSString *userImNickName;
 @property(nonatomic) NSInteger userStatus;
 */

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.userUid forKey:@"userUid"];
    [aCoder encodeObject:self.userOid forKey:@"userOid"];
    [aCoder encodeObject:self.userOauthToken forKey:@"userOauthToken"];
    [aCoder encodeObject:self.userOauthTokenSecret forKey:@"userOauthTokenSecret"];
    [aCoder encodeInteger:self.uservalidTime forKey:@"uservalidTime"];
    [aCoder encodeObject:self.userNickName forKey:@"userNickName"];
    [aCoder encodeObject:self.userEmail forKey:@"userEmail"];
    [aCoder encodeObject:self.userAvatar forKey:@"userAvatar"];
    [aCoder encodeObject:self.userMobile forKey:@"userMobile"];
    [aCoder encodeObject:self.userImUserName forKey:@"userImUserName"];
    [aCoder encodeObject:self.userImPassword forKey:@"userImPassword"];
    [aCoder encodeObject:self.userImNickName forKey:@"userImNickName"];
    [aCoder encodeInteger:self.userStatus forKey:@"userStatus"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (nil != self) {
        self.userUid=[aDecoder decodeObjectForKey:@"userUid"];
        self.userOid=[aDecoder decodeObjectForKey:@"userOid"];
        self.userOauthToken=[aDecoder decodeObjectForKey:@"userOauthToken"];
        self.userOauthTokenSecret=[aDecoder decodeObjectForKey:@"userOauthTokenSecret"];
        self.uservalidTime=[aDecoder decodeIntegerForKey:@"uservalidTime"];
        self.userNickName=[aDecoder decodeObjectForKey:@"userNickName"];
        self.userEmail=[aDecoder decodeObjectForKey:@"userEmail"];
        self.userAvatar=[aDecoder decodeObjectForKey:@"userAvatar"];
        self.userMobile=[aDecoder decodeObjectForKey:@"userMobile"];
        self.userImUserName=[aDecoder decodeObjectForKey:@"userImUserName"];
        self.userImPassword=[aDecoder decodeObjectForKey:@"userImPassword"];
        self.userImNickName=[aDecoder decodeObjectForKey:@"userImNickName"];
        self.userStatus=[aDecoder decodeIntegerForKey:@"userStatus"];
    }
    return self;
}
@end

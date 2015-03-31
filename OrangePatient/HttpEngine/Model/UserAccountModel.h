//
//  UserAccountModel.h
//  OrangePatient
//
//  Created by singlew on 15/3/31.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "UIModelCoding.h"

@interface UserAccountModel : UIModelCoding
/*
 "uid": "string",
 "oid": "string",
 "oauth_token": "string",
 "oauth_token_secret": "string",
 "validtime": 0,
 "nickname": "string",
 "type": 0,
 "email": "email@corp.com",
 "avatar": "string",
 "mobile": "string",
 "im_username": "string",
 "im_password": "string",
 "im_nickname": "string",
 "status": 0
 */

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
@end

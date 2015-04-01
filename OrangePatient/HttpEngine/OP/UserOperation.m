//
//  UserOperation.m
//  OrangePatient
//
//  Created by singlew on 15/3/28.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "UserOperation.h"
#import "UIManagement.h"

@interface UserOperation ()
@property(nonatomic) UserType type;
-(void) login;
-(void) verifyCode;
-(void) userRegister;
-(void) logout;
-(void) resetPassword;
-(void) feedBack;
-(void) getUserFriend;
-(void) addFriend;
-(void) deleteFriend;
-(void) changeAvatar;
@end

@implementation UserOperation

-(UserOperation *) initLogin : (NSString *) userName withPassword : (NSString *) password{
    self = [self initCustomOperation];
    if (nil != self) {
        self.type = kLogin;
        NSString *urlStr = [NSString stringWithFormat:@"%@api/users/login",K_HOST_OF_SERVER];
        [self setHttpRequestPostWithUrl:urlStr params:@{@"username":userName,@"password":password}];
    }
    return self;
}

-(UserOperation *) initGetVerifyCode:(NSString *)phoneNumber withType:(NSInteger)typeCode{
    self = [self initCustomOperation];
    if (nil != self) {
        self.type = kGetVerifyCode;
        NSString *urlStr = [NSString stringWithFormat:@"%@/api/users/verifycode",K_HOST_OF_SERVER];
        [self setHttpRequestPostWithUrl:urlStr params:@{@"mobile":phoneNumber,@"type":[NSNumber numberWithLong:typeCode]}];
    }
    return self;
}

-(UserOperation *) initRegsiter : (NSString *) userName withPassword : (NSString *) password withName : (NSString *) name withSex : (NSInteger) sex withBirthday : (NSString *) birthday withVerifyCode : (NSString *) verifyCode{
    self = [self initCustomOperation];
    if (nil != self) {
        self.type = kRegister;
        NSString *urlStr = [NSString stringWithFormat:@"%@/api/users/register",K_HOST_OF_SERVER];
        [self setHttpRequestPostWithUrl:urlStr params:@{@"username" : userName,@"password":password,@"name":name,@"sex":[NSNumber numberWithLong:sex],@"birthday":birthday,@"verifycode":verifyCode}];
    }
    return self;
}

-(UserOperation *) initLogout{
    self = [self initCustomOperation];
    if (nil != self) {
        self.type = kUserLogout;
        NSString *urlStr = [NSString stringWithFormat:@"%@/api/users/logout",K_HOST_OF_SERVER];
        [self setHttpRequestPostWithUrl:urlStr params:@{@"oauth_token" : [UIManagement sharedInstance].userAccount.userOauthToken,
                                                        @"oauth_token_secret":[UIManagement sharedInstance].userAccount.userOauthTokenSecret}];
    }
    return self;
}

-(UserOperation *) initUserResetPassword : (NSString *) userName withPassword : (NSString *) password withVerifyCode : (NSString *) verifyCode{
    self = [self initCustomOperation];
    if (nil != self) {
        self.type = kResetPassword;
        NSString *urlStr = [NSString stringWithFormat:@"%@/api/users/resetpasswd",K_HOST_OF_SERVER];
        [self setHttpRequestPostWithUrl:urlStr params:@{@"username":userName,@"password":password,@"verifycode":verifyCode}];
    }
    return self;
}

-(UserOperation *) initFeedBack : (NSString *) content{
    self = [self initCustomOperation];
    if (nil != self) {
        self.type = kFeedBack;
        NSString *urlStr = [NSString stringWithFormat:@"%@/api/users/feedback",K_HOST_OF_SERVER];
        [self setHttpRequestPostWithUrl:urlStr params:@{@"oauth_token" : [UIManagement sharedInstance].userAccount.userOauthToken,
                                                        @"oauth_token_secret":[UIManagement sharedInstance].userAccount.userOauthTokenSecret,
                                                        @"content":content}];
    }
    return self;
}

-(UserOperation *) initGetUserFriends : (NSString *) uid withStart : (NSInteger) start withLimit : (NSInteger) limit{
    self = [self initCustomOperation];
    if (nil != self) {
        self.type = kGetUserFriend;
        NSString *urlStr = [NSString stringWithFormat:@"%@/api/users/friend/%@?oauth_token=%@&oauth_token_secret=%@&start=%ld&limit=%ld",
                            K_HOST_OF_SERVER,
                            uid,
                            [UIManagement sharedInstance].userAccount.userOauthToken,
                            [UIManagement sharedInstance].userAccount.userOauthTokenSecret,start,limit];
        [self setHttpRequestGetWithUrl:urlStr];
    }
    return self;
}

-(UserOperation *) initAddFriend : (NSString *) uid{
    self = [self initCustomOperation];
    if (nil != self) {
        self.type = kResetPassword;
        NSString *urlStr = [NSString stringWithFormat:@"%@/api/users/friend/%@",K_HOST_OF_SERVER,uid];
        [self setHttpRequestPostWithUrl:urlStr params:@{@"oauth_token" : [UIManagement sharedInstance].userAccount.userOauthToken,
                                                        @"oauth_token_secret":[UIManagement sharedInstance].userAccount.userOauthTokenSecret}];
    }
    return self;
}

-(UserOperation *) initDeleteFriend : (NSString *) uid{
    self = [self initCustomOperation];
    if (nil != self) {
        self.type = kDeleteFriend;
        NSString *urlStr = [NSString stringWithFormat:@"%@/api/users/friend/%@",K_HOST_OF_SERVER,uid];
        [self setHttpRequestPostWithUrl:urlStr params:@{@"oauth_token" : [UIManagement sharedInstance].userAccount.userOauthToken,
                                                        @"oauth_token_secret":[UIManagement sharedInstance].userAccount.userOauthTokenSecret}];
        [self.dataRequest setRequestMethod:@"DELETE"];
    }
    return self;
}

-(UserOperation *) initChangeAvatar : (NSString *) uid withImage : (NSData *) image{
    self = [self initCustomOperation];
    if (nil != self) {
        self.type = kChangeAvatar;
        NSString *urlStr = [NSString stringWithFormat:@"%@/api/users/avatar/%@",K_HOST_OF_SERVER,uid];
        [self setHttpRequestPostWithUrl:urlStr
                                 params:@{@"oauth_token" : [UIManagement sharedInstance].userAccount.userOauthToken,
                                          @"oauth_token_secret":[UIManagement sharedInstance].userAccount.userOauthTokenSecret}
                            imgDataDict:@{@"avatar":image}];
    }
    return self;
}

-(void) login{
    [self.dataRequest setRequestCompleted:^(NSDictionary *data){
        dispatch_block_t updateTagBlock = ^{
            [UIManagement sharedInstance].loginResult = data;
        };
        dispatch_async(dispatch_get_main_queue(), updateTagBlock);
    }];
    [self startAsynchronous];
}

-(void) verifyCode{
    [self.dataRequest setRequestCompleted:^(NSDictionary *data){
        dispatch_block_t updateTagBlock = ^{
            [UIManagement sharedInstance].verifyCodeResult = data;
        };
        dispatch_async(dispatch_get_main_queue(), updateTagBlock);
    }];
    [self startAsynchronous];
}

-(void) userRegister{
    [self.dataRequest setRequestCompleted:^(NSDictionary *data){
        dispatch_block_t updateTagBlock = ^{
            [UIManagement sharedInstance].regsiterResult = data;
        };
        dispatch_async(dispatch_get_main_queue(), updateTagBlock);
    }];
    [self startAsynchronous];
}

-(void) logout{
    [self.dataRequest setRequestCompleted:^(NSDictionary *data){
        dispatch_block_t updateTagBlock = ^{
            [UIManagement sharedInstance].logoutResult = data;
        };
        dispatch_async(dispatch_get_main_queue(), updateTagBlock);
    }];
    [self startAsynchronous];
}

-(void) resetPassword{
    [self.dataRequest setRequestCompleted:^(NSDictionary *data){
        dispatch_block_t updateTagBlock = ^{
            [UIManagement sharedInstance].resetPasswordResult = data;
        };
        dispatch_async(dispatch_get_main_queue(), updateTagBlock);
    }];
    [self startAsynchronous];
}

-(void) feedBack{
    [self.dataRequest setRequestCompleted:^(NSDictionary *data){
        dispatch_block_t updateTagBlock = ^{
            [UIManagement sharedInstance].feedBackResult = data;
        };
        dispatch_async(dispatch_get_main_queue(), updateTagBlock);
    }];
    [self startAsynchronous];
}

-(void) getUserFriend{
    [self.dataRequest setRequestCompleted:^(NSDictionary *data){
        dispatch_block_t updateTagBlock = ^{
            [UIManagement sharedInstance].userFriendResult = data;
        };
        dispatch_async(dispatch_get_main_queue(), updateTagBlock);
    }];
    [self startAsynchronous];
}

-(void) addFriend{
    [self.dataRequest setRequestCompleted:^(NSDictionary *data){
        dispatch_block_t updateTagBlock = ^{
            [UIManagement sharedInstance].addFriendResult = data;
        };
        dispatch_async(dispatch_get_main_queue(), updateTagBlock);
    }];
    [self startAsynchronous];
}

-(void) deleteFriend{
    [self.dataRequest setRequestCompleted:^(NSDictionary *data){
        dispatch_block_t updateTagBlock = ^{
            [UIManagement sharedInstance].deleteFriendResult = data;
        };
        dispatch_async(dispatch_get_main_queue(), updateTagBlock);
    }];
    [self startAsynchronous];
}

-(void) changeAvatar{
    [self.dataRequest setRequestCompleted:^(NSDictionary *data){
        dispatch_block_t updateTagBlock = ^{
            [UIManagement sharedInstance].changeAvatarResult = data;
        };
        dispatch_async(dispatch_get_main_queue(), updateTagBlock);
    }];
    [self startAsynchronous];
}

-(void) main{
    @autoreleasepool {
        switch (self.type) {
            case kLogin:
                [self login];
                break;
            case kGetVerifyCode:
                [self verifyCode];
                break;
            case kRegister:
                [self userRegister];
                break;
            case kUserLogout:
                [self logout];
                break;
            case kResetPassword:
                [self resetPassword];
                break;
            case kFeedBack:
                [self feedBack];
                break;
            case kGetUserFriend:
                [self getUserFriend];
                break;
            case kAddFriend:
                [self addFriend];
                break;
            case kDeleteFriend:
                [self deleteFriend];
                break;
            case kChangeAvatar:
                [self changeAvatar];
                break;
            default:
                break;
        }
    }
}


@end

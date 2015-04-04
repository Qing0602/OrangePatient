//
//  UIManagement.m
//  OrangeDoctor
//
//  Created by singlew on 15/3/3.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "UIManagement.h"
#import "NetWorkService.h"

@implementation UIManagement

static UIManagement *sharedInstance = nil;

+(UIManagement *) sharedInstance{
    @synchronized(sharedInstance){
        if (nil == sharedInstance){
            sharedInstance = [[UIManagement alloc] init];
            sharedInstance.userAccount = [UIModelCoding deserializeModel:@"UserAccount"];
        }
    }
    return sharedInstance;
}

-(void) login : (NSString *) userName withPassword : (NSString *) password{
    UserOperation *operation = [[UserOperation alloc] initLogin:userName withPassword:password];
    [[NetWorkService sharedInstance] networkEngine:operation];
}

-(void) getVerifyCode:(NSString *)phoneNumber withType:(NSInteger)typeCode{
    UserOperation *operation = [[UserOperation alloc] initGetVerifyCode:phoneNumber withType:typeCode];
    [[NetWorkService sharedInstance] networkEngine:operation];
}

-(void) regsiter : (NSString *) userName withPassword : (NSString *) password withName : (NSString *) name withSex : (NSInteger) sex withBirthday : (NSString *) birthday withVerifyCode : (NSString *) verifyCode{
    UserOperation *operation = [[UserOperation alloc] initRegsiter:userName withPassword:password withName:name withSex:sex withBirthday:birthday withVerifyCode:verifyCode];
    [[NetWorkService sharedInstance] networkEngine:operation];
}

// 退出登录
-(void) logout{
    UserOperation *operation = [[UserOperation alloc] initLogout];
    [[NetWorkService sharedInstance] networkEngine:operation];
}

// 重置密码
-(void) userResetPassword : (NSString *) userName withPassword : (NSString *) password withVerifyCode : (NSString *) verifyCode{
    UserOperation *operation = [[UserOperation alloc] initUserResetPassword:userName withPassword:password withVerifyCode:verifyCode];
    [[NetWorkService sharedInstance] networkEngine:operation];
}

// 意见反馈
-(void) feedBack : (NSString *) content{
    UserOperation *operation = [[UserOperation alloc] initFeedBack:content];
    [[NetWorkService sharedInstance] networkEngine:operation];
}

// 获取好友
-(void) getUserFriends : (NSString *) uid withStart : (NSInteger) start withLimit : (NSInteger) limit{
    UserOperation *operation = [[UserOperation alloc] initGetUserFriends:uid withStart:start withLimit:limit];
    [[NetWorkService sharedInstance] networkEngine:operation];
}
// 添加好友
-(void) addFriend : (NSString *) uid{
    UserOperation *operation = [[UserOperation alloc] initAddFriend:uid];
    [[NetWorkService sharedInstance] networkEngine:operation];
}

// 删除好友
-(void) deleteFriend : (NSString *) uid{
    UserOperation *operation = [[UserOperation alloc] initDeleteFriend:uid];
    [[NetWorkService sharedInstance] networkEngine:operation];
}

// 更新头像
-(void) changeAvatar : (NSString *) uid withImage : (NSData *) image{
    UserOperation *operation = [[UserOperation alloc] initChangeAvatar:uid withImage:image];
    [[NetWorkService sharedInstance] networkEngine:operation];
}

// 更新密码
-(void) updateUserDetail : (NSString *) uid withBody : (NSDictionary *) body{
    UserOperation *operation = [[UserOperation alloc] initUpdateUserDetail:uid withBody:body];
    [[NetWorkService sharedInstance] networkEngine:operation];
}

// 更新profile
-(void) updateUserProfile : (NSString *) uid withBody : (NSDictionary *) body{
    UserOperation *operation = [[UserOperation alloc] initUpdateUserProfile:uid withBody:body];
    [[NetWorkService sharedInstance] networkEngine:operation];
}

// 获取城市
-(void) getArea{
    SettingOperation *operation = [[SettingOperation alloc] initGetArea];
    [[NetWorkService sharedInstance] networkEngine:operation];
}

// 获取地区
-(void) getCity : (NSInteger) areaID{
    SettingOperation *operation = [[SettingOperation alloc] initGetCity:areaID];
    [[NetWorkService sharedInstance] networkEngine:operation];
}
@end

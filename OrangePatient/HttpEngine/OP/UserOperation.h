//
//  UserOperation.h
//  OrangePatient
//
//  Created by singlew on 15/3/28.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "CustomOperation.h"

typedef enum{
    kLogin,
    kGetVerifyCode,
    kRegister,
    kUserLogout,
    kResetPassword,
    kFeedBack,
    kGetUserFriend,
    kAddFriend,
    kDeleteFriend,
    kChangeAvatar,
    kUpdateUserDetail,
    kUpdateUserProfile,
    kGetUserProfile,
    kVersionCheck,
    kGetUserReport,
    kGetUserDashboard,
    kDeleteUserReport,
}UserType;

@interface UserOperation : CustomOperation
-(UserOperation *) initLogin : (NSString *) userName withPassword : (NSString *) password;
-(UserOperation *) initGetVerifyCode : (NSString *) phoneNumber withType : (NSInteger) typeCode;
-(UserOperation *) initRegsiter : (NSString *) userName withPassword : (NSString *) password withName : (NSString *) name withSex : (NSInteger) sex withBirthday : (NSString *) birthday withVerifyCode : (NSString *) verifyCode;
-(UserOperation *) initLogout;
-(UserOperation *) initUserResetPassword : (NSString *) userName withPassword : (NSString *) password withVerifyCode : (NSString *) verifyCode;
-(UserOperation *) initFeedBack : (NSString *) content;

-(UserOperation *) initGetUserFriends : (NSString *) uid withStart : (NSInteger) start withLimit : (NSInteger) limit;
-(UserOperation *) initAddFriend : (NSString *) uid;
-(UserOperation *) initDeleteFriend : (NSString *) uid;

-(UserOperation *) initChangeAvatar : (NSString *) uid withImage : (NSData *) image;

-(UserOperation *) initUpdateUserDetail : (NSString *) uid withBody : (NSDictionary *) body;
-(UserOperation *) initGetUserProfile : (NSString *) uid;
-(UserOperation *) initUpdateUserProfile : (NSString *) uid withBody : (NSDictionary *) body;

-(UserOperation *) initVersionCheck : (NSString *)version withVersionCode : (NSString *) versionCode;

//获取用户报告
-(UserOperation *)initUserReport:(NSString *)uid withStart : (NSInteger) start withLimit : (NSInteger) limit;;
-(UserOperation *)initUserDashboard:(NSString *)uid;

// 删除报表
-(UserOperation *) initDeleteUserReport : (long) reportID withUserUid : (NSString *) userUid;
@end

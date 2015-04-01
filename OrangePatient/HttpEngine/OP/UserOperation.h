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
}UserType;

@interface UserOperation : CustomOperation
-(UserOperation *) initLogin : (NSString *) userName withPassword : (NSString *) password;
-(UserOperation *) initGetVerifyCode : (NSString *) phoneNumber withType : (NSInteger) typeCode;
-(UserOperation *) initRegsiter : (NSString *) userName withPassword : (NSString *) password withName : (NSString *) name withSex : (NSInteger) sex withBirthday : (NSString *) birthday withVerifyCode : (NSString *) verifyCode;
-(UserOperation *) initLogout;
-(UserOperation *) initUserResetPassword : (NSString *) userName withPassword : (NSString *) password withVerifyCode : (NSString *) verifyCode;

-(UserOperation *) initFeedBack : (NSString *) content;
@end

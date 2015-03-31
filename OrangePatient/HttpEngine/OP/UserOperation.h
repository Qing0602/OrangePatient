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
}UserType;

@interface UserOperation : CustomOperation
-(UserOperation *) initLogin : (NSString *) userName withPassword : (NSString *) password;
-(UserOperation *) initGetVerifyCode : (NSString *) phoneNumber withType : (NSInteger) typeCode;
-(UserOperation *) initRegsiter : (NSString *) userName withPassword : (NSString *) password withName : (NSString *) name withSex : (NSInteger) sex withBirthday : (NSString *) birthday withVerifyCode : (NSString *) verifyCode;
-(void) initLogout;
@end

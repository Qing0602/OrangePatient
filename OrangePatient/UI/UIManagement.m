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
@end

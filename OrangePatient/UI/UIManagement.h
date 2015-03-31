//
//  UIManagement.h
//  OrangeDoctor
//
//  Created by singlew on 15/3/3.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserOperation.h"


@interface UIManagement : NSObject
+(UIManagement *) sharedInstance;

// 登陆
@property (nonatomic,strong) NSDictionary *loginResult;
// 提供手机号码获取注册、重置等验证码。
@property (nonatomic,strong) NSDictionary *verifyCodeResult;

// 登陆
-(void) login : (NSString *) userName withPassword : (NSString *) password;
// 提供手机号码获取注册、重置等验证码。typeCode:0 - 注册, 1 - 重置密码
-(void) getVerifyCode:(NSString *)phoneNumber withType:(NSInteger) typeCode;
@end

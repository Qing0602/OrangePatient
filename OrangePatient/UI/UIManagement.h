//
//  UIManagement.h
//  OrangeDoctor
//
//  Created by singlew on 15/3/3.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserOperation.h"
#import "UserAccountModel.h"

@interface UIManagement : NSObject
+(UIManagement *) sharedInstance;

// 用户登陆model
@property(nonatomic,strong) UserAccountModel *userAccount;

// 登陆
@property (nonatomic,strong) NSDictionary *loginResult;
// 提供手机号码获取注册、重置等验证码。
@property (nonatomic,strong) NSDictionary *verifyCodeResult;
// 注册
@property (nonatomic,strong) NSDictionary *regsiterResult;
// 退出登录
@property (nonatomic,strong) NSDictionary *logoutResult;
// 重置密码
@property (nonatomic,strong) NSDictionary *resetPasswordResult;
// 意见反馈
@property (nonatomic,strong) NSDictionary *feedBackResult;
// 获得用户好友列表
@property (nonatomic,strong) NSDictionary *userFriendResult;
// 添加好友
@property (nonatomic,strong) NSDictionary *addFriendResult;
// 删除好友
@property (nonatomic,strong) NSDictionary *deleteFriendResult;
// 更新头像
@property (nonatomic,strong) NSDictionary *changeAvatarResult;

// 登陆
-(void) login : (NSString *) userName withPassword : (NSString *) password;
// 提供手机号码获取注册、重置等验证码。typeCode:0 - 注册, 1 - 重置密码
-(void) getVerifyCode:(NSString *)phoneNumber withType:(NSInteger) typeCode;
// 注册 sex: 0 - 不限，1 - 男， 2 - 女
-(void) regsiter : (NSString *) userName withPassword : (NSString *) password withName : (NSString *) name withSex : (NSInteger) sex withBirthday : (NSString *) birthday withVerifyCode : (NSString *) verifyCode;
// 退出登录
-(void) logout;
// 重置密码
-(void) userResetPassword : (NSString *) userName withPassword : (NSString *) password withVerifyCode : (NSString *) verifyCode;
// 意见反馈
-(void) feedBack : (NSString *) content;
@end

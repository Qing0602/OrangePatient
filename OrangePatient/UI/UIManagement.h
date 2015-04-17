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
#import "SettingOperation.h"
#import "InformationOperation.h"
#import "DoctorsOperation.h"
#import "DeviceOperation.h"

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
@property (nonatomic,strong) NSDictionary *updateUserDetailResult;
@property (nonatomic,strong) NSDictionary *updateUserProfileResult;

// 获取用户profile
@property (nonatomic,strong) NSDictionary *userProfileResult;
// 获取城市
@property (nonatomic,strong) NSDictionary *getAreaResult;
// 获取地区
@property (nonatomic,strong) NSDictionary *getCityResult;
// 检查版本
@property (nonatomic,strong) NSDictionary *checkVersionResult;

// 获取医院列表
@property (nonatomic,strong) NSDictionary *getHospitalResult;
// 获取所属医院的科室列表
@property (nonatomic,strong) NSDictionary *getDepartmentResult;
// 获取所属医院的科室的医生列表
@property (nonatomic,strong) NSDictionary *getDoctorsResult;
// 获取最新健康资讯信息
@property (nonatomic,strong) NSDictionary *getRecentResult;
// 获取指定最新健康资讯信息的详细内容
@property (nonatomic,strong) NSDictionary *getRecentDetailResult;


// 我的预约医生列表
@property (nonatomic,strong) NSDictionary *getMyAppointmentListResult;
// 预约医生
@property (nonatomic,strong) NSDictionary *appointmentDoctorResult;
// 通过地区/医院等筛选条件选择医生
@property (nonatomic,strong) NSDictionary *searchDoctorResult;
// 添加医生至我的医生列表
@property (nonatomic,strong) NSDictionary *followDoctorResult;

// 注册我的设备
@property (nonatomic,strong) NSDictionary *registerDeviceResult;
// 获取我的设备
@property (nonatomic,strong) NSDictionary *getMyDeviceResult;
// 删除我的设备
@property (nonatomic,strong) NSDictionary *deleteMydeviceResult;
// 上传我的设备
@property (nonatomic,strong) NSDictionary *uploadMyDeviceData;


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

// 获取好友
-(void) getUserFriends : (NSString *) uid withStart : (NSInteger) start withLimit : (NSInteger) limit;
// 添加好友
-(void) addFriend : (NSString *) uid;
// 删除好友
-(void) deleteFriend : (NSString *) uid;

// 更新头像
-(void) changeAvatar : (NSString *) uid withImage : (NSData *) image;

// 更新密码
-(void) updateUserDetail : (NSString *) uid withBody : (NSDictionary *) body;
// 更新profile
-(void) updateUserProfile : (NSString *) uid withBody : (NSDictionary *) body;
// 获取用户profile
-(void) getUserProfile : (NSString *) uid;

// 获取城市
-(void) getArea;
// 获取地区
-(void) getCity : (NSInteger) areaID;
// 检查版本
-(void) checkVersion : (NSString *)version withVersionCode : (NSString *) versionCode;

// 获取医院列表
-(void) getHospital : (NSUInteger) limit withOffset : (NSUInteger) offset withCode : (NSInteger) code;
// 获取所属医院的科室列表
-(void) getDepartment : (NSUInteger) limit withOffset : (NSUInteger) offset withCode : (NSInteger) code;
// 获取所属医院的科室的医生列表
-(void) getDoctors : (NSUInteger) limit withOffset : (NSUInteger) offset withCode : (NSInteger) code;

#pragma mark -
#pragma mark 信息相关网络访问
// 获取最新健康资讯信息
-(void) initGetRecent : (NSUInteger) offset withLimit : (NSUInteger) limit;
// 获取指定最新健康资讯信息的详细内容
-(void) initGetRecentDetail : (NSInteger) recentID;

#pragma mark -
#pragma mark 医生相关网络访问
// 我的预约医生列表
-(void) getMyAppointmentList : (NSUInteger) offset withLimit : (NSUInteger) limit;
// 预约医生
-(void) appointment : (NSString *) uid withTimeStamp : (long) timeStamp;
// 通过地区/医院等筛选条件选择医生
-(void) searchDoctors : (long) districtID withHospitalID : (long) hospitalID;
// 添加医生至我的医生列表
-(void) followDoctor : (NSString *) uid;

#pragma mark -
#pragma mark 设备相关网络访问
// 注册我的设备
-(void) registerDevice : (NSString *) peripheralID withName : (NSString *) name;
// 获取我的设备
-(void) getMyDevice;
// 删除我的设备
-(void) deleteDevice : (NSString *) peripheralID;
// 上传我的设备
-(void) postDeviceData : (long) startTime withEndTime : (long) endTime withPeripheralID : (NSString *) peripheralID withData : (NSData *) data;

@end

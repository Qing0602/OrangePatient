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
            sharedInstance.userAccount = [UIModelCoding deserializeModel:SerializeUserAccountModelName];
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

-(void) getUserProfile : (NSString *) uid{
    UserOperation *operation = [[UserOperation alloc] initGetUserProfile:uid];
    [[NetWorkService sharedInstance] networkEngine:operation];
}

// 检查版本
-(void) checkVersion : (NSString *)version withVersionCode : (NSString *) versionCode{
    UserOperation *operation = [[UserOperation alloc] initVersionCheck:version withVersionCode:versionCode];
    [[NetWorkService sharedInstance] networkEngine:operation];
}

// 获取医院列表
-(void) getHospital : (NSUInteger) limit withOffset : (NSUInteger) offset withCode : (NSInteger) code{
    SettingOperation *operation = [[SettingOperation alloc] initGetHospital:limit withOffset:offset withCode:code];
    [[NetWorkService sharedInstance] networkEngine:operation];
}

// 获取所属医院的科室列表
-(void) getDepartment : (NSUInteger) limit withOffset : (NSUInteger) offset withCode : (NSInteger) code{
    SettingOperation *operation = [[SettingOperation alloc] initGetDepartment:limit withOffset:offset withCode:code];
    [[NetWorkService sharedInstance] networkEngine:operation];
    
}

// 获取所属医院的科室的医生列表
-(void) getDoctors : (NSUInteger) limit withOffset : (NSUInteger) offset withCode : (NSInteger) code{
    SettingOperation *operation = [[SettingOperation alloc] initGetDoctors:limit withOffset:offset withCode:code];
    [[NetWorkService sharedInstance] networkEngine:operation];
}

-(void)getMyServiceList{
    SettingOperation *operation = [[SettingOperation alloc] initGetService];
    [[NetWorkService sharedInstance] networkEngine:operation];
}

#pragma mark -
#pragma mark 信息相关网络访问
// 获取最新健康资讯信息
-(void) initGetRecent : (NSUInteger) offset withLimit : (NSUInteger) limit{
    InformationOperation *operation = [[InformationOperation alloc] initGetRecent:offset withLimit:limit];
    [[NetWorkService sharedInstance] networkEngine:operation];
}

// 获取指定最新健康资讯信息的详细内容
-(void) initGetRecentDetail : (NSInteger) recentID{
    InformationOperation *operation = [[InformationOperation alloc] initGetRecentDetail:recentID];
    [[NetWorkService sharedInstance] networkEngine:operation];
}

- (void)initGetAD{
    InformationOperation *operation = [[InformationOperation alloc] initGetAD];
    [[NetWorkService sharedInstance] networkEngine:operation];
}
#pragma mark -
#pragma mark 医生相关网络访问
// 我的预约医生列表
-(void) getMyAppointmentList : (NSUInteger) offset withLimit : (NSUInteger) limit{
    DoctorsOperation *operation = [[DoctorsOperation alloc] initGetMyAppointmentList:offset withLimit:limit];
    [[NetWorkService sharedInstance] networkEngine:operation];
}

// 预约医生
-(void) appointment : (NSString *) uid withTimeStamp : (long) timeStamp{
    DoctorsOperation *operation = [[DoctorsOperation alloc] initAppointment:uid withTimeStamp:timeStamp];
    [[NetWorkService sharedInstance] networkEngine:operation];
}

// 通过地区/医院等筛选条件选择医生
-(void) searchDoctors : (long) districtID withHospitalID : (long) hospitalID{
    DoctorsOperation *operation = [[DoctorsOperation alloc] initSearchDoctors:districtID withHospitalID:hospitalID];
    [[NetWorkService sharedInstance] networkEngine:operation];
}

// 添加医生至我的医生列表
-(void) followDoctor : (NSString *) uid{
    DoctorsOperation *operation = [[DoctorsOperation alloc] initFollowDoctor:uid];
    [[NetWorkService sharedInstance] networkEngine:operation];
}

#pragma mark -
#pragma mark 设备相关网络访问
// 注册我的设备
-(void) registerDevice : (NSString *) peripheralID withName : (NSString *) name{
    DeviceOperation *operation = [[DeviceOperation alloc] initRegisterDevice:peripheralID withName:name];
    [[NetWorkService sharedInstance] networkEngine:operation];
}

// 获取我的设备
-(void) getMyDevice{
    DeviceOperation *operation = [[DeviceOperation alloc] initGetMyDevice];
    [[NetWorkService sharedInstance] networkEngine:operation];
}

// 删除我的设备
-(void) deleteDevice : (NSString *) peripheralID{
    DeviceOperation *operation = [[DeviceOperation alloc] initDeleteDevice:peripheralID];
    [[NetWorkService sharedInstance] networkEngine:operation];
}

// 上传我的设备
-(void) postDeviceData : (long) startTime withEndTime : (long) endTime withPeripheralID : (NSString *) peripheralID withData : (NSDictionary *) data{
    DeviceOperation *operation = [[DeviceOperation alloc] initPostDeviceData:startTime withEndTime:endTime withPeripheralID:peripheralID withData:data];
    [[NetWorkService sharedInstance] networkEngine:operation];
}
@end

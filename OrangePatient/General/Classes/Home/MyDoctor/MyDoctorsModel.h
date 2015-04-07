//
//  MyDoctorsModel.h
//  OrangePatient
//
//  Created by ZhangQing on 15/3/30.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "BaseNSObject.h"
typedef NS_ENUM(NSInteger, Doctor_Status){
    Doctor_Status_ShouldAdd = 0,
    Doctor_Status_Waiting,
    Doctor_Status_Added
};

@interface MyDoctorsModel : BaseNSObject
//头像
@property (nonatomic, strong)NSURL *doctorAvatar;
//姓名
@property (nonatomic, strong)NSString *doctorUserName;
//所属医院
@property (nonatomic, strong)NSString *doctorHostpital;
//头衔
@property (nonatomic, strong)NSString *doctorTitle;
//简介
@property (nonatomic, strong)NSString *doctorAbstract;
//添加状态
@property (nonatomic)NSInteger doctorStatus;
@end

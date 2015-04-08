//
//  ChooseDoctorModel.h
//  OrangePatient
//
//  Created by ZhangQing on 15/4/8.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "MyDoctorsModel.h"

typedef NS_ENUM(NSInteger, Doctor_Status){
    Doctor_Status_ShouldAdd = 0,
    Doctor_Status_Waiting,
    Doctor_Status_Added
};

@interface ChooseDoctorModel : MyDoctorsModel
//简介
@property (nonatomic, strong)NSString *doctorAbstract;
//添加状态
@property (nonatomic)NSInteger doctorStatus;
@end

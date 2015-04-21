//
//  MyDoctorHospitalsModel.m
//  OrangePatient
//
//  Created by ZhangQing on 15/4/1.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "MyDoctorHospitalsModel.h"

@implementation MyDoctorHospitalsModel

+ (MyDoctorHospitalsModel *)convertModelByDic:(NSDictionary *)dic{
    MyDoctorHospitalsModel *model = [[MyDoctorHospitalsModel alloc] init];
    model.hospitalCode = dic[@"code"];
    model.hospitalName = dic[@"name"];
    NSDictionary *departmentListDic = dic[@"departmentList"];
    if (departmentListDic.allKeys.count) {
        model.departmentCode = departmentListDic[@"code"];
        model.departmentName = departmentListDic[@"name"];
        model.departmentStatus = [departmentListDic[@"status"] integerValue];
    }
    return model;
}

@end

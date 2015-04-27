//
//  MyDoctorHospitalsModel.m
//  OrangePatient
//
//  Created by ZhangQing on 15/4/1.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "MyDoctorHospitalsModel.h"
#import "MyDoctorDepartmentsModel.h"
@implementation MyDoctorHospitalsModel

+ (MyDoctorHospitalsModel *)convertModelByDic:(NSDictionary *)dic{
    MyDoctorHospitalsModel *model = [[MyDoctorHospitalsModel alloc] init];
    model.hospitalCode = dic[@"code"];
    model.hospitalName = dic[@"name"];
    model.hospitalAddress = dic[@"address"];
    model.hospitalContent = dic[@"content"];
    model.hospitalGrade = dic[@"grade"];
    model.hospitalLogoUrl = dic[@"logourl"];
    model.hospitalPhone = dic[@"phone"];
    model.hospitalStatus = [dic[@"status"] integerValue];
    NSArray *departmentListArr = dic[@"departmentList"];
    NSMutableArray *tempDepartmentList = [[NSMutableArray alloc] initWithCapacity:departmentListArr.count];
    for (NSDictionary *department in departmentListArr) {
        if (department && department.allKeys.count) {
            [tempDepartmentList addObject:[MyDoctorDepartmentsModel convertModelByDic:department]];
        }
    }
    model.departmentList = tempDepartmentList;
    return model;
}

@end

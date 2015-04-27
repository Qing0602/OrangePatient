//
//  MyDoctorDepartmentsModel.m
//  OrangePatient
//
//  Created by ZhangQing on 15/4/27.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "MyDoctorDepartmentsModel.h"

@implementation MyDoctorDepartmentsModel

+ (MyDoctorDepartmentsModel *)convertModelByDic:(NSDictionary *)dic{
    MyDoctorDepartmentsModel *model = [[MyDoctorDepartmentsModel alloc] init];
    model.departmentAddress = dic[@"address"];
    model.departmentContent = dic[@"content"];
    model.departmentGrade = dic[@"grade"];
    model.departmentName = dic[@"name"];
    model.departmentPhone = dic[@"phone"];
    model.departmentCode = dic[@"code"];
    model.departmentStatus = [dic[@"status"] integerValue];
    
    return model;
}

@end

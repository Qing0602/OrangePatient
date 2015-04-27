//
//  MyDoctorDepartmentsModel.h
//  OrangePatient
//
//  Created by ZhangQing on 15/4/27.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "BaseNSObject.h"

@interface MyDoctorDepartmentsModel : BaseNSObject
//address
@property (nonatomic, strong)NSString *departmentAddress;
//code
@property (nonatomic, strong)NSString *departmentCode;
//content
@property (nonatomic, strong)NSString *departmentContent;
//grade
@property (nonatomic, strong)NSString *departmentGrade;
//name
@property (nonatomic, strong)NSString  *departmentName;
//phone
@property (nonatomic, strong)NSString  *departmentPhone;
//status
@property (nonatomic)NSInteger departmentStatus;

+ (MyDoctorDepartmentsModel *)convertModelByDic:(NSDictionary *)dic;
@end

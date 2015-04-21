//
//  MyDoctorHospitalsModel.h
//  OrangePatient
//
//  Created by ZhangQing on 15/4/1.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "BaseNSObject.h"

@interface MyDoctorHospitalsModel : BaseNSObject
//医院名称
@property (nonatomic, strong)NSString *hospitalName;
//所属筛查中心
@property (nonatomic, strong)NSString *screeningCenterName;
//城市ID
@property (nonatomic)NSInteger cityCode;
//医院ID
@property (nonatomic, strong)NSString *hospitalCode;
//部门
@property (nonatomic, strong)NSString *departmentCode;
@property (nonatomic, strong)NSString *departmentName;
@property (nonatomic)NSInteger departmentStatus;

+ (MyDoctorHospitalsModel *)convertModelByDic:(NSDictionary *)dic;
@end

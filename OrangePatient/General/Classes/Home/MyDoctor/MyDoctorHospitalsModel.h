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
//城市ID
@property (nonatomic)NSInteger cityCode;
//医院ID
@property (nonatomic, strong)NSString *hospitalCode;
//logoUrl
@property (nonatomic, strong)NSString *hospitalLogoUrl;
//grade
@property (nonatomic, strong)NSString *hospitalGrade;
//address
@property (nonatomic, strong)NSString *hospitalAddress;
//phone
@property (nonatomic, strong)NSString *hospitalPhone;
//content
@property (nonatomic, strong)NSString *hospitalContent;
//status
@property (nonatomic)NSInteger hospitalStatus;
//部门
@property (nonatomic, strong)NSMutableArray *departmentList;
//code
@property (nonatomic, strong)NSString *departmentCode;
//name
@property (nonatomic, strong)NSString  *departmentName;
//@property (nonatomic, strong)NSString *departmentCode;
//@property (nonatomic, strong)NSString *departmentName;
//@property (nonatomic)NSInteger departmentStatus;

+ (MyDoctorHospitalsModel *)convertModelByDic:(NSDictionary *)dic;
- (NSMutableArray *)convertModelByDic:(NSDictionary *)dic;
@end

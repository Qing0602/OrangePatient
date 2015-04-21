//
//  MyDoctorCitysModel.m
//  OrangePatient
//
//  Created by ZhangQing on 15/4/1.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "MyDoctorCitysModel.h"

@implementation MyDoctorCitysModel

+ (MyDoctorCitysModel *)convertModelByDic:(NSDictionary *)dic{
    MyDoctorCitysModel *model = [[MyDoctorCitysModel alloc] init];
    model.cityCode = [dic[@"code"] integerValue];
    model.cityName = dic[@"name"];
    model.cityStatus = [dic[@"status"] integerValue];
    return model;
}

@end

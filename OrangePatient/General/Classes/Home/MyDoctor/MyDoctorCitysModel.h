//
//  MyDoctorCitysModel.h
//  OrangePatient
//
//  Created by ZhangQing on 15/4/1.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "BaseNSObject.h"

@interface MyDoctorCitysModel : BaseNSObject
//城市
@property (nonatomic, strong)NSString *cityName;
//医院
@property (nonatomic, strong)NSArray *hospitals;
@end

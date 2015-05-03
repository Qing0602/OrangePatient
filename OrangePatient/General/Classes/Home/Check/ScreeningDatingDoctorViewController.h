//
//  ScreeningDatingDoctorViewController.h
//  OrangePatient
//
//  Created by ZhangQing on 15/4/7.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "OrangeBaseViewController.h"
@class MyDoctorHospitalsModel;
@class ScreeingDatingDoctorsModel;
@interface ScreeningDatingDoctorViewController : OrangeBaseViewController
- (instancetype)initWithHospital:(MyDoctorHospitalsModel *)model andDoctors:(NSArray *)doctors;
@end

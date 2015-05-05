//
//  AddDoctorForChooseDoctorViewController.h
//  OrangePatient
//
//  Created by ZhangQing on 15/4/2.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "OrangeBaseViewController.h"
@class ChooseDoctorModel;
@interface AddDoctorForChooseDoctorViewController : OrangeBaseViewController
- (instancetype)initWithDoctorModel:(NSArray *)doctorModels andHospitalName:(NSString *)hospitalName;
@end

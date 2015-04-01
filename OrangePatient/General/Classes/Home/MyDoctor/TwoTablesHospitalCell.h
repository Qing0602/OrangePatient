//
//  TwoTablesHospitalCell.h
//  OrangePatient
//
//  Created by ZhangQing on 15/4/1.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyDoctorHospitalsModel.h"
@interface TwoTablesHospitalCell : UITableViewCell

@property (nonatomic, strong)UILabel *cellTitle;
@property (nonatomic, strong)UILabel *cellContent;

- (void)setContentByInfoModel:(MyDoctorHospitalsModel *)model;

@end

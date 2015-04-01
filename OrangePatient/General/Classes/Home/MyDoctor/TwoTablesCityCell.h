//
//  TwoTablesCityCell.h
//  OrangePatient
//
//  Created by ZhangQing on 15/4/1.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyDoctorCitysModel.h"

@interface TwoTablesCityCell : UITableViewCell

@property (nonatomic, strong)UILabel *cellTitle;

- (void)setContentByInfoModel:(MyDoctorCitysModel  *)model;

@end

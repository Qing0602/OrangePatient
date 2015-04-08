//
//  AddDoctorForChooseDoctorCell.h
//  OrangePatient
//
//  Created by ZhangQing on 15/4/2.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "DoctorBaseTableViewCell.h"
#import "ChooseDoctorModel.h"

@protocol AddDoctorForChooseDoctorCellDelegate <NSObject>

- (void)willAddDoctor:(ChooseDoctorModel *)model;

@end

@interface AddDoctorForChooseDoctorCell : DoctorBaseTableViewCell

//简介
@property (nonatomic, strong)UILabel *doctorAbstract;
//状态按钮
@property (nonatomic, strong)UIButton *doctorStatusBtn;
@property (nonatomic, weak)id<AddDoctorForChooseDoctorCellDelegate> delegate;
@property (nonatomic, strong)ChooseDoctorModel *dtModel;
- (void)setContentByInfoModel:(ChooseDoctorModel *)model;

@end

//
//  ScreeingDatingDoctorTableViewCell.h
//  OrangePatient
//
//  Created by ZhangQing on 15/4/7.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "DoctorBaseTableViewCell.h"
#import "ScreeingDatingDoctorsModel.h"
@protocol ScreeingDatingDoctorTableViewCellDelegate <NSObject>

- (void)willDatingDoctor:(ScreeingDatingDoctorsModel *)model;

@end

@interface ScreeingDatingDoctorTableViewCell : DoctorBaseTableViewCell

@property (nonatomic, strong)UILabel *doctorInfoDetail;
@property (nonatomic, strong)UILabel *doctorGrade;
@property (nonatomic, strong)UILabel *doctorDatingTime;
@property (nonatomic, strong)UIButton *doctorDatingStatus;
@property (nonatomic, weak)id<ScreeingDatingDoctorTableViewCellDelegate> delegate;
@property (nonatomic, strong)ScreeingDatingDoctorsModel *datingModel;
- (void)setContentByInfoModel:(ScreeingDatingDoctorsModel *)model;

@end

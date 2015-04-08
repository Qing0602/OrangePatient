//
//  ScreeingDatingDoctorTableViewCell.m
//  OrangePatient
//
//  Created by ZhangQing on 15/4/7.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "ScreeingDatingDoctorTableViewCell.h"

@implementation ScreeingDatingDoctorTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _doctorInfoDetail = [[UILabel alloc] init];
        _doctorInfoDetail.textColor = [UIColor lightGrayColor];
        _doctorInfoDetail.font = [UIFont systemFontOfSize:12.f];
        _doctorInfoDetail.backgroundColor = [UIColor yellowColor];
        _doctorInfoDetail.numberOfLines = 2.f;
        _doctorInfoDetail.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_doctorInfoDetail];
        
        _doctorDatingStatus = [UIButton buttonWithType:UIButtonTypeCustom];
        _doctorDatingStatus.translatesAutoresizingMaskIntoConstraints = NO;
        _doctorDatingStatus.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [self.contentView addSubview:_doctorDatingStatus];
        
        [[self.doctorDatingStatus rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *sender){
            if ([sender.titleLabel.text isEqualToString:@"预约"]) {
                if ([self.delegate respondsToSelector:@selector(willDatingDoctor:)]) {
                    [self.delegate willDatingDoctor:self.datingModel];
                }
            }
            
        }];
        
        [_doctorInfoDetail mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.cellSubTitle.mas_bottom).with.offset(6);
            make.left.equalTo(self.cellSubTitle.mas_left);
            make.right.mas_equalTo(@(-DoctorBaseCellPadding));
            make.bottom.mas_equalTo(@(-6));
        }];
        
        [_doctorDatingStatus mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerY.equalTo(self.cellContent.mas_centerY);
            make.right.mas_equalTo(@(-DoctorBaseCellPadding));
            make.width.mas_equalTo(@50);
            make.height.mas_equalTo(self.cellContent.mas_height).and.offset(6);
        }];
    }
    return self;
}

- (void)setContentByInfoModel:(ScreeingDatingDoctorsModel *)model
{
    [super setContentByInfoModel:model];
    self.datingModel = model;
    [self.doctorInfoDetail setText:model.doctorDetail];
    switch (model.doctorDatingStatus) {
        case Doctor_Dating_Status_dated:
        {
            self.doctorDatingStatus.backgroundColor = [UIColor orangeColor];
            [self.doctorDatingStatus setTitle:@"预约" forState:UIControlStateNormal];
            [self.doctorDatingStatus setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
            break;
        case Doctor_Dating_Status_ShouldDating:
        {
            self.doctorDatingStatus.backgroundColor = [UIColor grayColor];
            [self.doctorDatingStatus setTitle:@"预约中" forState:UIControlStateNormal];
            [self.doctorDatingStatus setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
            break;
        case Doctor_Dating_Status_Waiting:
        {
            self.doctorDatingStatus.backgroundColor = [UIColor clearColor];
            [self.doctorDatingStatus setTitle:@"已预约" forState:UIControlStateNormal];
            [self.doctorDatingStatus setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
}

@end

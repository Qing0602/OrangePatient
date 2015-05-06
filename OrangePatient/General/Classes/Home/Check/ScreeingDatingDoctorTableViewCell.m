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
        [self.contentView addSubview:_doctorInfoDetail];
        
        _doctorGrade = [[UILabel alloc] init];
        _doctorGrade.textColor = [UIColor lightGrayColor];
        _doctorGrade.font = [UIFont systemFontOfSize:12.f];
        [self.contentView addSubview:_doctorGrade];
        
        _doctorDatingTime = [[UILabel alloc] init];
        _doctorDatingTime.textColor = [UIColor orangeColor];
        _doctorDatingTime.font = [UIFont systemFontOfSize:12.f];
        [self.contentView addSubview:_doctorDatingTime];
        
        _doctorDatingStatus = [UIButton buttonWithType:UIButtonTypeCustom];
        _doctorDatingStatus.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [self.contentView addSubview:_doctorDatingStatus];
        
        self.cellContent.textColor = [UIColor blackColor];
        self.cellSubTitle.textColor = [UIColor blackColor];
        
        [[self.doctorDatingStatus rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *sender){
            if ([sender.titleLabel.text isEqualToString:@"预约"]) {
                if ([self.delegate respondsToSelector:@selector(willDatingDoctor:)]) {
                    [self.delegate willDatingDoctor:self.datingModel];
                }
            }
        }];
        
        [self.cellTitle mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.mas_equalTo(-190);
        }];
        
        [self.cellSubTitle mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.mas_equalTo(-180);
        }];
        
        [_doctorInfoDetail mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.cellSubTitle.mas_bottom).with.offset(6);
            make.left.equalTo(self.cellSubTitle.mas_left);
            make.right.mas_equalTo(@(-DoctorBaseCellPadding));
            make.bottom.mas_equalTo(@(-6));
        }];
        
        [_doctorGrade mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.cellTitle.mas_top);
            make.left.equalTo(self.cellTitle.mas_right).with.offset(6);
            make.bottom.equalTo(self.cellTitle.mas_bottom);
            make.width.mas_equalTo(50);
        }];
        
        [_doctorDatingTime mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.cellSubTitle.mas_top);
            make.left.equalTo(self.cellSubTitle.mas_right).with.offset(6);
            make.bottom.equalTo(self.cellSubTitle.mas_bottom);
            make.width.mas_equalTo(50);
        }];
        
        [_doctorDatingStatus mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerY.equalTo(self.cellTitle.mas_centerY);
            make.right.mas_equalTo(@(-DoctorBaseCellPadding));
            make.width.mas_equalTo(@50);
            make.height.mas_equalTo(self.cellTitle.mas_height).and.offset(6);
        }];
    }
    return self;
}

- (void)setContentByInfoModel:(ScreeingDatingDoctorsModel *)model
{
    [super setContentByInfoModel:model];
    self.datingModel = model;
    [self.doctorGrade setText:model.doctorGrade];
    [self.doctorInfoDetail setText:model.doctorComment];
    [self.doctorDatingTime setText:@"星期三"];
    switch (model.doctorFriendStatus) {
        case Doctor_Dating_Status_ShouldDating:
        {
            [self.doctorDatingStatus setBackgroundImage:[UIImage imageNamed:@"Cell_Btn_BG"] forState:UIControlStateNormal];
            [self.doctorDatingStatus setTitle:@"预约" forState:UIControlStateNormal];
            [self.doctorDatingStatus setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
            break;
        case Doctor_Dating_Status_Waiting:
        {
            [self.doctorDatingStatus setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            self.doctorDatingStatus.backgroundColor = [UIColor grayColor];
            [self.doctorDatingStatus setTitle:@"预约中" forState:UIControlStateNormal];
            [self.doctorDatingStatus setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
            break;
        case Doctor_Dating_Status_dated:
        {
            [self.doctorDatingStatus setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
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

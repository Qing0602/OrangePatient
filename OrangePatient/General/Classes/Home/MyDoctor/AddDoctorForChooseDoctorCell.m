//
//  AddDoctorForChooseDoctorCell.m
//  OrangePatient
//
//  Created by ZhangQing on 15/4/2.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "AddDoctorForChooseDoctorCell.h"

@implementation AddDoctorForChooseDoctorCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _doctorAbstract = [[UILabel alloc] init];
        _doctorAbstract.textColor = [UIColor lightGrayColor];
        _doctorAbstract.font = [UIFont systemFontOfSize:12.f];
        _doctorAbstract.numberOfLines = 2.f;
        [self.contentView addSubview:_doctorAbstract];
        
        _doctorStatusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _doctorStatusBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [self.contentView addSubview:_doctorStatusBtn];
        
        self.cellContent.textColor = [UIColor blackColor];
        self.cellSubTitle.textColor = [UIColor blackColor];
        
        [[self.doctorStatusBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *sender){
            if ([sender.titleLabel.text isEqualToString:@"添加"]) {
                if ([self.delegate respondsToSelector:@selector(willAddDoctor:)]) {
                    [self.delegate willAddDoctor:self.dtModel];
                }
            }
            
        }];
        
        [self.cellTitle mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.mas_equalTo(-190);
        }];
        
        [self.cellSubTitle mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.mas_equalTo(-180);
        }];
        
        [_doctorAbstract mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.cellSubTitle.mas_bottom).with.offset(6);
            make.left.equalTo(self.cellSubTitle.mas_left);
            make.right.mas_equalTo(@(-DoctorBaseCellPadding));
            make.bottom.mas_equalTo(@(-6));
        }];
        
        [_doctorStatusBtn mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerY.equalTo(self.cellTitle.mas_centerY);
            make.right.mas_equalTo(@(-DoctorBaseCellPadding));
            make.width.mas_equalTo(@60);
            make.height.mas_equalTo(self.cellTitle.mas_height).and.offset(8);
        }];
    }
    
    return self;
}

- (void)setContentByInfoModel:(ChooseDoctorModel *)model
{
    self.dtModel = model;
    //[super setContentByInfoModel:model];
    [self.doctorAbstract setText:model.doctorSpeciality];
    [self.cellImageview setImageURL:model.doctorAvatar];
    [self.cellTitle setText:model.doctorUserName];
    [self.cellContent setText:model.doctorDepartment];
    [self.cellSubTitle setText:model.doctorGrade];
    switch (model.doctorStatus) {
        case Doctor_Status_ShouldAdd:
        {
            [self.doctorStatusBtn setBackgroundImage:[UIImage imageNamed:@"Cell_Btn_BG"] forState:UIControlStateNormal];
            [self.doctorStatusBtn setTitle:@"添加" forState:UIControlStateNormal];
            [self.doctorStatusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
            break;
        case Doctor_Status_Waiting:
        {
            [self.doctorStatusBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            self.doctorStatusBtn.backgroundColor = [UIColor grayColor];
            [self.doctorStatusBtn setTitle:@"等待验证" forState:UIControlStateNormal];
            [self.doctorStatusBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
            break;
        case Doctor_Status_Added:
        {
            [self.doctorStatusBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            self.doctorStatusBtn.backgroundColor = [UIColor clearColor];
            [self.doctorStatusBtn setTitle:@"已添加" forState:UIControlStateNormal];
            [self.doctorStatusBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

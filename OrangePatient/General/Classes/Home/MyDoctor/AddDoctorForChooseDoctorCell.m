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
        _doctorAbstract.backgroundColor = [UIColor yellowColor];
        _doctorAbstract.numberOfLines = 2.f;
        _doctorAbstract.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_doctorAbstract];
        
        _doctorStatusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _doctorStatusBtn.translatesAutoresizingMaskIntoConstraints = NO;
        _doctorStatusBtn.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:_doctorStatusBtn];
        
        [_doctorAbstract mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.cellSubTitle.mas_bottom).with.offset(6);
            make.left.equalTo(self.cellSubTitle.mas_left);
            make.right.mas_equalTo(@(-DoctorBaseCellPadding));
            make.bottom.mas_equalTo(@(-6));
        }];
        
        [_doctorStatusBtn mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerY.equalTo(self.cellContent.mas_centerY);
            make.right.mas_equalTo(@(-DoctorBaseCellPadding));
            make.width.mas_equalTo(@60);
            make.height.mas_equalTo(self.cellContent.mas_height).and.offset(8);
        }];
    }
    
    return self;
}

- (void)setContentByInfoModel:(ChooseDoctorModel *)model
{
    [super setContentByInfoModel:model];
    [self.doctorAbstract setText:model.doctorAbstract];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

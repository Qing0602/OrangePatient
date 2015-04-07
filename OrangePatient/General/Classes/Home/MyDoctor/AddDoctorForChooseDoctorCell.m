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
        _doctorAbstract.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_doctorAbstract];
        
        
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

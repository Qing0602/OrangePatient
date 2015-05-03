//
//  TwoTablesHospitalCell.m
//  OrangePatient
//
//  Created by ZhangQing on 15/4/1.
//  Copyright (c) 2015年 Orange. All rights reserved.
//
#define HospitalCellPadding 14.f

#import "TwoTablesHospitalCell.h"

@implementation TwoTablesHospitalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _cellTitle = [[UILabel alloc] init];
        _cellTitle.font = [UIFont systemFontOfSize:14.f];
        _cellTitle.translatesAutoresizingMaskIntoConstraints = NO;
        _cellTitle.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_cellTitle];
        
        _cellContent = [[UILabel alloc] init];
        _cellContent.font = [UIFont systemFontOfSize:12.f];
        _cellContent.textColor = [UIColor lightGrayColor];
        _cellContent.backgroundColor = [UIColor clearColor];
        _cellContent.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_cellContent];
        
        UIImageView *line = [[UIImageView alloc] init];
        line.backgroundColor = [UIColor colorWithRed:203/255.f green:203/255.f blue:206/255.f alpha:1.f];
        line.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:line];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_cellTitle,_cellContent,line);
        NSDictionary *metrics = @{@"CellPadding":@HospitalCellPadding};
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-CellPadding-[_cellTitle(>=100)]-CellPadding-|" options:0 metrics:metrics views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-CellPadding-[_cellContent(>=100)]-CellPadding-|" options:0 metrics:metrics views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[line]-0-|" options:0 metrics:nil views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-<=CellPadding-[_cellTitle(14)]-==2-[_cellContent(>=14)]-[line(1)]-0-|" options:0 metrics:metrics views:views]];
        
    }
    return self;
}

- (void)setContentByInfoModel:(MyDoctorHospitalsModel *)model
{
    [self.cellTitle setText:model.hospitalName];
    [self.cellContent setText:model.departmentName];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

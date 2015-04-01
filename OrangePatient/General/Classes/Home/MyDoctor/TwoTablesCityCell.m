//
//  TwoTablesCityCell.m
//  OrangePatient
//
//  Created by ZhangQing on 15/4/1.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "TwoTablesCityCell.h"

@implementation TwoTablesCityCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        
        _cellTitle = [[UILabel alloc] init];
        _cellTitle.font = [UIFont systemFontOfSize:14.f];
        _cellTitle.translatesAutoresizingMaskIntoConstraints = NO;
        _cellTitle.backgroundColor = [UIColor clearColor];
        _cellTitle.font = [UIFont systemFontOfSize:18.f];
        [self.contentView addSubview:_cellTitle];
        
        UIImageView *line = [[UIImageView alloc] init];
        line.backgroundColor = [UIColor colorWithRed:203/255.f green:203/255.f blue:206/255.f alpha:1.f];
        line.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:line];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_cellTitle,line);
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[_cellTitle(150)]->=10-|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[line]-0-|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|->=10-[_cellTitle(20)]->=10-[line(1)]-0-|" options:0 metrics:nil views:views]];
        
    }
    return self;
}

- (void)setContentByInfoModel:(MyDoctorCitysModel  *)model
{
    _cellTitle.text = model.cityName;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.cellTitle.textColor = selected ? [UIColor colorWithRed:240/255.f green:186/255.f blue:161/255.f alpha:1.f] : [UIColor blackColor];
    self.contentView.backgroundColor = selected ? [UIColor whiteColor] : [UIColor colorWithRed:217/255.f green:217/255.f blue:217/255.f alpha:1.f];
    // Configure the view for the selected state
}



@end

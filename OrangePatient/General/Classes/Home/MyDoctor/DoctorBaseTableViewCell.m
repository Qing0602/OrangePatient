//
//  DoctorBaseTableViewCell.m
//  OrangePatient
//
//  Created by ZhangQing on 15/3/30.
//  Copyright (c) 2015年 Orange. All rights reserved.
//
#define ImageWidth 75.f
#define CellPadding 5.f

#import "DoctorBaseTableViewCell.h"

@implementation DoctorBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _cellImageview = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"Information_Cell_DefaultImage"]];
        _cellImageview.translatesAutoresizingMaskIntoConstraints = NO;
        _cellImageview.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_cellImageview];
        
        _cellTitle = [[UILabel alloc] init];
        _cellTitle.font = [UIFont systemFontOfSize:14.f];
        _cellTitle.translatesAutoresizingMaskIntoConstraints = NO;
        _cellTitle.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_cellTitle];
        
        _cellContent = [[UILabel alloc] init];
        _cellContent.font = [UIFont systemFontOfSize:13.f];
        _cellContent.textColor = [UIColor lightGrayColor];
        _cellContent.backgroundColor = [UIColor greenColor];
        _cellContent.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_cellContent];
        
        _cellSubTitle = [[UILabel alloc] init];
        _cellSubTitle.font = [UIFont systemFontOfSize:13.f];
        _cellSubTitle.textColor = [UIColor lightGrayColor];
        _cellSubTitle.backgroundColor = [UIColor greenColor];
        _cellSubTitle.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_cellSubTitle];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_cellImageview,_cellTitle,_cellContent,_cellSubTitle);
        NSDictionary *metrics = @{@"ImageWidth":@ImageWidth,@"CellPadding":@CellPadding};
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-CellPadding-[_cellImageview(ImageWidth)]-==10-[_cellTitle(>=100)]->=CellPadding-|" options:0 metrics:metrics views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-CellPadding-[_cellImageview(ImageWidth)]-==10-[_cellContent(>=100)]->=CellPadding-|" options:0 metrics:metrics views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-CellPadding-[_cellImageview(ImageWidth)]-==10-[_cellSubTitle(>=100)]->=CellPadding-|" options:0 metrics:metrics views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-CellPadding-[_cellImageview(ImageWidth)]-CellPadding-|" options:0 metrics:metrics views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-CellPadding-[_cellTitle(16)]->=6-[_cellContent(_cellTitle)]->=6-[_cellSubTitle(_cellTitle)]-CellPadding-|" options:0 metrics:metrics views:views]];
        
    }
    return self;
}

- (void)setContentByInfoModel:(MyDoctorsModel *)model
{
    [self.cellImageview setImageURL:model.doctorAvatar];
    [self.cellTitle setText:model.doctorUserName];
    [self.cellContent setText:model.doctorHostpital];
    [self.cellSubTitle setText:model.doctorTitle];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

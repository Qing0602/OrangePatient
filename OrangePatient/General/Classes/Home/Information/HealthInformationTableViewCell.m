//
//  HealthInformationTableViewCell.m
//  OrangePatient
//
//  Created by ZhangQing on 15/3/25.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#define ImageWidth 75.f
#define CellPadding 5.f
#import "HealthInformationTableViewCell.h"

@implementation HealthInformationTableViewCell

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
        _cellContent.font = [UIFont systemFontOfSize:12.f];
        _cellContent.textColor = [UIColor lightGrayColor];
        _cellContent.numberOfLines = 3;
        _cellContent.backgroundColor = [UIColor greenColor];
        _cellContent.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_cellContent];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_cellImageview,_cellTitle,_cellContent);
        NSDictionary *metrics = @{@"ImageWidth":@ImageWidth,@"CellPadding":@CellPadding};
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-CellPadding-[_cellImageview(ImageWidth)]-==10-[_cellTitle(>=100)]->=CellPadding-|" options:0 metrics:metrics views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-CellPadding-[_cellImageview(ImageWidth)]-==10-[_cellContent(>=100)]->=CellPadding-|" options:0 metrics:metrics views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-CellPadding-[_cellImageview(ImageWidth)]-CellPadding-|" options:0 metrics:metrics views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-CellPadding-[_cellTitle(14)]->=6-[_cellContent(>=50)]-CellPadding-|" options:0 metrics:metrics views:views]];
        
    }
    return self;
}

- (void)setContentByInfoModel:(HealthInfomationModel *)model
{
    [self.cellImageview setImageURL:model.imageUrl];
    [self.cellTitle setText:model.infoTitle];
    [self.cellContent setText:model.infoContent];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

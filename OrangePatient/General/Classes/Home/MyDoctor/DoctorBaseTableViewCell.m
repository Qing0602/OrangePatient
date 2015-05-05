//
//  DoctorBaseTableViewCell.m
//  OrangePatient
//
//  Created by ZhangQing on 15/3/30.
//  Copyright (c) 2015年 Orange. All rights reserved.
//


#import "DoctorBaseTableViewCell.h"

#import "MyDoctorsModel.h"
#import "MyServiceModel.h"
#import "ScreeingDatingDoctorsModel.h"
@implementation DoctorBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _cellImageview = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"MyDoctor_Default_Avatar"]];
        _cellImageview.translatesAutoresizingMaskIntoConstraints = NO;
        _cellImageview.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_cellImageview];
        
        _cellTitle = [[UILabel alloc] init];
        _cellTitle.font = [UIFont systemFontOfSize:13.f];
        _cellTitle.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_cellTitle];
        
        _cellContent = [[UILabel alloc] init];
        _cellContent.font = [UIFont systemFontOfSize:12.f];
        _cellContent.textColor = [UIColor lightGrayColor];
        [_cellContent sizeToFit];
        _cellContent.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_cellContent];
        
        _cellSubTitle = [[UILabel alloc] init];
        _cellSubTitle.font = [UIFont systemFontOfSize:12.f];
        _cellSubTitle.textColor = [UIColor lightGrayColor];
        _cellSubTitle.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_cellSubTitle];
        
        
        [_cellImageview mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.left.mas_equalTo(DoctorBaseCellPadding);
            make.size.mas_equalTo(CGSizeMake(DoctorBaseImageWidth, DoctorBaseImageWidth));
        }];
        
        [_cellTitle mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(_cellImageview.mas_right).and.offset(10);
            make.top.mas_equalTo(DoctorBaseCellPadding);
            make.right.mas_equalTo(-70);
            //make.width.mas_equalTo(50);
            make.height.mas_equalTo(14.f);
        }];
        
        [_cellContent mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.cellTitle.mas_left);
            make.right.mas_equalTo(-20);
            make.height.equalTo(self.cellTitle.mas_height);
            make.top.equalTo(self.cellTitle.mas_bottom).with.offset(6);
        }];
        
        [_cellSubTitle mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.cellTitle.mas_left);
            make.right.equalTo(self.cellContent.mas_right);
            make.height.equalTo(self.cellTitle.mas_height);
            make.top.equalTo(self.cellContent.mas_bottom).with.offset(6);
        }];
        /*
        NSDictionary *views = NSDictionaryOfVariableBindings(_cellImageview,_cellTitle,_cellContent,_cellSubTitle);
        NSDictionary *metrics = @{@"ImageWidth":@ImageWidth,@"CellPadding":@CellPadding};
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-CellPadding-[_cellImageview(ImageWidth)]-==10-[_cellTitle(>=100)]->=CellPadding-|" options:0 metrics:metrics views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-CellPadding-[_cellImageview(ImageWidth)]-==10-[_cellContent(>=100)]->=CellPadding-|" options:0 metrics:metrics views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-CellPadding-[_cellImageview(ImageWidth)]-==10-[_cellSubTitle(>=100)]->=CellPadding-|" options:0 metrics:metrics views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-CellPadding-[_cellImageview(ImageWidth)]-CellPadding-|" options:0 metrics:metrics views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-CellPadding-[_cellTitle(16)]-==6-[_cellContent(_cellTitle)]-==6-[_cellSubTitle(_cellTitle)]->=CellPadding-|" options:0 metrics:metrics views:views]];
        */
    }
    return self;
}

- (void)addSubviewsConstraint
{
    
}

- (void)setContentByInfoModel:(id)model
{
    if ([model isKindOfClass:[MyDoctorsModel class]]) {
        MyDoctorsModel *doctorModel = (MyDoctorsModel *)model;
        [self.cellImageview setImageURL:doctorModel.doctorAvatar];
        [self.cellTitle setText:doctorModel.doctorUserName];
        [self.cellContent setText:doctorModel.doctorDepartment];
        [self.cellSubTitle setText:@"门诊时间:"];
    }else if ([model isKindOfClass:[MyServiceModel class]]){
        MyServiceModel *serviceModel = (MyServiceModel *)model;
        [self.cellImageview setImageURL:[NSURL URLWithString:serviceModel.serviceAvatar]];
        [self.cellTitle setText:serviceModel.serviceNickname];
        [self.cellContent setText:serviceModel.serviceMobile];
        [self.cellSubTitle setText:serviceModel.serviceEmail];
    }

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

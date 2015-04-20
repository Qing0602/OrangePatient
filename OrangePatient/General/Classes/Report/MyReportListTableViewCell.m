//
//  MyReportListTableViewCell.m
//  OrangePatient
//
//  Created by ZhangQing on 15/4/19.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "MyReportListTableViewCell.h"

@implementation MyReportListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *imageIcon = [[UIImageView alloc] init];
        imageIcon.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:imageIcon];
        
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.font = [UIFont systemFontOfSize:12.f];
        [self.contentView addSubview:_typeLabel];
        
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.font = [UIFont systemFontOfSize:12.f];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_statusLabel];
        
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = [UIFont systemFontOfSize:12.f];
        [self.contentView addSubview:_dateLabel];
        
        //_typeLabel.backgroundColor = _statusLabel.backgroundColor = _dateLabel.backgroundColor = [UIColor yellowColor];
        
        [imageIcon mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(15);
            make.width.and.height.mas_equalTo(MyReportListTableViewCell_Height-20);
        }];
        
        [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(imageIcon.mas_top);
            make.left.equalTo(imageIcon.mas_right).with.offset(10);
            make.height.equalTo(imageIcon.mas_height);
            make.width.mas_equalTo(112);
        }];
        
        [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(imageIcon.mas_top);
            make.left.equalTo(_typeLabel.mas_right).with.offset(10);
            make.height.equalTo(imageIcon.mas_height);
            make.width.mas_equalTo(60);
        }];
        
        [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(imageIcon.mas_top);
            make.left.equalTo(_statusLabel.mas_right).with.offset(10);
            make.height.equalTo(imageIcon.mas_height);
            make.right.mas_equalTo(-10);
        }];
        
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContentData:(MyReportListModel *)model{
    self.typeLabel.text = model.reportType;
    self.statusLabel.text = @"未读";
    self.dateLabel.text = model.reportDate;
}
@end

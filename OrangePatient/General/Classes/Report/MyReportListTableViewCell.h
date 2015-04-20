//
//  MyReportListTableViewCell.h
//  OrangePatient
//
//  Created by ZhangQing on 15/4/19.
//  Copyright (c) 2015年 Orange. All rights reserved.
//
#define MyReportListTableViewCell_Height 40
#import <UIKit/UIKit.h>
#import "MyReportListModel.h"

@interface MyReportListTableViewCell : UITableViewCell
//类型
@property (nonatomic, strong)UILabel *typeLabel;
//状态
@property (nonatomic, strong)UILabel *statusLabel;
//日期
@property (nonatomic, strong)UILabel *dateLabel;

- (void)setContentData:(MyReportListModel *)model;
@end

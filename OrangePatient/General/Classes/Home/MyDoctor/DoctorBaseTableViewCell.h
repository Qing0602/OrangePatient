//
//  DoctorBaseTableViewCell.h
//  OrangePatient
//
//  Created by ZhangQing on 15/3/30.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#define DoctorBaseImageWidth 65.f
#define DoctorBaseCellPadding 10.f

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "MyDoctorsModel.h"
@interface DoctorBaseTableViewCell : UITableViewCell
/****UI****/
@property (nonatomic, strong)EGOImageView *cellImageview;
@property (nonatomic, strong)UILabel *cellTitle;
@property (nonatomic, strong)UILabel *cellContent;
@property (nonatomic, strong)UILabel *cellSubTitle;

- (void)setContentByInfoModel:(MyDoctorsModel *)model;
@end

//
//  HealthInformationTableViewCell.h
//  OrangePatient
//
//  Created by ZhangQing on 15/3/25.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HealthInfomationModel.h"
#import "EGOImageView.h"
@interface HealthInformationTableViewCell : UITableViewCell
/****UI****/
@property (nonatomic, strong)EGOImageView *cellImageview;
@property (nonatomic, strong)UILabel *cellTitle;
@property (nonatomic, strong)UILabel *cellContent;

- (void)setContentByInfoModel:(HealthInfomationModel *)model;

@end

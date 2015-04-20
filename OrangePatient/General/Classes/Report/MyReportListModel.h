//
//  MyReportListModel.h
//  OrangePatient
//
//  Created by ZhangQing on 15/4/19.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "BaseNSObject.h"

@interface MyReportListModel : BaseNSObject
//类型
@property (nonatomic, strong)NSString *reportType;
//状态
@property (nonatomic)NSInteger reportStatus;
//日期
@property (nonatomic, strong)NSString *reportDate;
@end

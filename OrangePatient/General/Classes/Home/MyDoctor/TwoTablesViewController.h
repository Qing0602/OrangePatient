//
//  TwoTablesViewController.h
//  OrangePatient
//
//  Created by ZhangQing on 15/4/1.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "OrangeBaseViewController.h"

@class MyDoctorCitysModel;
@class MyDoctorHospitalsModel;
@interface TwoTablesViewController : OrangeBaseViewController<UITableViewDataSource,UITableViewDelegate>

//城市table
@property (nonatomic, strong)UITableView *cityTable;
//医院table
@property (nonatomic, strong)UITableView *hospitalTable;
//CityModel
@property (nonatomic, strong)NSArray *contentData;
@end

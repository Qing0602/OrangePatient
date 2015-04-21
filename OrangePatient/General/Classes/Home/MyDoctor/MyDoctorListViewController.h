//
//  MyDoctorListViewController.h
//  OrangePatient
//
//  Created by ZhangQing on 15/3/30.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "OrangeBaseViewController.h"
typedef enum{
    DoctorListLoadStatusRefresh, // 刷新
    DoctorListLoadStatusAppend,  // 追加
} DoctorListLoadStatus;

@interface MyDoctorListViewController : OrangeBaseViewController

@end

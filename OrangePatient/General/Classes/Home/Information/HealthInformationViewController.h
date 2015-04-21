//
//  HealthInformationViewController.h
//  OrangePatient
//
//  Created by ZhangQing on 15/3/23.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "OrangeBaseViewController.h"

typedef enum{
    InformationLoadStatusRefresh, // 刷新
    InformationLoadStatusAppend,  // 追加
} InformationLoadStatus;

@interface HealthInformationViewController : OrangeBaseViewController

@end

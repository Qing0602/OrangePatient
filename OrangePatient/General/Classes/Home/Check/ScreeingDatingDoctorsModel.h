//
//  ScreeingDatingDoctorsModel.h
//  OrangePatient
//
//  Created by ZhangQing on 15/4/7.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "MyDoctorsModel.h"
typedef NS_ENUM(NSInteger, Doctor_Dating_Status){
    Doctor_Dating_Status_ShouldDating = -1,
    Doctor_Dating_Status_Waiting,
    Doctor_Dating_Status_dated
};

@interface ScreeingDatingDoctorsModel : MyDoctorsModel

+ (ScreeingDatingDoctorsModel *)convertModelByDic:(NSDictionary *)dic;
@end

//
//  MyDoctorsModel.h
//  OrangePatient
//
//  Created by ZhangQing on 15/3/30.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "BaseNSObject.h"


@interface MyDoctorsModel : BaseNSObject
//头像
@property (nonatomic, strong)NSURL *doctorAvatar;
//姓名
@property (nonatomic, strong)NSString *doctorUserName;
//所属医院
@property (nonatomic, strong)NSString *doctorHostpital;
//头衔
@property (nonatomic, strong)NSString *doctorTitle;

@end

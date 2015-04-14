//
//  ScreeningCenterModel.h
//  OrangePatient
//
//  Created by ZhangQing on 15/4/12.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "BaseNSObject.h"

@interface ScreeningCenterModel : BaseNSObject
//筛查点照片
@property (nonatomic, strong)NSString *centerImagePath;
//介绍
@property (nonatomic, strong)NSString *centerIntroduce;
//地址
@property (nonatomic, strong)NSString *centerAddress;
//咨询电话
@property (nonatomic, strong)NSString *centerPhoneNumber;
//地理位置经度
@property (nonatomic)CGFloat centerPlaceLongitude;
//地理位置纬度
@property (nonatomic)CGFloat centerPlaceLagitude;

@end

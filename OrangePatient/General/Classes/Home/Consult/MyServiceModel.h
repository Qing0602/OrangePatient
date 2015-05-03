//
//  MyServiceModel.h
//  OrangePatient
//
//  Created by ZhangQing on 15/5/2.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "BaseNSObject.h"

@interface MyServiceModel : BaseNSObject
//uid
@property (nonatomic, strong)NSString *serviceUid;
//oid
@property (nonatomic, strong)NSString *serviceOid;
//nickname
@property (nonatomic, strong)NSString *serviceNickname;
//type
@property (nonatomic)NSInteger serviceType;
//email
@property (nonatomic, strong)NSString *serviceEmail;
//avatar
@property (nonatomic, strong)NSString *serviceAvatar;
//mobile
@property (nonatomic, strong)NSString *serviceMobile;
//im_username
@property (nonatomic, strong)NSString *serviceImUsername;
//im_nickname
@property (nonatomic, strong)NSString *serviceImNickname;
//status
@property (nonatomic)NSInteger serviceStatus;

+ (MyServiceModel *)convertModelByDic:(NSDictionary *)dic;
@end

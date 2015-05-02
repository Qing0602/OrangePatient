//
//  MyServiceModel.m
//  OrangePatient
//
//  Created by ZhangQing on 15/5/2.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "MyServiceModel.h"

@implementation MyServiceModel
+ (MyServiceModel *)convertModelByDic:(NSDictionary *)dic{
    MyServiceModel *model = [[MyServiceModel  alloc] init];
    //uid
    model.serviceUid = dic[@"uid"];
    //oid
    model.serviceOid = dic[@"oid"];
    //nickname
    model.serviceNickname = dic[@"nickname"];
    //type
    model.serviceType = [dic[@"type"] integerValue];
    //email
    model.serviceEmail = dic[@"email"];
    //avatar
    model.serviceAvatar = dic[@"avatar"];
    //mobile
    model.serviceMobile = dic[@"mobile"];
    //im_username
    model.serviceImUsername = dic[@"im_username"];
    //im_nickname
    model.serviceImNickname = dic[@"im_nickname"];
    //status
    model.serviceStatus = [dic[@"status"] integerValue];
    return model;
}
@end

//
//  MyDoctorsModel.m
//  OrangePatient
//
//  Created by ZhangQing on 15/3/30.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "MyDoctorsModel.h"

@implementation MyDoctorsModel
+ (MyDoctorsModel *)convertModelByDic:(NSDictionary *)dic{
    MyDoctorsModel *model = [[MyDoctorsModel alloc] init];
    model.doctorAvatar = dic[@"logoUrl"];
    model.doctorComment = dic[@"comment"];
    model.doctorEmail = dic[@"email"];
    model.doctorFriendStatus = [dic[@"friendstatus"] integerValue];
    model.doctorGrade = dic[@"grade"];
    model.doctorID = dic[@"uid"];
    model.doctorIMNickName = dic[@"im_nickname"];
    model.doctorIMUsername = dic[@"im_username"];
    model.doctorMobile = dic[@"mobile"];
    model.doctorStatus = [dic[@"status"] integerValue];
    model.doctorUserName = dic[@"name"];
    
    return model;
}
@end

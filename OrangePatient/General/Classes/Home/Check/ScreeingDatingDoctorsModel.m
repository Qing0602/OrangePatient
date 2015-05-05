//
//  ScreeingDatingDoctorsModel.m
//  OrangePatient
//
//  Created by ZhangQing on 15/4/7.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "ScreeingDatingDoctorsModel.h"

@implementation ScreeingDatingDoctorsModel
+ (ScreeingDatingDoctorsModel *)convertModelByDic:(NSDictionary *)dic{
    ScreeingDatingDoctorsModel *model = [[ScreeingDatingDoctorsModel alloc] init];
    model.doctorAvatar = [NSURL URLWithString:dic[@"logoUrl"]];
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
    model.doctorDepartment = dic[@"department"];
    return model;
}
@end

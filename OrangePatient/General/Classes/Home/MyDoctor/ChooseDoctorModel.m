//
//  ChooseDoctorModel.m
//  OrangePatient
//
//  Created by ZhangQing on 15/4/8.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "ChooseDoctorModel.h"

@implementation ChooseDoctorModel
+ (ChooseDoctorModel *)convertModelByDic:(NSDictionary *)dic{
    ChooseDoctorModel  *model = [[ChooseDoctorModel alloc] init];
    model.doctorAvatar = [NSURL URLWithString:dic[@"logoUrl"]];
    model.doctorFriendStatus = [dic[@"friendstatus"] integerValue];
    model.doctorGrade = dic[@"grade"];
    model.doctorID = dic[@"uid"];
//    model.doctorIMNickName = dic[@"im_nickname"];
//    model.doctorIMUsername = dic[@"im_username"];
    model.doctorStatus = [dic[@"status"] integerValue];
    model.doctorUserName = dic[@"name"];
    model.doctorDepartment = dic[@"department"];
    model.doctorSpeciality = dic[@"speciality"];
    model.doctorWorktime = dic[@"worktime"];
    return model;
}
@end

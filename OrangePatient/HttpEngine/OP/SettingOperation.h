//
//  SettingOperation.h
//  OrangePatient
//
//  Created by singlew on 15/4/3.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "CustomOperation.h"
typedef enum{
    kGetArea,
    kGetCity,
    kGetHospital,
    kGetDepartment,
    kGetDoctors,
    kGetService
}SettingType;
@interface SettingOperation : CustomOperation
-(SettingOperation *) initGetArea;
-(SettingOperation *) initGetCity : (NSInteger) areaID;
-(SettingOperation *) initGetHospital : (NSUInteger) limit withOffset : (NSUInteger) offset withCode : (NSInteger) code;
-(SettingOperation *) initGetDepartment : (NSUInteger) limit withOffset : (NSUInteger) offset withCode : (NSInteger) code;
-(SettingOperation *) initGetDoctors : (NSUInteger) limit withOffset : (NSUInteger) offset withCode : (NSInteger) code;
-(SettingOperation *) initGetService;
@end

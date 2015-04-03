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
}SettingType;
@interface SettingOperation : CustomOperation
-(SettingOperation *) initGetArea;
-(SettingOperation *) initGetCity : (NSInteger) areaID;
@end

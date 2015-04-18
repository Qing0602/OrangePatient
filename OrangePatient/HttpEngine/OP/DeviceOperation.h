//
//  DeviceOperation.h
//  OrangePatient
//
//  Created by singlew on 15/4/17.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "CustomOperation.h"

typedef enum{
    kPostDeviceData,
    kPostRegisterDevice,
    kGetMyDevice,
    kDeleteDevice,
}DeviceType;

@interface DeviceOperation : CustomOperation
-(DeviceOperation *) initGetMyDevice;
-(DeviceOperation *) initRegisterDevice : (NSString *) peripheralID withName : (NSString *) name;
-(DeviceOperation *) initDeleteDevice : (NSString *) peripheralID;
-(DeviceOperation *) initPostDeviceData : (long) startTime withEndTime : (long) endTime withPeripheralID : (NSString *) peripheralID withData : (NSData *) data;
@end

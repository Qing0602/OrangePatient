//
//  DoctorsOperation.h
//  OrangePatient
//
//  Created by singlew on 15/4/17.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "CustomOperation.h"

typedef enum{
    kGetMyAppointmentList,
    kAppointment,
    kGetSearchDoctors,
    kPostFollowDoctor,
}DoctorType;

@interface DoctorsOperation : CustomOperation
-(DoctorsOperation *) initGetMyAppointmentList : (NSUInteger) offset withLimit : (NSUInteger) limit;
-(DoctorsOperation *) initAppointment : (NSString *) uid withTimeStamp : (long) timeStamp;
-(DoctorsOperation *) initSearchDoctors : (long) districtID withHospitalID : (long) hospitalID;
-(DoctorsOperation *) initFollowDoctor : (NSString *) uid;
@end

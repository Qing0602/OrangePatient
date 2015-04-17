//
//  DoctorsOperation.m
//  OrangePatient
//
//  Created by singlew on 15/4/17.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "DoctorsOperation.h"
#import "UIManagement.h"

@interface DoctorsOperation ()
@property (nonatomic) DoctorType type;
-(void) getMyAppointmentList;
-(void) postAppointment;
-(void) getSearchDoctor;
-(void) postFollowDoctor;
@end

@implementation DoctorsOperation
-(DoctorsOperation *) initGetMyAppointmentList : (NSUInteger) offset withLimit : (NSUInteger) limit{
    self = [self initCustomOperation];
    if (nil != self) {
        self.type = kGetMyAppointmentList;
        NSString *urlStr = [NSString stringWithFormat:@"%@api/doctors/mine?oauth_token=%@&oauth_token_secret=%@&start=%lu&limit=%lu&order=DESC",
                            K_HOST_OF_SERVER,[UIManagement sharedInstance].userAccount.userOauthToken,
                            [UIManagement sharedInstance].userAccount.userOauthTokenSecret,offset,limit];
        [self setHttpRequestGetWithUrl:urlStr];
    }
    return self;
}

-(DoctorsOperation *) initAppointment : (NSString *) uid withTimeStamp : (long) timeStamp{
    self = [self initCustomOperation];
    if (nil != self) {
        self.type = kAppointment;
        NSString *urlStr = [NSString stringWithFormat:@"%@/api/doctors/appointment/%@",K_HOST_OF_SERVER,uid];
        [self setHttpRequestPostWithUrl:urlStr params:@{@"oauth_token" : [UIManagement sharedInstance].userAccount.userOauthToken,
                                                        @"oauth_token_secret":[UIManagement sharedInstance].userAccount.userOauthTokenSecret,
                                                        @"appoint_time":[NSNumber numberWithLong:timeStamp]}];
    }
    return self;
}

-(DoctorsOperation *) initSearchDoctors : (long) districtID withHospitalID : (long) hospitalID{
    self = [self initCustomOperation];
    if (nil != self) {
        self.type = kGetSearchDoctors;
        NSString *urlStr = [NSString stringWithFormat:@"%@api/doctors/search?district_id=%lu&hospital_id=%lu&order=ASC",
                            K_HOST_OF_SERVER,districtID,hospitalID];
        [self setHttpRequestGetWithUrl:urlStr];
    }
    return self;
}

-(DoctorsOperation *) initFollowDoctor : (NSString *) uid{
    self = [self initCustomOperation];
    if (nil != self) {
        self.type = kGetSearchDoctors;
        NSString *urlStr = [NSString stringWithFormat:@"%@api/doctors/follow/%@",
                            K_HOST_OF_SERVER,uid];
        [self setHttpRequestPostWithUrl:urlStr params:@{@"oauth_token" : [UIManagement sharedInstance].userAccount.userOauthToken,
                                                        @"oauth_token_secret":[UIManagement sharedInstance].userAccount.userOauthTokenSecret}];
    }
    return self;
}

-(void) getMyAppointmentList{
    [self.request setRequestCompleted:^(NSDictionary *data){
        dispatch_block_t updateTagBlock = ^{
            [UIManagement sharedInstance].getMyAppointmentListResult = data;
        };
        dispatch_async(dispatch_get_main_queue(), updateTagBlock);
    }];
    [self startAsynchronous];
}

-(void) postAppointment{
    [self.dataRequest setRequestCompleted:^(NSDictionary *data){
        dispatch_block_t updateTagBlock = ^{
            [UIManagement sharedInstance].appointmentDoctorResult = data;
        };
        dispatch_async(dispatch_get_main_queue(), updateTagBlock);
    }];
    [self startAsynchronous];
}

-(void) getSearchDoctor{
    [self.request setRequestCompleted:^(NSDictionary *data){
        dispatch_block_t updateTagBlock = ^{
            [UIManagement sharedInstance].searchDoctorResult = data;
        };
        dispatch_async(dispatch_get_main_queue(), updateTagBlock);
    }];
    [self startAsynchronous];
}

-(void) postFollowDoctor{
    [self.dataRequest setRequestCompleted:^(NSDictionary *data){
        dispatch_block_t updateTagBlock = ^{
            [UIManagement sharedInstance].followDoctorResult = data;
        };
        dispatch_async(dispatch_get_main_queue(), updateTagBlock);
    }];
    [self startAsynchronous];
}

-(void) main{
    @autoreleasepool {
        switch (self.type) {
            case kGetMyAppointmentList:
                [self getMyAppointmentList];
                break;
            case kAppointment:
                [self postAppointment];
                break;
            case kGetSearchDoctors:
                [self getSearchDoctor];
                break;
            case kPostFollowDoctor:
                [self postFollowDoctor];
                break;
            default:
                break;
        }
    }
}

@end

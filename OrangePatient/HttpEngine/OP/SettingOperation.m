//
//  SettingOperation.m
//  OrangePatient
//
//  Created by singlew on 15/4/3.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "SettingOperation.h"
#import "UIManagement.h"

@interface SettingOperation ()
@property(nonatomic) SettingType type;
-(void) getArea;
-(void) getCity;
-(void) getHospital;
-(void) getDepartment;
-(void) getDoctors;
@end

@implementation SettingOperation
-(SettingOperation *) initGetArea{
    self = [self initCustomOperation];
    if (nil != self) {
        self.type = kGetArea;
        NSString *urlStr = [NSString stringWithFormat:@"%@api/setting/district",K_HOST_OF_SERVER];
        [self setHttpRequestGetWithUrl:urlStr];
    }
    return self;
}

-(SettingOperation *) initGetCity : (NSInteger) areaID{
    self = [self initCustomOperation];
    if (nil != self) {
        self.type = kGetCity;
        NSString *urlStr = [NSString stringWithFormat:@"%@api/setting/city/%@",K_HOST_OF_SERVER,[NSString stringWithFormat:@"%ld",areaID]];
        [self setHttpRequestGetWithUrl:urlStr];
    }
    return self;
}

-(SettingOperation *) initGetHospital : (NSUInteger) limit withOffset : (NSUInteger) offset withCode : (NSInteger) code{
    self = [self initCustomOperation];
    if (nil != self) {
        self.type = kGetHospital;
        NSString *urlStr = [NSString stringWithFormat:@"%@api/setting/hospital/%ld?start=%ld&limit=%ld",K_HOST_OF_SERVER,code,offset,limit];
        [self setHttpRequestGetWithUrl:urlStr];
    }
    return self;
}

-(SettingOperation *) initGetDepartment : (NSUInteger) limit withOffset : (NSUInteger) offset withCode : (NSInteger) code{
    self = [self initCustomOperation];
    if (nil != self) {
        self.type = kGetDepartment;
        NSString *urlStr = [NSString stringWithFormat:@"%@api/setting/department/%ld?start=%ld&limit=%ld",K_HOST_OF_SERVER,code,offset,limit];
        [self setHttpRequestGetWithUrl:urlStr];
    }
    return self;
}

-(SettingOperation *) initGetDoctors : (NSUInteger) limit withOffset : (NSUInteger) offset withCode : (NSInteger) code{
    self = [self initCustomOperation];
    if (nil != self) {
        self.type = kGetDoctors;
        NSString *urlStr = [NSString stringWithFormat:@"%@api/setting/doctors/%ld?start=%ld&limit=%ld",K_HOST_OF_SERVER,code,offset,limit];
        [self setHttpRequestGetWithUrl:urlStr];
    }
    return self;
}

-(SettingOperation *) initGetService{
    self = [self initCustomOperation];
    if (nil != self) {
        self.type = kGetService;
        NSString *urlStr = [NSString stringWithFormat:@"%@api/setting/mykefu",K_HOST_OF_SERVER];
        [self setHttpRequestGetWithUrl:urlStr];
    }
    return self;
}

-(void) getArea{
    [self.request setRequestCompleted:^(NSDictionary *data){
        dispatch_block_t updateTagBlock = ^{
            [UIManagement sharedInstance].getAreaResult = data;
        };
        dispatch_async(dispatch_get_main_queue(), updateTagBlock);
    }];
    [self startAsynchronous];
}

-(void) getCity{
    [self.request setRequestCompleted:^(NSDictionary *data){
        dispatch_block_t updateTagBlock = ^{
            [UIManagement sharedInstance].getCityResult = data;
        };
        dispatch_async(dispatch_get_main_queue(), updateTagBlock);
    }];
    [self startAsynchronous];
}

-(void) getHospital{
    [self.request setRequestCompleted:^(NSDictionary *data){
        dispatch_block_t updateTagBlock = ^{
            [UIManagement sharedInstance].getHospitalResult = data;
        };
        dispatch_async(dispatch_get_main_queue(), updateTagBlock);
    }];
    [self startAsynchronous];
}

-(void) getDepartment{
    [self.request setRequestCompleted:^(NSDictionary *data){
        dispatch_block_t updateTagBlock = ^{
            [UIManagement sharedInstance].getHospitalResult = data;
        };
        dispatch_async(dispatch_get_main_queue(), updateTagBlock);
    }];
    [self startAsynchronous];
}

-(void) getDoctors{
    [self.request setRequestCompleted:^(NSDictionary *data){
        dispatch_block_t updateTagBlock = ^{
            [UIManagement sharedInstance].getDoctorsResult = data;
        };
        dispatch_async(dispatch_get_main_queue(), updateTagBlock);
    }];
    [self startAsynchronous];
}

- (void)getService{
    [self.request setRequestCompleted:^(NSDictionary *data){
        dispatch_block_t updateTagBlock = ^{
            [UIManagement sharedInstance].myServiceResult = data;
        };
        dispatch_async(dispatch_get_main_queue(), updateTagBlock);
    }];
    [self startAsynchronous];
}


-(void) main{
    @autoreleasepool {
        switch (self.type) {
            case kGetArea:
                [self getArea];
                break;
            case kGetCity:
                [self getCity];
                break;
            case kGetHospital:
                [self getHospital];
                break;
            case kGetDepartment:
                [self getDepartment];
                break;
            case kGetDoctors:
                [self getDoctors];
                break;
            case kGetService:
            [self getService];
            break;
            default:
                break;
        }
    }
}
@end

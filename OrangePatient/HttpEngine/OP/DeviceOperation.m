//
//  DeviceOperation.m
//  OrangePatient
//
//  Created by singlew on 15/4/17.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "DeviceOperation.h"
#import "UIManagement.h"

@interface DeviceOperation ()
@property (nonatomic) DeviceType type;
-(void) getMyDevice;
-(void) registerDevice;
-(void) deleteDevice;
-(void) postDeviceData;
@end

@implementation DeviceOperation

-(DeviceOperation *) initGetMyDevice{
    self = [self initCustomOperation];
    if (nil != self) {
        self.type = kGetMyDevice;
        NSString *urlStr = [NSString stringWithFormat:@"%@api/device/mine?oauth_token=%@&oauth_token_secret=%@&order=ASC",K_HOST_OF_SERVER,[UIManagement sharedInstance].userAccount.userOauthToken,[UIManagement sharedInstance].userAccount.userOauthTokenSecret];
        [self setHttpRequestGetWithUrl:urlStr];
    }
    return self;
}

-(DeviceOperation *) initRegisterDevice : (NSString *) peripheralID withName : (NSString *) name{
    self = [self initCustomOperation];
    if (nil != self) {
        self.type = kPostRegisterDevice;
        NSString *urlStr = [NSString stringWithFormat:@"%@/api/device/register",K_HOST_OF_SERVER];
        [self setHttpRequestPostWithUrl:urlStr params:@{@"oauth_token" : [UIManagement sharedInstance].userAccount.userOauthToken,
                                                        @"oauth_token_secret":[UIManagement sharedInstance].userAccount.userOauthTokenSecret,
                                                        @"sn":peripheralID,
                                                        @"name":name}];
    }
    return self;
}

-(DeviceOperation *) initDeleteDevice : (NSString *) peripheralID{
    self = [self initCustomOperation];
    if (nil != self) {
        self.type = kDeleteDevice;
        NSString *urlStr = [NSString stringWithFormat:@"%@/api/device/detail/%@",K_HOST_OF_SERVER,peripheralID];
        [self setHttpRequestPostWithUrl:urlStr params:@{@"oauth_token" : [UIManagement sharedInstance].userAccount.userOauthToken,
                                                        @"oauth_token_secret":[UIManagement sharedInstance].userAccount.userOauthTokenSecret,
                                                        @"_method":@"DELETE"}];
    }
    return self;
}

-(DeviceOperation *) initPostDeviceData : (long) startTime withEndTime : (long) endTime withPeripheralID : (NSString *) peripheralID withData : (NSData *) data{
    self = [self initCustomOperation];
    if (nil != self) {
        self.type = kPostDeviceData;
        NSString *urlStr = [NSString stringWithFormat:@"%@/api/device/filedata/%@",K_HOST_OF_SERVER,peripheralID];
        [self setHttpRequestPostWithUrl:urlStr params:@{@"oauth_token" : [UIManagement sharedInstance].userAccount.userOauthToken,
                                                        @"oauth_token_secret":[UIManagement sharedInstance].userAccount.userOauthTokenSecret,
                                                        @"start_time" : [NSNumber numberWithLong:startTime],
                                                        @"end_time" : [NSNumber numberWithLong:endTime],
                                                        @"data" : data,
                                                        }];
    }
    return self;
}

-(void) getMyDevice{
    [self.request setRequestCompleted:^(NSDictionary *data){
        dispatch_block_t updateTagBlock = ^{
            [UIManagement sharedInstance].getMyDeviceResult = data;
        };
        dispatch_async(dispatch_get_main_queue(), updateTagBlock);
    }];
    [self startAsynchronous];
}

-(void) registerDevice{
    [self.dataRequest setRequestCompleted:^(NSDictionary *data){
        dispatch_block_t updateTagBlock = ^{
            [UIManagement sharedInstance].registerDeviceResult = data;
        };
        dispatch_async(dispatch_get_main_queue(), updateTagBlock);
    }];
    [self startAsynchronous];
}

-(void) deleteDevice{
    [self.dataRequest setRequestCompleted:^(NSDictionary *data){
        dispatch_block_t updateTagBlock = ^{
            [UIManagement sharedInstance].deleteMydeviceResult = data;
        };
        dispatch_async(dispatch_get_main_queue(), updateTagBlock);
    }];
    [self startAsynchronous];
}

-(void) postDeviceData{
    [self.dataRequest setRequestCompleted:^(NSDictionary *data){
        dispatch_block_t updateTagBlock = ^{
            [UIManagement sharedInstance].uploadMyDeviceData = data;
        };
        dispatch_async(dispatch_get_main_queue(), updateTagBlock);
    }];
    [self startAsynchronous];
}

-(void) main{
    @autoreleasepool {
        switch (self.type) {
            case kGetMyDevice:
                [self getMyDevice];
                break;
            case kPostRegisterDevice:
                [self registerDevice];
                break;
            case kDeleteDevice:
                [self deleteDevice];
                break;
            case kPostDeviceData:
                [self postDeviceData];
                break;
            default:
                break;
        }
    }
}
@end

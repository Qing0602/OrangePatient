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

-(void) main{
    @autoreleasepool {
        switch (self.type) {
            case kGetArea:
                [self getArea];
                break;
            case kGetCity:
                [self getCity];
                break;
            default:
                break;
        }
    }
}
@end

//
//  UserOperation.m
//  OrangePatient
//
//  Created by singlew on 15/3/28.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "UserOperation.h"

@interface UserOperation ()
@property(nonatomic) UserType type;
-(void) login;
-(void) verifyCode;
@end

@implementation UserOperation

-(UserOperation *) initLogin : (NSString *) userName withPassword : (NSString *) password{
    self = [self initCustomOperation];
    if (nil != self) {
        self.type = kLogin;
        NSString *urlStr = [NSString stringWithFormat:@"%@/users/login?username=%@&password=%@",K_HOST_OF_SERVER,userName,password];
        [self setHttpRequestGetWithUrl:urlStr];
    }
    return self;
}

-(UserOperation *) initGetVerifyCode:(NSString *)phoneNumber withType:(NSInteger)typeCode{
    self = [self initCustomOperation];
    if (nil != self) {
        self.type = kGetVerifyCode;
        NSString *urlStr = [NSString stringWithFormat:@"%@/users/verifycode",K_HOST_OF_SERVER];
        [self setHttpRequestPostWithUrl:urlStr params:@{@"mobile":phoneNumber,@"type":[NSNumber numberWithInt:typeCode]}];
    }
    return self;
}

-(void) login{
    [self.request setRequestCompleted:^(NSDictionary *data){
        dispatch_block_t updateTagBlock = ^{
            [UIManagement sharedInstance].loginResult = data;
        };
        dispatch_async(dispatch_get_main_queue(), updateTagBlock);
    }];
    [self startAsynchronous];
}

-(void) verifyCode{
    [self.request setRequestCompleted:^(NSDictionary *data){
        dispatch_block_t updateTagBlock = ^{
            [UIManagement sharedInstance].verifyCodeResult = data;
        };
        dispatch_async(dispatch_get_main_queue(), updateTagBlock);
    }];
    [self startAsynchronous];
}

-(void) main{
    @autoreleasepool {
        switch (self.type) {
            case kLogin:
                [self login];
                break;
            case kGetVerifyCode:
                [self verifyCode];
                break;
            default:
                break;
        }
    }
}


@end

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
@end

@implementation UserOperation

-(UserOperation *) initLogin : (NSString *) userName withPassword : (NSString *) password{
    self = [self initCustomOperation];
    if (nil != self) {
        self.type = kLogin;
        NSString *urlStr = [NSString stringWithFormat:@"%@api/users/login?username=%@&password=%@",K_HOST_OF_SERVER,userName,password];
        [self setHttpRequestGetWithUrl:urlStr];
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

-(void) main{
    @autoreleasepool {
        switch (self.type) {
            case kLogin:
                [self login];
                break;
            default:
                break;
        }
    }
}


@end

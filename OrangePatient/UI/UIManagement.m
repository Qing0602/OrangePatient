//
//  UIManagement.m
//  OrangeDoctor
//
//  Created by singlew on 15/3/3.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "UIManagement.h"

@implementation UIManagement

static UIManagement *sharedInstance = nil;

+(UIManagement *) sharedInstance{
    @synchronized(sharedInstance){
        if (nil == sharedInstance){
            sharedInstance = [[UIManagement alloc] init];
        }
    }
    return sharedInstance;
}

-(void) login : (NSString *) userName withPassword : (NSString *) password{
    UserOperation *operation = [[UserOperation alloc] initLogin:userName withPassword:password];
    [[NetWorkService sharedInstance] networkEngine:operation];
}
@end

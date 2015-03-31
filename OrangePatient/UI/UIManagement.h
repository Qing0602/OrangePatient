//
//  UIManagement.h
//  OrangeDoctor
//
//  Created by singlew on 15/3/3.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserOperation.h"


@interface UIManagement : NSObject
+(UIManagement *) sharedInstance;

// 登陆
@property (nonatomic,strong) NSDictionary *loginResult;

// 登陆
-(void) login : (NSString *) userName withPassword : (NSString *) password;
@end

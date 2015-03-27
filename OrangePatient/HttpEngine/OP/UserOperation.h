//
//  UserOperation.h
//  OrangePatient
//
//  Created by singlew on 15/3/28.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "Operation.h"

typedef enum{
    kLogin,
}UserType;

@interface UserOperation : Operation
-(UserOperation *) initLogin : (NSString *) userName withPassword : (NSString *) password;

@end

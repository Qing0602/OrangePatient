//
//  AsiGetRequestModel.m
//  teacher
//
//  Created by singlew on 14-3-7.
//  Copyright (c) 2014年 ws. All rights reserved.
//

#import "AsiGetRequestModel.h"

@implementation AsiGetRequestModel
-(id) init{
    self = [super init];
    if (nil != self) {
        self.limit = 30;
    }
    return self;
}
@end

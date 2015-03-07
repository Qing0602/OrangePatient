//
//  PalmHTTPRequest.m
//  teacher
//
//  Created by singlew on 14-3-7.
//  Copyright (c) 2014年 ws. All rights reserved.
//

#import "HTTPRequest.h"

@implementation HTTPRequest
-(id) initWithURL:(NSURL *)newURL{
    self = [super initWithURL:newURL];
    if (nil != self) {
        self.clazz = nil;
        self.clazzAction = nil;
        self.requestCompletedToCache = nil;
        self.needAutoShowErrorMessage = YES;
        self.context = nil;
        
    }
    return self;
}
@end

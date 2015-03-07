//
//  PalmHTTPRequest.h
//  teacher
//
//  Created by singlew on 14-3-7.
//  Copyright (c) 2014年 ws. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"


typedef void (^stOperationCompleted)(NSDictionary *data);

@interface HTTPRequest : ASIHTTPRequest
@property (nonatomic,strong) id clazz;
@property (nonatomic) SEL clazzAction;
@property (nonatomic) NSUInteger type;
@property (nonatomic,strong) stOperationCompleted requestCompletedToCache;
@property (nonatomic,strong) stOperationCompleted requestCompleted;
@property (nonatomic) BOOL needAutoShowErrorMessage;
@property (nonatomic,strong) id context;
@end

//
//  PalmNetWorkService.h
//  teacher
//
//  Created by singlew on 14-3-7.
//  Copyright (c) 2014年 ws. All rights reserved.
//

#define maxQueueCount 1
#import "HttpEngine.h"
#import <Foundation/Foundation.h>
#import "ASINetworkQueue.h"
#import "Operation.h"

@interface NetWorkService : HttpEngine
@property(nonatomic,strong) ASINetworkQueue *uiBusinessQueue;

+(NetWorkService *) sharedInstance;

// 封装网络请求的Operation
-(void) networkEngine : (Operation *)operation;
// 开始网络请求的Operation
-(void) startAsynchronous : (NSOperation *) request;
-(void) canelHttpRequestFrom : (id) clazz;
@end

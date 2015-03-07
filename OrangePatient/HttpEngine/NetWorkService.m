//
//  PalmNetWorkService.m
//  teacher
//
//  Created by singlew on 14-3-7.
//  Copyright (c) 2014年 ws. All rights reserved.
//

#import "NetWorkService.h"
#import <objc/message.h>

@interface NetWorkService ()
@property(nonatomic,strong) NSOperationQueue *serviceQueue;
@property(nonatomic,strong) NSMutableArray *requestArray;
-(void) initialize;
-(void) removeFinishedRequest : (HTTPRequest*)request;
-(void) cancelAllTimeOut;
@end

@implementation NetWorkService
static NetWorkService *engine;

+(NetWorkService *) sharedInstance{
    @synchronized(engine){
        if (nil == engine) {
            engine = [[NetWorkService alloc] init];
            [engine initialize];
        }
    }
    return engine;
}

-(void) initialize{
    self.serviceQueue = [[NSOperationQueue alloc] init];
    self.serviceQueue.maxConcurrentOperationCount = maxQueueCount;
    self.uiBusinessQueue = [[ASINetworkQueue alloc] init];
    [self.uiBusinessQueue setRequestDidFinishSelector:@selector(requestFinished:)];
    [self.uiBusinessQueue setRequestDidFailSelector:@selector(requestFailed:)];
    self.uiBusinessQueue.maxConcurrentOperationCount = maxQueueCount;
    [self.uiBusinessQueue setShouldCancelAllRequestsOnFailure:NO];
    self.requestArray = [[NSMutableArray alloc] initWithCapacity:10];
}

-(void) networkEngine:(Operation *)operation{
    [self.serviceQueue addOperation:operation];
}

-(BOOL) addSTOperation:(HTTPRequest *)op{
    if ([super addSTOperation:op]) {
        [self.uiBusinessQueue addOperation:op];
    }
    return NO;
}

-(void) requestFinished:(HTTPRequest *)request{
    @synchronized(self.requestArray){
        [self removeFinishedRequest:request];
    }
    [super requestFinished:request];
}

-(void) requestFailed:(HTTPRequest *)request{
    @synchronized(self.requestArray){
        [self removeFinishedRequest:request];
    }
    [super requestFailed:request];
    NSError *error = [request error];
    if (error.code == ASIRequestTimedOutErrorType){
        [self cancelAllTimeOut];
    }
}

-(void) cancelAllTimeOut{
    @synchronized(self.requestArray){
        NSMutableArray *removeObjects = [NSMutableArray arrayWithCapacity:2];
        for (HTTPRequest *request in self.requestArray) {
            [request clearDelegatesAndCancel];
            [removeObjects addObject:request];
            
            //调用委托
            if (nil != request.clazz && nil != request.clazzAction && [request.clazz respondsToSelector:request.clazzAction]) {
                NSDictionary *result = [self configRequestResult:YES withErrorMsg:NSLocalizedString(@"TimeOut", @"") withData:nil withContext:request.context];
                [self sendMsgToAutoShowErrorMessage:request.clazz withMsg:[result objectForKey:ASI_REQUEST_ERROR_MESSAGE]];
                [self callback:request.clazz withAction:request.clazzAction withResult:result];
            }
        }
        [self.requestArray removeObjectsInArray:removeObjects];
    }
}

-(void) startAsynchronous:(NSOperation *)request{
    @synchronized(self.requestArray){
        [self.requestArray addObject:request];
        [self.uiBusinessQueue addOperation:request];
        [self.uiBusinessQueue go];
    }
}

-(void) canelHttpRequestFrom : (id)clazz{
    @synchronized(self.requestArray){
        NSMutableArray *removeObjects = [NSMutableArray arrayWithCapacity:2];
        for (HTTPRequest *request in self.requestArray) {
            if ([request.clazz isEqual:clazz]) {
                [request clearDelegatesAndCancel];
                [removeObjects addObject:request];
            }
        }
        [self.requestArray removeObjectsInArray:removeObjects];
    }
}

-(void) removeFinishedRequest : (HTTPRequest*)request{
    @synchronized(self.requestArray){
        NSMutableArray *removeObjects = [NSMutableArray arrayWithCapacity:2];
        for (HTTPRequest *temp in self.requestArray) {
            if ([temp.clazz isEqual:request.clazz]) {
                [removeObjects addObject:temp];
            }
        }
        [self.requestArray removeObjectsInArray:removeObjects];
    }
}
@end

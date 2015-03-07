    
//
//  PalmHttpEngine.m
//  teacher
//
//  Created by singlew on 14-3-7.
//  Copyright (c) 2014年 ws. All rights reserved.
//

#import "HttpEngine.h"
#import <objc/message.h>
#import "Reachability.h"
#import "UIManagement.h"

@interface HttpEngine ()
//转换数据
-(id) getJSONObject:(NSString *)jsonString;
-(void) sendMsgToAutoCloseProgress : (id) clazz;
@end

@implementation HttpEngine

-(id) init{
    self = [super init];
    if (nil != self) {
        self.hasError = NO;
        self.errorMessage = @"";
    }
    return self;
}

-(BOOL) addSTOperation:(HTTPRequest *)op{
    return [self canConnected:op];
}

-(BOOL) canConntected{
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    if ([reach isReachable]) {
        return YES;
    }else{
        return NO;
    }
}

-(BOOL) canConnected : (HTTPRequest *) request{
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    if ([reach isReachable]) {
        return YES;
    }else{
        self.hasError = YES;
        self.errorMessage = NSLocalizedString(@"NetWorkError", @"");
        //调用委托
        if (nil != request.clazz && nil != request.clazzAction && [request.clazz respondsToSelector:request.clazzAction]) {
            NSDictionary *result = [self configRequestResult:YES withErrorMsg:self.errorMessage withData:nil withContext:request.context];
            [self sendMsgToAutoShowErrorMessage:request.clazz withMsg:[result objectForKey:ASI_REQUEST_ERROR_MESSAGE]];
            [self callback:request.clazz withAction:request.clazzAction withResult:result];
        }
        return NO;
    }
}

#pragma mark - ASIHTTPRequestDelegate
- (void)requestFinished:(HTTPRequest *)request{
    
    self.hasError = NO;
    self.errorMessage = @"";
    
    
    // 当以文本形式读取返回内容时用这个方法
    NSString *responseString = [request responseString];
    NSDictionary *dic = [self getJSONObject:responseString];
    
    // 获取网络访问Header信息并判断
    NSDictionary *headers = dic[@"header"];
    
    int status = [headers[@"status"] intValue];
    
    if (!status) {
        self.hasError = YES;
        self.errorMessage = headers[@"message"];
    }else{
        self.errorMessage = headers[@"message"];
    }
    if (!self.hasError) {
        [self sendMsgToAutoCloseProgress:request.clazz];
    }
    
    // 调用委托
    NSDictionary *result = [self configRequestResult:self.hasError withErrorMsg:self.errorMessage withData:dic[@"body"] withContext:request.context];
    
    // 用于KVO回调
    if (request.requestCompleted != nil) {
        request.requestCompleted(result);
    }
}

- (void)requestFailed:(HTTPRequest *)request{
    self.hasError = YES;
    NSError *error = [request error];
    if (error.code == ASIRequestTimedOutErrorType) {
        self.errorMessage = NSLocalizedString(@"TimeOut", @"");
    }else{
        self.errorMessage = NSLocalizedString(@"NetWorkError", @"");
    }
    
    NSDictionary *result = [self configRequestResult:self.hasError withErrorMsg:self.errorMessage withData:nil withContext:request.context];
    // 用于KVO回调
    if (request.requestCompleted != nil) {
        request.requestCompleted(result);
    }
    //调用委托
    if (nil != request.clazz && nil != request.clazzAction && [request.clazz respondsToSelector:request.clazzAction]) {
        if (request.needAutoShowErrorMessage) {
            [self sendMsgToAutoShowErrorMessage:request.clazz withMsg:[result objectForKey:ASI_REQUEST_ERROR_MESSAGE]];
        }
        [self callback:request.clazz withAction:request.clazzAction withResult:result];
    }
}

-(id)getJSONObject:(NSString *)jsonString{
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    return [data objectFromJSONData];
}

-(void) sendMsgToAutoCloseProgress : (id) clazz{
    SEL autoCloseProgress = NSSelectorFromString(@"autoCloseProgress");
    
    if (nil != autoCloseProgress && nil != clazz) {
        if ([clazz respondsToSelector:autoCloseProgress]) {
//            objc_msgSend(clazz, autoCloseProgress);
        }
    }
}

-(void) sendMsgToAutoShowErrorMessage : (id) clazz withMsg : (NSString *) msg{
    SEL autoShowErrorMessage = NSSelectorFromString(@"showProgressAutoWithText:withDelayTime:");
    if (nil != autoShowErrorMessage && nil != clazz) {
        if ([clazz respondsToSelector:autoShowErrorMessage]) {
//            objc_msgSend(clazz, autoShowErrorMessage,msg,2);
        }
    }
}

-(NSDictionary *) configRequestResult : (BOOL) hasError withErrorMsg : (NSString *) errorMsg withData : (NSDictionary *) data withContext:(id)context{
    NSMutableDictionary *result = [[NSMutableDictionary alloc] initWithCapacity:5];
    [result setObject:[NSNumber numberWithBool:hasError] forKey:ASI_REQUEST_HAS_ERROR];
    if (nil == errorMsg) {
        [result setObject:@"" forKey:ASI_REQUEST_ERROR_MESSAGE];
    }else{
        [result setObject:errorMsg forKey:ASI_REQUEST_ERROR_MESSAGE];
    }
    
    if (nil != data) {
        [result setObject:data forKey:ASI_REQUEST_DATA];
    }
    
    if (nil != context) {
        [result setObject:context forKey:ASI_REQUEST_CONTEXT];
    }
    return [NSDictionary dictionaryWithDictionary:result];
}

-(void) callback : (id) clazz withAction : (SEL) action withResult : (NSDictionary *)result{
    NSString *callbackParameters = NSStringFromSelector(action);
    if (callbackParameters) {
        NSArray *parameters=[callbackParameters componentsSeparatedByString:@":"];
        if ([parameters count] == 2) {
//            objc_msgSend(clazz,action,result);
        }else{
            NSAssert([parameters count] == 2, @"回调函数非法");
        }
    }
}


@end

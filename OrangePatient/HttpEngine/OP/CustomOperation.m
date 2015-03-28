//
//  PalmOperation.m
//  teacher
//
//  Created by singlew on 14-3-7.
//  Copyright (c) 2014年 ws. All rights reserved.
//

#import "CustomOperation.h"
#import "NetWorkService.h"
#import <CommonCrypto/CommonHMAC.h>

typedef enum{
    Http_None,
    Http_Get,
    Http_Post
} HttpType;

@interface CustomOperation ()
@property (nonatomic) HttpType httpType;
@property (nonatomic) NSString *currentTime;
-(void) configRequest;
-(NSString *) getTime;
@end

@implementation CustomOperation

-(CustomOperation *) initCustomOperation{
    self = [super init];
    if (nil != self) {
        self.httpType = Http_None;
        self.currentTime = [self getTime];
    }
    return self;
}

-(CustomOperation *) initCustomOperation:(id)delegate withActon : (SEL) action{
    self = [self initCustomOperation];
    if (self) {
        self.delegate = delegate;
        self.action = action;
    }
    return self;
}

//-(NSString *) GetUserAgent{
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
//    NSString *app_version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//    NSString *udid = @"";
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f) {
//        udid = [OpenUDID value];
//    }else{
//        udid = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
//    }
    //iOS 4.3.1 NaNa/1.0 build 11
//    NSString * userAgent = [NSString stringWithFormat:@"iOS %@ NaNa/%@ build %@",[[UIDevice currentDevice] systemVersion],app_version,app_build];
//    return userAgent;
//}

//ASIHttpRequest Get
-(void)setHttpRequestGetWithUrl:(NSString *)urlStr{
    
    NSURL *url = [NSURL URLWithString:urlStr];
    self.httpType = Http_Get;
    self.request = [HTTPRequest requestWithURL:url];
//    self.request.requestCookies = [[NSMutableArray alloc] initWithObjects:[UIManagement sharedInstance].php, nil];
    [self configRequest];
}

//ASIHttpRequest Post
-(void)setHttpRequestPostWithUrl:(NSString *)urlStr params:(NSDictionary*)params{
    
    NSURL *url = [NSURL URLWithString:urlStr];
    self.httpType = Http_Post;
    self.dataRequest = [FormDataRequest requestWithURL:url];
    for (NSString *key in [params allKeys]) {
        [self.dataRequest setPostValue:[params objectForKey:key] forKey:key];
    }
    [self configRequest];
}


-(void)setHttpRequestPostWithUrl:(NSString *)urlStr params:(NSDictionary*)params files:(NSDictionary*)files{
    
    NSURL *url = [NSURL URLWithString:urlStr];
    self.httpType = Http_Post;
    self.dataRequest = [FormDataRequest requestWithURL:url];
    
    for (NSString *key in [params allKeys]) {
        [self.dataRequest setPostValue:[params objectForKey:key] forKey:key];
    }
    for (NSString *key in [files allKeys]) {
        [self.dataRequest setFile:[files objectForKey:key] forKey:key];
    }
    [self configRequest];
}


-(void)setHttpRequestPostWithUrl:(NSString *)urlStr params:(NSDictionary*)params imgDataDict:(NSDictionary*)filesDict{
    
    NSURL *url = [NSURL URLWithString:urlStr];
    self.httpType = Http_Post;
    self.dataRequest = [FormDataRequest requestWithURL:url];
    [self.dataRequest setPostFormat:ASIMultipartFormDataPostFormat];
    [self.dataRequest addRequestHeader:@"Content-Type" value:@"multipart/form-data"];
    [self.dataRequest setRequestMethod:@"POST"];
    [self.dataRequest setShouldAttemptPersistentConnection:NO];
    for (NSString *key in [params allKeys]) {
        [self.dataRequest setPostValue:[params objectForKey:key] forKey:key];
    }
    for (NSString *key in [filesDict allKeys]) {
        [self.dataRequest setData:[filesDict objectForKey:key] forKey:key];
    }
    [self configRequest];
}

-(NSString *) getTime{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    return [NSString stringWithFormat:@"%.5f",time];
}

-(void) configRequest{
    if(self.httpType == Http_Get){
        [self.request setTimeOutSeconds:TimeOutSeconds];
//        [self.request setUserAgentString:[self GetUserAgent]];
        [self.request setProxyPort:8881];
        [self.request.requestHeaders setObject:@"" forKey:@"api_key"];
        self.request.clazz = self.delegate;
        self.request.clazzAction = self.action;
    }else if (self.httpType == Http_Post){
//        [self.dataRequest setUserAgentString:[self GetUserAgent]];
        [self.dataRequest setTimeOutSeconds:TimeOutSeconds];
        [self.dataRequest.requestHeaders setObject:@"" forKey:@"api_key"];
        [self.dataRequest setProxyPort:8881];
        self.dataRequest.clazz = self.delegate;
        self.dataRequest.clazzAction = self.action;
    }
}

-(void) startAsynchronous{
    if (self.dataRequest){
        [self.dataRequest setDelegate:[NetWorkService sharedInstance]];
        [[NetWorkService sharedInstance] startAsynchronous:self.dataRequest];
    }
    if (self.request) {
        [self.request setDelegate:[NetWorkService sharedInstance]];
        [[NetWorkService sharedInstance] startAsynchronous:self.request];
    }
}

-(void) startSynchronous{
    if (self.dataRequest){
        [self.dataRequest setDelegate:[NetWorkService sharedInstance]];
        [self.dataRequest startSynchronous];
    }
    if (self.request) {
        [self.request setDelegate:[NetWorkService sharedInstance]];
        [self.request startSynchronous];
    }
}

-(NSString *)getToken{
    NSString *token = @"";
    if ([[NSUserDefaults standardUserDefaults] objectForKey:UserDefaults_UserToken]) {
        token = (NSString *) [[NSUserDefaults standardUserDefaults] objectForKey:UserDefaults_UserToken];
    }
    return token;
}

@end

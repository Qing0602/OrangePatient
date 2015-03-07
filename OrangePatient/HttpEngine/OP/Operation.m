//
//  PalmOperation.m
//  teacher
//
//  Created by singlew on 14-3-7.
//  Copyright (c) 2014年 ws. All rights reserved.
//

#import "Operation.h"
#import "NetWorkService.h"
#import <CommonCrypto/CommonHMAC.h>
#import "NetWorkService.h"
#import "UIManagement.h"

typedef enum{
    Http_None,
    Http_Get,
    Http_Post
} HttpType;

@interface Operation ()
@property (nonatomic) HttpType httpType;
@property (nonatomic) NSString *currentTime;
-(void) configRequest;
-(NSString *) configGetRequest : (NSString *) query;
-(NSDictionary *) configParams : (NSDictionary *) params;
-(NSString *) getMD5 : (NSDictionary *)params withAllKeys : (NSArray *) array;
-(NSString *) createMD5 : (NSString *) str;
-(NSString *) getTime;
@end

@implementation Operation

-(Operation *) initOperation{
    self = [super init];
    if (nil != self) {
        self.httpType = Http_None;
        self.currentTime = [self getTime];
        self.signKey = @"wFwlw@.mi1znhga0nFtla@im.ncgo0m";
        self.signFormatString = @"t=%@&sign=%@";
    }
    return self;
}

-(Operation *) initOperation:(id)delegate withActon : (SEL) action{
    self = [self initOperation];
    if (self) {
        self.delegate = delegate;
        self.action = action;
    }
    return self;
}

-(NSString *) GetUserAgent{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    NSString *app_version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//    NSString *udid = @"";
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f) {
//        udid = [OpenUDID value];
//    }else{
//        udid = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
//    }
    //iOS 4.3.1 NaNa/1.0 build 11
    NSString * userAgent = [NSString stringWithFormat:@"iOS %@ NaNa/%@ build %@",[[UIDevice currentDevice] systemVersion],app_version,app_build];
    return userAgent;
}

//ASIHttpRequest Get
-(void)setHttpRequestGetWithUrl:(NSString *)urlStr{
    
    NSURL *url = [NSURL URLWithString:urlStr];
//    NSString *query = [url query];
//    NSString *sign = [self configGetRequest:query];
//    
//    if (nil == query || [query isEqualToString:@""]) {
//        urlStr = [NSString stringWithFormat:@"%@?t=%@&sign=%@",urlStr,self.currentTime,sign];
//    }else{
//        urlStr = [NSString stringWithFormat:@"%@&t=%@&sign=%@",urlStr,self.currentTime,sign];
//    }
//    url = [NSURL URLWithString:urlStr];
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
//    NSDictionary *p = [self configParams:params];
    for (NSString *key in [params allKeys]) {
        [self.dataRequest setPostValue:[params objectForKey:key] forKey:key];
    }
    
    [self configRequest];
}


-(void)setHttpRequestPostWithUrl:(NSString *)urlStr params:(NSDictionary*)params files:(NSDictionary*)files{
    
    NSURL *url = [NSURL URLWithString:urlStr];
    self.httpType = Http_Post;
    self.dataRequest = [FormDataRequest requestWithURL:url];
    NSDictionary *p = [self configParams:params];
    
    for (NSString *key in [p allKeys]) {
        [self.dataRequest setPostValue:[p objectForKey:key] forKey:key];
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
    NSDictionary *p = [self configParams:params];
    for (NSString *key in [p allKeys]) {
        [self.dataRequest setPostValue:[p objectForKey:key] forKey:key];
    }
    for (NSString *key in [filesDict allKeys]) {
        [self.dataRequest setData:[filesDict objectForKey:key] forKey:key];
    }
    [self configRequest];
}

-(NSString *) configGetRequest : (NSString *) query{
    NSMutableDictionary *queryDic = [[NSMutableDictionary alloc] initWithCapacity:5];
    if (nil == query || [query isEqualToString:@""]) {
        
    }else{
        NSArray *querys = [query componentsSeparatedByString:@"&"];
        for (NSString *q in querys) {
            NSArray *array = [q componentsSeparatedByString:@"="];
            if (nil != array && [array count] != 0) {
                NSString *value = [[NSString stringWithFormat:@"%@",array[1]] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [queryDic setValue:value forKey:array[0]];
            }
        }
    }
    NSDictionary *dic = [self configParams:queryDic];
    return [dic objectForKey:@"sign"];
}

-(NSDictionary *) configParams:(NSDictionary *)params{
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:params];
    
    
    NSMutableArray *keys = [[NSMutableArray alloc] initWithArray:[tempDic allKeys]];
    [keys sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
    [keys addObject:@"t"];
    [tempDic setValue:self.currentTime forKey:@"t"];
    NSLock *lock = [[NSLock alloc] init];
    [lock lock];
    NSString *MD5 = [self getMD5:tempDic withAllKeys:keys];
    [lock unlock];
    [tempDic setValue:MD5 forKey:@"sign"];
    return tempDic;
}

-(NSString *) getMD5 : (NSDictionary *)params withAllKeys : (NSArray *) array{
    NSMutableString *str = [[NSMutableString alloc] initWithCapacity:10];
    
    for (NSString *key in array) {
        NSString *object = [NSString stringWithFormat:@"%@",[params objectForKey:key]];
        
        if (object.length > 420) {
            object = [object substringWithRange:NSMakeRange(0,420)];
        }
        
        [str appendString:[NSString stringWithFormat:@"%@",object]];
    }
    [str appendString:self.signKey];
    return [self createMD5:str];
}

-(NSString *) createMD5 : (NSString *) str{
    const char *cStr = [str UTF8String];
	unsigned char result[16];
	CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
	NSString *MD5 = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],result[8], result[9], result[10], result[11],result[12], result[13], result[14], result[15]];
    return MD5;
}

-(NSString *) getTime{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    return [NSString stringWithFormat:@"%.5f",time];
}

-(void) configRequest{
    if(self.httpType == Http_Get){
        [self.request setTimeOutSeconds:TimeOutSeconds];
        [self.request setUserAgentString:[self GetUserAgent]];
//        [self.request.requestHeaders setObject:[NaNaUIManagement sharedInstance].userAccount.seckey forKey:@"seckey"];
        self.request.clazz = self.delegate;
        self.request.clazzAction = self.action;
    }else if (self.httpType == Http_Post){
        [self.dataRequest setUserAgentString:[self GetUserAgent]];
        [self.dataRequest setTimeOutSeconds:TimeOutSeconds];
//        [self.request.requestHeaders setObject:[NaNaUIManagement sharedInstance].userAccount.seckey forKey:@"seckey"];
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

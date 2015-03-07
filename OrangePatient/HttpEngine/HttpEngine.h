//
//  HttpEngine.h
//
//
//  Created by singlew on 14-3-7.
//  Copyright (c) 2014年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONKit.h"
#import "HTTPRequest.h"
#import "FormDataRequest.h"
#import "Operation.h"

@interface HttpEngine : NSObject
// private
@property (nonatomic,strong) NSString *errorMessage;
@property (nonatomic) BOOL hasError;
-(void) sendMsgToAutoShowErrorMessage : (id) clazz withMsg : (NSString *) msg;
-(void) callback : (id) clazz withAction : (SEL) action withResult : (NSDictionary *)result;
-(NSDictionary *) configRequestResult : (BOOL) hasError withErrorMsg : (NSString *) errorMsg withData : (NSDictionary *) data withContext : (id) context;

// public
-(BOOL) canConntected;
-(BOOL) addSTOperation : (HTTPRequest *)op;
-(BOOL) canConnected : (HTTPRequest *) request;
-(void) requestFinished : (HTTPRequest *)request;
-(void) requestFailed : (HTTPRequest *)request;
@end

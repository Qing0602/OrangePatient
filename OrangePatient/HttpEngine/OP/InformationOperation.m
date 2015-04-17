//
//  InformationOperation.m
//  OrangePatient
//
//  Created by singlew on 15/4/15.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "InformationOperation.h"
#import "UIManagement.h"

@interface InformationOperation ()
@property(nonatomic) InforType type;
-(void) getRecent;
-(void) getRecentDetail;
@end

@implementation InformationOperation
-(InformationOperation *) initGetRecent : (NSUInteger) offset withLimit : (NSUInteger) limit{
    self = [self initCustomOperation];
    if (nil != self) {
        self.type = kGetRecent;
        NSString *urlStr = [NSString stringWithFormat:@"%@api/info/recent?start=%lu&limit=%lu&order=DESC",K_HOST_OF_SERVER,offset,limit];
        [self setHttpRequestGetWithUrl:urlStr];
    }
    return self;
}

-(InformationOperation *) initGetRecentDetail : (NSInteger) recentID{
    self = [self initCustomOperation];
    if (nil != self) {
        self.type = kGetRecentDetail;
        NSString *urlStr = [NSString stringWithFormat:@"%@api/info/detail/%lu",K_HOST_OF_SERVER,recentID];
        [self setHttpRequestGetWithUrl:urlStr];
    }
    return self;
}

-(void) getRecent{
    [self.request setRequestCompleted:^(NSDictionary *data){
        dispatch_block_t updateTagBlock = ^{
            [UIManagement sharedInstance].getRecentResult = data;
        };
        dispatch_async(dispatch_get_main_queue(), updateTagBlock);
    }];
    [self startAsynchronous];
}

-(void) getRecentDetail{
    [self.request setRequestCompleted:^(NSDictionary *data){
        dispatch_block_t updateTagBlock = ^{
            [UIManagement sharedInstance].getRecentDetailResult = data;
        };
        dispatch_async(dispatch_get_main_queue(), updateTagBlock);
    }];
    [self startAsynchronous];
}

-(void) main{
    @autoreleasepool {
        switch (self.type) {
            case kGetRecent:
                [self getRecent];
                break;
            case kGetRecentDetail:
                [self getRecentDetail];
                break;
            default:
                break;
        }
    }
}
@end

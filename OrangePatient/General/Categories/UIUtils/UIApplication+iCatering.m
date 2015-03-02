//
//  UIApplication+iCatering.m
//  iCatering
//
//  Created by ZhangQing on 14-3-4.
//  Copyright (c) 2014年 ZhangQing. All rights reserved.
//

#import "UIApplication+iCatering.h"

@implementation UIApplication (iCatering)

@end



@implementation UIApplication (NetworkActivity)

static NSInteger networkOperationCount;

+ (void)startNetworkActivity {
    networkOperationCount++;
    [[UIApplication sharedApplication] updateNetworkActivityIndicator];
}

+ (void)finishNetworkActivity {
    networkOperationCount--;
    [[UIApplication sharedApplication] updateNetworkActivityIndicator];
}

- (void)updateNetworkActivityIndicator {
    [self setNetworkActivityIndicatorVisible:(networkOperationCount > 0 ? TRUE : FALSE)];
}

@end
//
//  UIApplication+iCatering.h
//  iCatering
//
//  Created by ZhangQing on 14-3-4.
//  Copyright (c) 2014年 ZhangQing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (iCatering)

@end

//跟踪你最近进行过的网络操作，并管理NetworkActivityIndicator

@interface UIApplication (NetworkActivity)

+ (void)startNetworkActivity;
+ (void)finishNetworkActivity;

- (void)updateNetworkActivityIndicator;

@end
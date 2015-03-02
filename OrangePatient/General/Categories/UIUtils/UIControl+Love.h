//
//  UIControl+Love.h
//  iLove
//
//  Created by mtf on 12-11-14.
//  Copyright (c) 2012年 www.fanxer.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (blocks)

- (void)handleControlEvents:(UIControlEvents)controlEvents actionBlock:(void(^)(id sender))actionBlock;
- (void)removeHandlerForEvents:(UIControlEvents)controlEvents;

@end

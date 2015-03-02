//
//  BaseUIView.m
//  iLove
//
//  Created by mtf on 12-11-9.
//  Copyright (c) 2012年 www.fanxer.com. All rights reserved.
//

#import "BaseUIView.h"

@implementation BaseUIView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.exclusiveTouch = YES;
    }
    return self;
}

@end

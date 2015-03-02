//
//  BaseUIButton.m
//  iLove
//
//  Created by mtf on 12-11-23.
//  Copyright (c) 2012年 www.fanxer.com. All rights reserved.
//

#import "BaseUIButton.h"

@implementation BaseUIButton

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

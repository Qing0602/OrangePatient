//
//  TextFieldWithLeftIcon.m
//  OrangePatient
//
//  Created by ZhangQing on 3/15/15.
//  Copyright (c) 2015 Orange. All rights reserved.
//

#import "TextFieldWithLeftIcon.h"

@implementation TextFieldWithLeftIcon

- (instancetype)initWithFrame:(CGRect)frame andLeftIcon:(UIImageView *)imageview
{
    self = [super initWithFrame:frame];
    if (self) {
        self.leftView = imageview;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    
    return self;
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 14.f;
    return iconRect;
}

@end

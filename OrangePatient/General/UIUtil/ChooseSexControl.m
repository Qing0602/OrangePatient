//
//  ChooseSexControl.m
//  OrangePatient
//
//  Created by ZhangQing on 3/16/15.
//  Copyright (c) 2015 Orange. All rights reserved.
//


#import "ChooseSexControl.h"


@implementation ChooseSexControl

- (instancetype)initWithOrigin:(CGPoint)point
{
    CGRect viewFrame = CGRectMake(point.x, point.y, Control_Width, Control_Height);
    self = [super initWithFrame:viewFrame];
    if (self) {
        
        CGFloat textAndImageIntervel = 10.f;
        
        _male = [UIButton buttonWithType:UIButtonTypeCustom];
        [_male setFrame:CGRectMake(0.f, 0.f, viewFrame.size.width/2, viewFrame.size.height)];
        _male.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_male setTitle:@"男" forState:UIControlStateNormal];
        [_male setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_male setTitleEdgeInsets:UIEdgeInsetsMake(0.f, 0.f, 0.f, _male.frame.size.width/2-2.f)];
        [_male setImage:[UIImage imageNamed:@"btn_selected"] forState:UIControlStateSelected];
        [_male setImage:[UIImage imageNamed:@"btn_unselected"] forState:UIControlStateNormal];
        [_male setImageEdgeInsets:UIEdgeInsetsMake((viewFrame.size.height-23)/4,  _male.frame.size.width/2+textAndImageIntervel, (viewFrame.size.height-23)/4, 0.f)];
        [_male addTarget:self action:@selector(chooseSex:) forControlEvents:UIControlEventTouchUpInside];
        _male.selected = YES;
        [self addSubview:_male];
        
        _female = [UIButton buttonWithType:UIButtonTypeCustom];
        [_female setFrame:CGRectMake(viewFrame.size.width/2, 0.f, viewFrame.size.width/2, viewFrame.size.height)];
        [_female setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_female setTitle:@"女" forState:UIControlStateNormal];
        [_female setTitleEdgeInsets:UIEdgeInsetsMake(0.f, 0.f, 0.f,  _female.frame.size.width/2-2.f)];
        [_female setImage:[UIImage imageNamed:@"btn_selected"] forState:UIControlStateSelected];
        [_female setImage:[UIImage imageNamed:@"btn_unselected"] forState:UIControlStateNormal];
        [_female setImageEdgeInsets:UIEdgeInsetsMake((viewFrame.size.height-23)/4, _female.frame.size.width/2+textAndImageIntervel, (viewFrame.size.height-23)/4, 0)];
        [_female addTarget:self action:@selector(chooseSex:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_female];
    }
    
    return self;
}

- (void)chooseSex : (UIButton *)btn
{
    if (btn == self.male) {
        self.male.selected = YES;
    }else
    {
        self.male.selected = NO;
    }
    
    self.female.selected = !self.male.selected;
    
    if ([self.delegate respondsToSelector:@selector(sexChoosen:)]) {
        [self.delegate sexChoosen:self.male.selected ? SEX_TYPE_MALE : SEX_TYPE_FEMALE];
    }
}

- (SEX_TYPE)getCurrentChooseSex
{
    return self.male.selected ? SEX_TYPE_MALE : SEX_TYPE_FEMALE;
}


@end

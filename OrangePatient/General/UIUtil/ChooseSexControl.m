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
    CGRect viewFrame = CGRectMake(point.x, point.y, 100.f, 40.f);
    self = [super initWithFrame:viewFrame];
    if (self) {
        _male = [UIButton buttonWithType:UIButtonTypeCustom];
        [_male setFrame:CGRectMake(0.f, 0.f, viewFrame.size.width/2, viewFrame.size.height)];
        [_male setTitle:@"男" forState:UIControlStateNormal];
        [_male setTitleEdgeInsets:UIEdgeInsetsMake(0.f, 1.f, 0.f, 26.f)];
        [_male setImage:[UIImage imageNamed:@"btn_selected"] forState:UIControlStateSelected];
        [_male setImage:[UIImage imageNamed:@"btn_unselected"] forState:UIControlStateNormal];
        [_male setImageEdgeInsets:UIEdgeInsetsMake((viewFrame.size.height-23)/2, 26, (viewFrame.size.height-23)/2, 1)];
        [_male addTarget:self action:@selector(chooseSex:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_male];
        
        _female = [UIButton buttonWithType:UIButtonTypeCustom];
        [_female setFrame:CGRectMake(viewFrame.size.width/2, 0.f, viewFrame.size.width/2, viewFrame.size.height)];
        [_female setTitle:@"女" forState:UIControlStateNormal];
        [_female setTitleEdgeInsets:UIEdgeInsetsMake(0.f, 1.f, 0.f, 26.f)];
        [_female setImage:[UIImage imageNamed:@"btn_selected"] forState:UIControlStateSelected];
        [_female setImage:[UIImage imageNamed:@"btn_unselected"] forState:UIControlStateNormal];
        [_female setImageEdgeInsets:UIEdgeInsetsMake((viewFrame.size.height-23)/2, 26, (viewFrame.size.height-23)/2, 1)];
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

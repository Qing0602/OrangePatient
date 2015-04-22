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
        
        CGFloat textAndImageIntervel = 6.f;
        
        _male = [UIButton buttonWithType:UIButtonTypeCustom];
        //[_male setFrame:CGRectMake(0.f, 0.f, viewFrame.size.width/2, viewFrame.size.height)];
        _male.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_male setTitle:@"男" forState:UIControlStateNormal];
        _male.backgroundColor = [UIColor yellowColor];
        [_male setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_male setTitleEdgeInsets:UIEdgeInsetsMake(0.f, -10.f, 0.f, _male.frame.size.width/2)];
        [_male setImage:[UIImage imageNamed:@"SexControl_Selected"] forState:UIControlStateSelected];
        [_male setImage:[UIImage imageNamed:@"SexControl_Unselected"] forState:UIControlStateNormal];
        [_male setImageEdgeInsets:UIEdgeInsetsMake((viewFrame.size.height-17)/4,  _male.frame.size.width/2+textAndImageIntervel, (viewFrame.size.height-17)/4, 0.f)];
        [_male addTarget:self action:@selector(chooseSex:) forControlEvents:UIControlEventTouchUpInside];
        _male.selected = YES;
        [self addSubview:_male];
        
        _female = [UIButton buttonWithType:UIButtonTypeCustom];
        //[_female setFrame:CGRectMake(viewFrame.size.width/2, 0.f, viewFrame.size.width/2, viewFrame.size.height)];
        [_female setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_female setTitle:@"女" forState:UIControlStateNormal];
        _female.backgroundColor = [UIColor yellowColor];
        [_female setTitleEdgeInsets:UIEdgeInsetsMake(0.f,-10.f, 0.f,  _female.frame.size.width/2)];
        [_female setImage:[UIImage imageNamed:@"btn_selected"] forState:UIControlStateSelected];
        [_female setImage:[UIImage imageNamed:@"btn_unselected"] forState:UIControlStateNormal];
        [_female setImageEdgeInsets:UIEdgeInsetsMake((viewFrame.size.height-17)/4, _female.frame.size.width/2+textAndImageIntervel, (viewFrame.size.height-17)/4, 0)];
        [_female addTarget:self action:@selector(chooseSex:) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:_female];
        
        [_male mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.right.mas_equalTo(Control_Width/2);
        }];
        
        [_female mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(_male.mas_left);
            make.top.equalTo(_male.mas_top);
            make.bottom.equalTo(_male.mas_bottom);
            make.right.mas_equalTo(0);
        }];
    }
    
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _male = [UIButton buttonWithType:UIButtonTypeCustom];
        _male.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_male setTitle:@"男" forState:UIControlStateNormal];
        [_male setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_male setTitleEdgeInsets:UIEdgeInsetsMake(0.f, -20.f, 0.f, Control_Width/4)];
        [_male setImage:[UIImage imageNamed:@"btn_selected"] forState:UIControlStateSelected];
        [_male setImage:[UIImage imageNamed:@"btn_unselected"] forState:UIControlStateNormal];
        [_male setImageEdgeInsets:UIEdgeInsetsMake((Control_Height-23)/4,  Control_Width/4, (Control_Height-23)/4, 0.f)];
        [_male addTarget:self action:@selector(chooseSex:) forControlEvents:UIControlEventTouchUpInside];
        _male.selected = YES;
        [self addSubview:_male];
        
        _female = [UIButton buttonWithType:UIButtonTypeCustom];
        [_female setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_female setTitle:@"女" forState:UIControlStateNormal];
        [_female setTitleEdgeInsets:UIEdgeInsetsMake(0.f,-20.f, 0.f,  Control_Width/4)];
        [_female setImage:[UIImage imageNamed:@"btn_selected"] forState:UIControlStateSelected];
        [_female setImage:[UIImage imageNamed:@"btn_unselected"] forState:UIControlStateNormal];
        [_female setImageEdgeInsets:UIEdgeInsetsMake((Control_Height-23)/4, Control_Width/4, (Control_Height-23)/4, 0)];
        [_female addTarget:self action:@selector(chooseSex:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_female];
        
        [_male mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.right.mas_equalTo(-Control_Width/2);
        }];
        
        [_female mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(_male.mas_right);
            make.top.equalTo(_male.mas_top);
            make.bottom.equalTo(_male.mas_bottom);
            make.right.mas_equalTo(0);
        }];
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

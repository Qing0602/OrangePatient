//
//  ChooseSexControl.h
//  OrangePatient
//
//  Created by ZhangQing on 3/16/15.
//  Copyright (c) 2015 Orange. All rights reserved.
//
#define Control_Height 30.f
#define Control_Width 100.f

#import "BaseUIView.h"

typedef enum
{
    SEX_TYPE_MALE = 1,
    SEX_TYPE_FEMALE = 2
}
SEX_TYPE;

@protocol ChooseSexControlDelegate <NSObject>

- (void)sexChoosen : (SEX_TYPE)sexType;


@end

@interface ChooseSexControl : BaseUIView
//男
@property (nonatomic, strong)UIButton *male;
//女
@property (nonatomic, strong)UIButton *female;

@property (nonatomic, assign)id<ChooseSexControlDelegate> delegate;
- (SEX_TYPE)getCurrentChooseSex;

- (instancetype)initWithOrigin:(CGPoint)point;
@end

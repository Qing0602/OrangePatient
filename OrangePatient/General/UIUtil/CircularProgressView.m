//
//  CircularProgressView.m
//  OrangePatient
//
//  Created by ZhangQing on 15/4/14.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "CircularProgressView.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
@implementation CircularProgressView{
    NSInteger testInter;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        testInter = 0;
        
        UIImageView *rectImageview = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, 275.f, 260.f)];
        [rectImageview setImage:[UIImage imageNamed:@"Report_Chart_BG"]];
        [self addSubview:rectImageview];

        //156,150
        self.needleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(46, 65, 179, 179)];
        [self.needleImageView setImage:[UIImage imageNamed:@"Report_needle"]];
        [self addSubview:self.needleImageView];
        
        self.value = [[UILabel alloc] init];
        self.value.font = [UIFont systemFontOfSize:40];
        self.value.textColor = [UIColor redColor];
        self.value.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.value];
        
        self.valueDesc = [[UILabel alloc] init];
        self.valueDesc.font = [UIFont systemFontOfSize:14];
        self.valueDesc.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.valueDesc];
        
        [self.value mas_makeConstraints:^(MASConstraintMaker *make){
            make.centerX.equalTo(self.needleImageView.mas_centerX);
            make.centerY.equalTo(self.needleImageView.mas_centerY);
            make.width.mas_equalTo(self.needleImageView.frame.size.width);
            make.height.mas_equalTo(40);
        }];
        
        [self.valueDesc mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(self.value.mas_bottom).with.offset(10);
            make.centerX.equalTo(self.value.mas_centerX);
            make.width.equalTo(self.value.mas_width);
            make.height.mas_equalTo(15);
        }];
    }
    return self;
}


- (void)setProgressValue:(NSInteger)value{
    CGFloat progressValue = (value-5)*4.5;

    self.value.text = [NSString stringWithFormat:@"%ld",(long)value];
    self.valueDesc.text = [self getValueDescByValue:value];
    //160 + progressValue*220-270
    //5 - 0度
    //15 -45度
    //30 -112度
    //45 - 180度
    //55 - 225度
    //[NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(test) userInfo:nil repeats:YES];
    CGFloat progressOvalEndAngle = DEGREES_TO_RADIANS(progressValue);
    CGAffineTransform finalTransform = CGAffineTransformMakeRotation(progressOvalEndAngle);
    [self.needleImageView setTransform:finalTransform];
//    [self.theProgressView setProgress:progressValue];
//    [self.theProgressView startAnimation];
}

- (void)test{
    testInter++;
    CGFloat progressOvalEndAngle = DEGREES_TO_RADIANS(testInter);
    CGAffineTransform finalTransform = CGAffineTransformMakeRotation(progressOvalEndAngle);
    [self.needleImageView setTransform:finalTransform];
}

- (NSString *)getValueDescByValue:(NSInteger)tempValue{
    if (5<tempValue && tempValue<15) {
        return @"轻度";
    }else if (tempValue>=15 && tempValue <45){
        return @"中度";
    }else if(tempValue >= 45){
        return @"重度";
    }else{
        return @"健康";
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

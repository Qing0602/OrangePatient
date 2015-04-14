//
//  CircularProgressView.m
//  OrangePatient
//
//  Created by ZhangQing on 15/4/14.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "CircularProgressView.h"


@implementation CircularProgressView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *rectImageview = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, 229.f, 229.f)];
        [rectImageview setImage:[UIImage imageNamed:@"Report_Rect"]];
        [self addSubview:rectImageview];

        //156,150
        self.needleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(36, 26, 156, 150)];
        [self.needleImageView setImage:[UIImage imageNamed:@"Report_needle"]];
        [self addSubview:self.needleImageView];
        
        self.theProgressView = [[MMCircularProgressView alloc] initWithFrame:CGRectMake(4.f, 4.f, 220, 220)];
        self.theProgressView.startAngle = 160;
        self.theProgressView.endAngle = 220;
        [self.theProgressView setInitialProgress:0.f];
        self.theProgressView.displayNeedle = YES;
        self.theProgressView.progressColor = [UIColor orangeColor];
        self.theProgressView.trackColor = [UIColor lightGrayColor];
        self.theProgressView.strokeWidth = 14.f;
        //[self addSubview:self.theProgressView];
        

    }
    return self;
}


- (void)setProgressValue:(NSInteger)value{
    CGFloat progressValue = value/50.f;
    progressValue = 0.f;
    [self.theProgressView setProgress:progressValue];
    [self.theProgressView startAnimation];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

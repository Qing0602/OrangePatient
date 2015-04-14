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
        self.theProgressView = [[MMCircularProgressView alloc] initWithFrame:CGRectMake(0, 0.f, 200, 200)];
        self.theProgressView.startAngle = 160;
        self.theProgressView.endAngle = 220;
        [self.theProgressView setInitialProgress:0.f];
        self.theProgressView.progressColor = [UIColor orangeColor];
        self.theProgressView.trackColor = [UIColor lightGrayColor];
        self.theProgressView.strokeWidth = 20.f;
        [self addSubview:self.theProgressView];
    }
    return self;
}


- (void)setProgressValue:(NSInteger)value{
    CGFloat progressValue = value/50.f;
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

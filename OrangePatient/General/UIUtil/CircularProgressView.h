//
//  CircularProgressView.h
//  OrangePatient
//
//  Created by ZhangQing on 15/4/14.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "BaseUIView.h"
#import "MMCircularProgressView.h"

@interface CircularProgressView : BaseUIView
@property (nonatomic, strong)MMCircularProgressView *theProgressView;

- (void)setProgressValue:(NSInteger)value;
@end

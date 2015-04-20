//
//  CircularProgressView.h
//  OrangePatient
//
//  Created by ZhangQing on 15/4/14.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "BaseUIView.h"

@interface CircularProgressView : BaseUIView
@property (nonatomic, strong)UIImageView *needleImageView;
//value
@property (nonatomic, strong)UILabel *value;
//valueDesc
@property (nonatomic, strong)UILabel *valueDesc;
- (void)setProgressValue:(NSInteger)value;
@end

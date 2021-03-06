//
//  ScreeningCenterInfoVIewController.m
//  OrangePatient
//
//  Created by ZhangQing on 15/4/9.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "ScreeningCenterInfoVIewController.h"

#import "EGOImageView.h"
#import "MyDoctorHospitalsModel.h"
@interface ScreeningCenterInfoVIewController(){
    
}
@property (nonatomic, strong)MyDoctorHospitalsModel *model;

@end
@implementation ScreeningCenterInfoVIewController

- (instancetype)initWithModel:(MyDoctorHospitalsModel *)tempModel{
    self = [super init];
    if (self) {
        _model = tempModel;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [self createNavRightButton:kCustomNavRightTypeSearchIcon withSEL:@selector(searchHospital)];
    
    UIScrollView *contentScrollview = [[UIScrollView alloc] init];
    contentScrollview.showsVerticalScrollIndicator = NO;
    contentScrollview.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:contentScrollview];
    
    //筛查点照片
    EGOImageView *imageview = [[EGOImageView alloc] init];
    [imageview setImageURL:[NSURL URLWithString:self.model.hospitalLogoUrl]];
    imageview.backgroundColor = [UIColor redColor];
    [contentScrollview addSubview:imageview];
    //介绍
    UILabel *introduceTitleLabel = [[UILabel alloc] init];
    introduceTitleLabel.font = [UIFont systemFontOfSize:20.f];
    introduceTitleLabel.text = @"介绍:";
    [contentScrollview addSubview:introduceTitleLabel];
    
    UILabel *centerIntroduce = [[UILabel alloc] init];
    centerIntroduce.backgroundColor = [UIColor yellowColor];
    centerIntroduce.numberOfLines = 0;
    centerIntroduce.font = [UIFont systemFontOfSize:12.f];
    centerIntroduce.textColor = [UIColor lightGrayColor];
    centerIntroduce.text = self.model.hospitalContent;
    [contentScrollview addSubview:centerIntroduce];
    
    //line
    UIImageView *line = [[UIImageView alloc] init];
    line.backgroundColor = [UIColor lightGrayColor];
    [contentScrollview addSubview:line];
    
    //地址
    UILabel *centerAddress = [[UILabel alloc] init];
    centerAddress.font = [UIFont systemFontOfSize:12.f];
    centerAddress.text = [NSString stringWithFormat:@"地址:%@",self.model.hospitalAddress];
    [contentScrollview addSubview:centerAddress];
    //咨询电话
    UILabel *centerPhoneNum = [[UILabel alloc] init];
    centerPhoneNum.font = [UIFont systemFontOfSize:12.f];
    centerPhoneNum.text = [NSString stringWithFormat:@"咨询电话:%@",self.model.hospitalPhone];
    [contentScrollview addSubview:centerPhoneNum];
    
    const CGFloat itemOffset = 15.f;
    
    [contentScrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [imageview mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(SCREEN_WIDTH/2);
    }];
    
    [introduceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(10);
        make.top.equalTo(imageview.mas_bottom).with.offset(itemOffset);
        make.right.mas_equalTo(-100);
        make.height.mas_equalTo(22);
    }];
    
    [centerIntroduce mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.mas_equalTo(SCREEN_WIDTH-20);
        make.left.equalTo(introduceTitleLabel.mas_left);
        make.top.equalTo(introduceTitleLabel.mas_bottom);
        //make.right.mas_equalTo(-10);
        make.height.mas_equalTo([centerIntroduce boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, 0)].height);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(0);
        //make.right.mas_equalTo(0);
        make.width.mas_equalTo(contentScrollview.mas_width);
        make.top.equalTo(centerIntroduce.mas_bottom).with.offset(itemOffset);
        make.height.mas_equalTo(1);
    }];
    
    [centerAddress mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(introduceTitleLabel.mas_left);
        make.width.mas_equalTo(contentScrollview.mas_width);
        make.top.equalTo(line.mas_bottom).with.offset(itemOffset);
        make.height.mas_equalTo(20);
    }];
    
    [centerPhoneNum mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(introduceTitleLabel.mas_left);
        make.width.mas_equalTo(contentScrollview.mas_width);
        make.top.equalTo(centerAddress.mas_bottom).with.offset(itemOffset);
        make.height.mas_equalTo(20);
    }];
    
}

- (void)searchHospital{
    
}
@end

//
//  HealthInfoDetailViewController.m
//  OrangePatient
//
//  Created by ZhangQing on 15/4/20.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "HealthInfoDetailViewController.h"

@interface HealthInfoDetailViewController ()<UIWebViewDelegate>
@property (nonatomic, strong)UIWebView *detailWebview;
@property (nonatomic, strong)HealthInfomationModel *model;
@end

@implementation HealthInfoDetailViewController

- (instancetype)initWithInfoModel:(HealthInfomationModel *)infoModel{
    self = [super init];
    if (self) {
        self.model = infoModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"健康咨询";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *title = [[UILabel alloc] init];
    title.font = [UIFont systemFontOfSize:16.f];
    title.text = self.model.infoTitle;
    [self.view addSubview:title];
    
    UILabel *date = [[UILabel alloc] init];
    date.text = [[NSDate dateWithTimeIntervalSince1970:self.model.infoPublishTime] stringDate];
    date.font = [UIFont systemFontOfSize:12.f];
    [self.view addSubview:date];
    
    _detailWebview = [[UIWebView alloc] init];
    [_detailWebview loadHTMLString:self.model.infoContent baseURL:nil];
    [self.view addSubview:_detailWebview];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.and.top.mas_equalTo(5);
        make.right.mas_equalTo(-5);
        make.height.mas_equalTo(16);
    }];
    
    [date mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(title.mas_left);
        make.right.equalTo(title.mas_right);
        make.top.equalTo(title.mas_bottom).with.offset(4);
        make.height.mas_equalTo(14);
    }];
    
    [_detailWebview mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(title.mas_left);
        make.right.equalTo(title.mas_right);
        make.top.equalTo(date.mas_bottom).with.offset(4);
        make.bottom.mas_equalTo(-40);
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

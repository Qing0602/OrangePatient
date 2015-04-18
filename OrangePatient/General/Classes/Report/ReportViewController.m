//
//  ReportViewController.m
//  OrangePatient
//
//  Created by ZhangQing on 15/4/10.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "ReportViewController.h"

#import "CircularProgressView.h"
@interface ReportViewController ()
@property (nonatomic, strong)CircularProgressView *progressView;
@end

@implementation ReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _progressView = [[CircularProgressView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-300)/2, 30, 300.f, 200.f)];
    [self.view addSubview:_progressView];
    
    UILabel *valueTitle = [[UILabel alloc] init];
    valueTitle.text = @"氧减饱和度指数";
    [self.view addSubview:valueTitle];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [self.progressView setProgressValue:30];
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

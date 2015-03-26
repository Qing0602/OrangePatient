//
//  MyDoctorViewController.m
//  OrangePatient
//
//  Created by ZhangQing on 15/3/23.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#define LOGO_WIDTH 180.f

#import "MyDoctorViewController.h"

@interface MyDoctorViewController ()

@end

@implementation MyDoctorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的医生";
    
    UIImageView *logo = [[UIImageView alloc] init];
    logo.translatesAutoresizingMaskIntoConstraints = NO;
    //[logo setFrame:CGRectMake(SCREEN_WIDTH-LOGO_WIDTH, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)]
    //[logo setImage:[UIImage imageNamed:@"MyDoctor_Logo"] forState:UIControlStateNormal];
//    logo.layer.borderWidth = 2.f;
//    logo.layer.borderColor = [UIColor orangeColor].CGColor;
//    logo.layer.masksToBounds = YES;
//    logo.layer.cornerRadius = 10.f;
    logo.backgroundColor = [UIColor redColor];
    [self.view addSubview:logo];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.font = [UIFont systemFontOfSize:16.f];
    tipLabel.textColor = [UIColor grayColor];
    tipLabel.translatesAutoresizingMaskIntoConstraints = NO;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.text = @"欢迎您使用橙意客户端";
    [self.view addSubview:tipLabel];
    
    UIButton *addMyDoctorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addMyDoctorBtn.translatesAutoresizingMaskIntoConstraints = NO;
    addMyDoctorBtn.backgroundColor   = [UIColor greenColor];
    [addMyDoctorBtn setTitle:@"添加我的医生" forState:UIControlStateNormal];
    RACSignal *btnTap = [addMyDoctorBtn rac_signalForControlEvents:UIControlEventTouchUpInside];
    [btnTap subscribeNext:^(UIButton *sender){
    
    }];
    [self.view addSubview:addMyDoctorBtn];
    
    NSDictionary *views = @{@"topLayoutGuide":self.topLayoutGuide,@"logo":logo,@"tipLabel":tipLabel,@"addMyDoctorBtn":addMyDoctorBtn};
    NSDictionary *metrics = @{@"btnWidth":@(SCREEN_WIDTH/2),@"labelWidth":@(SCREEN_WIDTH/2+40)};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[logo(btnWidth)]" options:0 metrics:metrics views:views]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:logo attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[tipLabel(labelWidth)]" options:0 metrics:metrics views:views]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:tipLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[addMyDoctorBtn(tipLabel)]" options:0 metrics:metrics views:views]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:addMyDoctorBtn attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide]->=100@1000-[logo(btnWidth)]-16-[tipLabel(20)]-28-[addMyDoctorBtn(40)]->=100-|" options:0 metrics:metrics views:views]];
    
    
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

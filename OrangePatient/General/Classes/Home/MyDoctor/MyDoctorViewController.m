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
    
    UIButton *logo = [UIButton buttonWithType:UIButtonTypeCustom];
    //[logo setFrame:CGRectMake(SCREEN_WIDTH-LOGO_WIDTH, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)]
    [logo setImage:[UIImage imageNamed:@"MyDoctor_Logo"] forState:UIControlStateNormal];
    logo.layer.borderWidth = 2.f;
    logo.layer.borderColor = [UIColor orangeColor].CGColor;
    logo.layer.masksToBounds = YES;
    logo.layer.cornerRadius = 10.f;
    [self.view addSubview:logo];
    
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

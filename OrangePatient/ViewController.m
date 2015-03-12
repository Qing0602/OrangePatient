//
//  ViewController.m
//  OrangePatient
//
//  Created by ZhangQing on 2/26/15.
//  Copyright (c) 2015 Orange. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
#import "SearchBlueToothViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton *login = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [login setFrame:CGRectMake(110.f, 100.f, 100.f, 40.f)];
    [login setTitle:@"登陆" forState:UIControlStateNormal];
    [login addTarget:self action:@selector(loginPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:login];
    
    UIButton *blueTooth = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [blueTooth setFrame:CGRectMake(110.f, 200.f, 100.f, 40.f)];
    [blueTooth setTitle:@"蓝牙" forState:UIControlStateNormal];
    [blueTooth addTarget:self action:@selector(blueTooth) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:blueTooth];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)loginPage
{
    LoginViewController *login = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:login animated:YES];
}

- (void)blueTooth
{
    SearchBlueToothViewController *blueTooth = [[SearchBlueToothViewController alloc] init];
    [self.navigationController pushViewController:blueTooth animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

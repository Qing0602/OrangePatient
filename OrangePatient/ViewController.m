//
//  ViewController.m
//  OrangePatient
//
//  Created by ZhangQing on 2/26/15.
//  Copyright (c) 2015 Orange. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
#import "HomeViewController.h"
#import "MyDoctorListViewController.h"
#import "SendProblemToDoctorViewController.h"
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
    [blueTooth setFrame:CGRectMake(110.f, 160.f, 100.f, 40.f)];
    [blueTooth setTitle:@"首页" forState:UIControlStateNormal];
    [blueTooth addTarget:self action:@selector(blueTooth) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:blueTooth];
    
    UIButton *myDoctorList = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [myDoctorList setFrame:CGRectMake(110.f, 240.f, 100.f, 40.f)];
    [myDoctorList setTitle:@"我的医生列表" forState:UIControlStateNormal];
    [myDoctorList addTarget:self action:@selector(myDoctorListPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myDoctorList];
    
    UIButton *sendProblem = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [sendProblem setFrame:CGRectMake(110.f, 240.f, 100.f, 40.f)];
    [sendProblem setTitle:@"问题描述" forState:UIControlStateNormal];
    [sendProblem addTarget:self action:@selector(sendProblemPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendProblem];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)loginPage
{
    LoginViewController *login = [[LoginViewController alloc] init];
    login.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:login animated:YES];
}

- (void)blueTooth
{
    HomeViewController *blueTooth = [[HomeViewController alloc] init];
    [self.navigationController pushViewController:blueTooth animated:YES];
}

- (void)myDoctorListPage
{
    MyDoctorListViewController *myDoctorList = [[MyDoctorListViewController alloc] init];
    myDoctorList.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myDoctorList animated:YES];
}

- (void)sendProblemPage{
    SendProblemToDoctorViewController *sendProblem = [[SendProblemToDoctorViewController alloc] init];
    sendProblem.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sendProblem animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

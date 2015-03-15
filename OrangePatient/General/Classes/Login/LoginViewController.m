//
//  LoginViewController.m
//  OrangePatient
//
//  Created by ZhangQing on 3/10/15.
//  Copyright (c) 2015 Orange. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController ()

@property (nonatomic, strong)UITextField *username;
@property (nonatomic, strong)UITextField *pwd;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = LOGIN_PAGE_TITLE;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:LOGIN_PAGE_TEXT_REGISTER style:UIBarButtonItemStyleDone target:self action:@selector(registerAccount)];
    
    
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-522/3)/2, 50.f, 522/3, 528/3)];
    [logo setImage:[UIImage imageNamed:@"Login_Logo"]];
    [self.view addSubview:logo];
    
    _username = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-Login_TextField_Widht)/2, CGRectGetMaxY(logo.frame)+30.f, Login_TextField_Widht, Login_TextField_Height)];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)registerAccount
{
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
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

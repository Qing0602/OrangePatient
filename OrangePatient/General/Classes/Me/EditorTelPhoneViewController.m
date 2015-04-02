//
//  EditorTelPhoneViewController.m
//  OrangePatient
//
//  Created by singlew on 15/4/2.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "EditorTelPhoneViewController.h"

@interface EditorTelPhoneViewController ()
@property (nonatomic,strong) UITextField *userTelPhone;
-(void) save;
@end

@implementation EditorTelPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userTelPhone = [[UITextField alloc] init];
    self.userTelPhone.translatesAutoresizingMaskIntoConstraints = NO;
    self.userTelPhone.borderStyle = UITextBorderStyleNone;
    self.userTelPhone.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.userTelPhone];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_userTelPhone);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_userTelPhone]-0-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_userTelPhone(30)]" options:0 metrics:nil views:views]];
}

-(void) save{
    NSString *telPhone = self.userTelPhone.text;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeTelPhone" object:telPhone];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

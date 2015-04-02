//
//  EditorNickNameViewController.m
//  OrangePatient
//
//  Created by singlew on 15/4/2.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "EditorNickNameViewController.h"

@interface EditorNickNameViewController ()
@property (nonatomic,strong) UITextField *userNickName;
-(void) save;
@end

@implementation EditorNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userNickName = [[UITextField alloc] init];
    self.userNickName.translatesAutoresizingMaskIntoConstraints = NO;
    self.userNickName.borderStyle = UITextBorderStyleNone;
    self.userNickName.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.userNickName];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_userNickName);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_userNickName]-0-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_userNickName(30)]" options:0 metrics:nil views:views]];
}

-(void) save{
    NSString *nickName = self.userNickName.text;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeNickName" object:nickName];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

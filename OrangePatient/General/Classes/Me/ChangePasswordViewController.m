//
//  ChangePasswordViewController.m
//  OrangePatient
//
//  Created by singlew on 15/4/2.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()
@property (nonatomic,strong) UILabel *oldPsLabel;
@property (nonatomic,strong) UITextField *oldPsField;
@property (nonatomic,strong) UILabel *resetPsLabel;
@property (nonatomic,strong) UITextField *resetPsField;
@property (nonatomic,strong) UILabel *confirmPsLabel;
@property (nonatomic,strong) UITextField *confirmPsField;
@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.oldPsLabel = [[UILabel alloc] init];
    self.oldPsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.oldPsLabel.font = [UIFont systemFontOfSize:14.0f];
    self.oldPsLabel.text = @"输入原始密码";
    [self.view addSubview:self.oldPsLabel];
    
    self.oldPsField = [[UITextField alloc] init];
    self.oldPsField.translatesAutoresizingMaskIntoConstraints = NO;
    self.oldPsField.backgroundColor = [UIColor whiteColor];
    self.oldPsField.borderStyle = UITextBorderStyleRoundedRect;
    self.oldPsField.secureTextEntry = YES;
    [self.view addSubview:self.oldPsField];
    
    self.resetPsLabel = [[UILabel alloc] init];
    self.resetPsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.resetPsLabel.font = [UIFont systemFontOfSize:14.0f];
    self.resetPsLabel.text = @"输入新密码";
    [self.view addSubview:self.resetPsLabel];
    
    self.resetPsField = [[UITextField alloc] init];
    self.resetPsField.translatesAutoresizingMaskIntoConstraints = NO;
    self.resetPsField.backgroundColor = [UIColor whiteColor];
    self.resetPsField.borderStyle = UITextBorderStyleRoundedRect;
    self.resetPsField.secureTextEntry = YES;
    [self.view addSubview:self.resetPsField];
    
    self.confirmPsLabel = [[UILabel alloc] init];
    self.confirmPsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.confirmPsLabel.font = [UIFont systemFontOfSize:14.0f];;
    self.confirmPsLabel.text = @"再次输入新密码";
    [self.view addSubview:self.confirmPsLabel];
    
    self.confirmPsField = [[UITextField alloc] init];
    self.confirmPsField.translatesAutoresizingMaskIntoConstraints = NO;
    self.confirmPsField.backgroundColor = [UIColor whiteColor];
    self.confirmPsField.borderStyle = UITextBorderStyleRoundedRect;
    self.confirmPsField.secureTextEntry = YES;
    [self.view addSubview:self.confirmPsField];

    NSDictionary *views = @{@"topLayoutGuide":self.topLayoutGuide,@"oldPsLabel":self.oldPsLabel,@"oldPsField":self.oldPsField,
                            @"resetPsLabel":self.resetPsLabel,@"resetPsField":self.resetPsField,@"confirmPsLabel":self.confirmPsLabel,
                            @"confirmPsField":self.confirmPsField};
//    NSDictionary *views = NSDictionaryOfVariableBindings(_topLayoutGuide,_oldPsLabel,_oldPsField,_resetPsLabel,_resetPsField,_confirmPsLabel,_confirmPsField);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[oldPsLabel]-20-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[oldPsField]-20-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[resetPsLabel]-20-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[resetPsField]-20-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[confirmPsLabel]-20-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[confirmPsField]-20-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide]-15-[oldPsLabel(20)]-10-[oldPsField(26)]-10-[resetPsLabel(20)]-10-[resetPsField(26)]-10-[confirmPsLabel(20)]-10-[confirmPsField(26)]" options:0 metrics:nil views:views]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

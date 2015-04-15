//
//  ChangePasswordViewController.m
//  OrangePatient
//
//  Created by singlew on 15/4/2.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "UIManagement.h"

@interface ChangePasswordViewController ()
@property (nonatomic,strong) UILabel *oldPsLabel;
@property (nonatomic,strong) UITextField *oldPsField;
@property (nonatomic,strong) UILabel *resetPsLabel;
@property (nonatomic,strong) UITextField *resetPsField;
@property (nonatomic,strong) UILabel *confirmPsLabel;
@property (nonatomic,strong) UITextField *confirmPsField;

-(void) submitNewPassword;
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

    UIButton *submit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    submit.translatesAutoresizingMaskIntoConstraints = NO;
    [submit setTitle:@"提交" forState:UIControlStateNormal];
    [submit.layer setMasksToBounds:YES];
    [submit.layer setCornerRadius:5.0];
    [submit.layer setBorderWidth:1.0];
    [submit.layer setBorderColor:[UIColor grayColor].CGColor];
    submit.backgroundColor = [UIColor whiteColor];
    [submit addTarget:self action:@selector(submitNewPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submit];
    
    NSDictionary *views = @{@"topLayoutGuide":self.topLayoutGuide,@"oldPsLabel":self.oldPsLabel,@"oldPsField":self.oldPsField,
                            @"resetPsLabel":self.resetPsLabel,@"resetPsField":self.resetPsField,@"confirmPsLabel":self.confirmPsLabel,
                            @"confirmPsField":self.confirmPsField,@"submit":submit};
//    NSDictionary *views = NSDictionaryOfVariableBindings(_topLayoutGuide,_oldPsLabel,_oldPsField,_resetPsLabel,_resetPsField,_confirmPsLabel,_confirmPsField);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[oldPsLabel]-20-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[oldPsField]-20-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[resetPsLabel]-20-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[resetPsField]-20-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[confirmPsLabel]-20-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[confirmPsField]-20-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-100-[submit]-100-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide]-15-[oldPsLabel(20)]-10-[oldPsField(26)]-10-[resetPsLabel(20)]-10-[resetPsField(26)]-10-[confirmPsLabel(20)]-10-[confirmPsField(26)]-30-[submit(26)]" options:0 metrics:nil views:views]];
    
    [[UIManagement sharedInstance] addObserver:self forKeyPath:@"updateUserDetailResult" options:0 context:nil
     ];}

-(void) submitNewPassword{
    if (self.oldPsField.text == nil || [self.oldPsField.text isEqualToString:@""]) {
        [self showProgressWithText:@"请输入原始密码" withDelayTime:2.0f];
        return;
    }
    
    NSString *resetPs = self.resetPsField.text;
    if (resetPs == nil || [resetPs isEqualToString:@""]) {
        [self showProgressWithText:@"请输入新密码" withDelayTime:2.0f];
        return;
    }
    
    NSString *confirmPs = self.confirmPsField.text;
    if (confirmPs == nil || [confirmPs isEqualToString:@""]) {
        [self showProgressWithText:@"请再次输入新密码" withDelayTime:2.0f];
        return;
    }
    
    if (![resetPs isEqualToString:confirmPs]) {
        [self showProgressWithText:@"输入的新密码不匹配" withDelayTime:2.0f];
        return;
    }
    NSDictionary *json = @{@"password":self.oldPsField.text,@"newpassword":confirmPs};
    [[UIManagement sharedInstance] updateUserDetail:[UIManagement sharedInstance].userAccount.userUid withBody:json];
}

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"updateUserDetailResult"]) {
        if ([[UIManagement sharedInstance].updateUserDetailResult[ASI_REQUEST_HAS_ERROR] boolValue] == YES) {
            [self showProgressWithText:[UIManagement sharedInstance].updateUserDetailResult[ASI_REQUEST_ERROR_MESSAGE] withDelayTime:3.0f];
        }else{
            [self showProgressWithText:@"密码修改成功" withDelayTime:2.0f];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc{
    [[UIManagement sharedInstance] removeObserver:self forKeyPath:@"updateUserDetailResult"];
}

@end

//
//  LoginViewController.m
//  OrangePatient
//
//  Created by ZhangQing on 3/10/15.
//  Copyright (c) 2015 Orange. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "TextFieldWithLeftIcon.h"

#import "UIManagement.h"
@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong)TextFieldWithLeftIcon *username;
@property (nonatomic, strong)TextFieldWithLeftIcon *pwd;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = LOGIN_PAGE_TITLE;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:LOGIN_PAGE_TEXT_REGISTER style:UIBarButtonItemStyleDone target:self action:@selector(registerAccount)];
    
    
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-522/3)/2, 30.f, 522/3, 528/3)];
    [logo setImage:[UIImage imageNamed:@"Login_Logo"]];
    [self.view addSubview:logo];
    
    UIImageView *usernameIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, 18.f, 18.f)];
    [usernameIcon setImage:[UIImage imageNamed:@"Login_userName_icon"]];
    
    _username = [[TextFieldWithLeftIcon alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-Login_TextField_Widht)/2, CGRectGetMaxY(logo.frame)+30.f, Login_TextField_Widht, Login_TextField_Height)
                                                 andLeftIcon:usernameIcon];
    _username.delegate = self;
    _username.returnKeyType = UIReturnKeyNext;
    _username.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_username];
    
    UIImageView *pwdIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, 18.f, 18.f)];
    [pwdIcon setImage:[UIImage imageNamed:@"Login_password_icon"]];
    
    _pwd = [[TextFieldWithLeftIcon alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-Login_TextField_Widht)/2, CGRectGetMaxY(_username.frame)+16.f, Login_TextField_Widht, Login_TextField_Height)
                                                 andLeftIcon:pwdIcon];
    _pwd.delegate = self;
    _pwd.secureTextEntry = YES;
    _pwd.returnKeyType = UIReturnKeySend;
    _pwd.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_pwd];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setFrame:CGRectMake(CGRectGetMinX(_pwd.frame), CGRectGetMaxY(_pwd.frame)+26.f, CGRectGetWidth(_pwd.frame), 30.f)];
    //loginBtn.backgroundColor = [UIColor colorWithRed:85/255.f green:194/255.f blue:43/255.f alpha:1.f];
    [loginBtn setTitle:LOGIN_PAGE_LOGIN_BTN_TITLE forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    RAC(loginBtn,backgroundColor) = [RACSignal combineLatest:@[
                                                               self.username.rac_textSignal,
                                                               self.pwd.rac_textSignal] reduce:^(NSString *username,NSString *pwd){
                                                                   return (username.length > 5 && pwd.length > 5)?
                                                                   [UIColor colorWithRed:85/255.f green:194/255.f blue:43/255.f alpha:1.f]:
                                                                   [UIColor grayColor];
                                                               }];
    RAC(loginBtn,enabled) = [RACSignal combineLatest:@[
                                                               self.username.rac_textSignal,
                                                               self.pwd.rac_textSignal] reduce:^(NSString *username,NSString *pwd){
                                                                   return @(username.length > 5 && pwd.length > 5);
                                                               }];
    
    [RACObserve([UIManagement sharedInstance], loginResult) subscribeNext:^(NSDictionary *loginResult){
        if (loginResult) {
            if (![loginResult[ASI_REQUEST_HAS_ERROR] boolValue]) {
                [self closeProgress];
                NSDictionary *data = loginResult[ASI_REQUEST_DATA];
                UserAccountModel *userAccount = [[UserAccountModel alloc] init];
                userAccount.userUid = data[@"uid"];
                userAccount.userOid = data[@"oid"];
                userAccount.userOauthToken = data[@"oauth_token"];
                userAccount.userOauthTokenSecret = data[@"oauth_token_secret"];
                userAccount.uservalidTime = [data[@"validtime"] integerValue];
                userAccount.userNickName = data[@"nickname"];
                userAccount.userEmail = data[@"email"];
                userAccount.userAvatar = data[@"avatar"];
                userAccount.userMobile = data[@"mobile"];
                userAccount.userImUserName = data[@"im_username"];
                userAccount.userImPassword = data[@"im_password"];
                userAccount.userImNickName = data[@"im_nickname"];
                userAccount.userStatus = [data[@"status"] integerValue];
                [UIManagement sharedInstance].userAccount = userAccount;
                [[NSUserDefaults standardUserDefaults] setObject:userAccount.userUid forKey:@"userUid"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [UIModelCoding serializeModel:userAccount withFileName:SerializeUserAccountModelName];
            }else{
                [self showProgressWithText:loginResult[ASI_REQUEST_ERROR_MESSAGE] withDelayTime:2.f];
            }
        }
    }];
    
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

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self closeKeyboard];
}

- (void)openKeyboard
{
    [UIView animateWithDuration:0.5 animations:^{
        CGFloat pwdOffset = CGRectGetMaxY(_pwd.frame)+50.f - (SCREEN_HEIGHT-KeyBoardHeight-64);
        if (pwdOffset > 0) {
            CGRect viewFrame = self.view.frame;
            viewFrame.origin.y =  -pwdOffset;
            self.view.frame = viewFrame;
        }

    }];
}

- (void)closeKeyboard
{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect viewFrame = self.view.frame;
        viewFrame.origin.y = 64;
        self.view.frame = viewFrame;
        if ([_username isFirstResponder]) {
            [_username resignFirstResponder];
        }else
        {
            [_pwd resignFirstResponder];
        }
    }];
}
#pragma mark - UITextFiled
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (![_username isFirstResponder] && ![_pwd  isFirstResponder]) {
        [self openKeyboard];
    }
    
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([_username isFirstResponder]) {
        [_pwd becomeFirstResponder];
        return NO;
    }else
    {
        [self closeKeyboard];
        [self login];
        return YES;
    }
}

#pragma mark - NetWork
- (void)login
{
    [self showProgressWithText:@"正在登录"];
    [[UIManagement sharedInstance] login:_username.text withPassword:_pwd.text];
    
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

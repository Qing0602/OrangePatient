//
//  RegisterViewController.m
//  OrangePatient
//
//  Created by ZhangQing on 3/11/15.
//  Copyright (c) 2015 Orange. All rights reserved.
//

#define RegisterBtn_Width 258

#import "RegisterViewController.h"
#import "ChooseSexControl.h"

#import "UIManagement.h"
#import <QuartzCore/QuartzCore.h>
@interface RegisterViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic)NSUInteger smsTime;
@property (nonatomic, strong)UIButton *registerBtn;
@property (nonatomic, strong)UIView *pickerSuperView;
//选择性别
@property (nonatomic, strong)ChooseSexControl *sexControl;
//出生日期显示
@property (nonatomic, strong)UILabel *birthdayDate;
//日期选择picker
@property (nonatomic, strong)UIDatePicker *birthdayDatePicker;
//选择生日
@property (nonatomic, strong)UIButton *chooseBirthdayDate;
//手机号码输入框
@property (nonatomic, strong)UITextField *phoneNumInput;
//姓名输入框
@property (nonatomic, strong)UITextField *usernameInput;
//获取验证码
@property (nonatomic, strong)UIButton *getVeriCode;
//验证码输入框
@property (nonatomic, strong)UITextField *veriCodeInput;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = REGISTER_PAGE_TITLE;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:REGISTER_PAGE_TEXT_LOGIN style:UIBarButtonItemStyleDone target:self action:@selector(backToLogin)];
    
    UITableView *registerTable = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH, Register_TableviewCell_Height*4) style:UITableViewStylePlain];
    registerTable.delegate = self;
    registerTable.dataSource = self;
    registerTable.scrollEnabled = NO;
    //registerTable.separatorInset = UIEdgeInsetsMake(0.f, 0.f, 0.f, 0.f);
    registerTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:registerTable];
    
    UILabel *registerTip = [[UILabel alloc] initWithFrame:CGRectMake(10.f, CGRectGetMaxY(registerTable.frame)+14.f, SCREEN_WIDTH-20.f, 20.f)];
    registerTip.font = [UIFont systemFontOfSize:12.f];
    registerTip.textColor = [UIColor lightGrayColor];
    registerTip.textAlignment = NSTextAlignmentCenter;
    registerTip.text = REGISTER_PAGE_TIP;
    [self.view addSubview:registerTip];
    
    _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_registerBtn setFrame:CGRectMake((SCREEN_WIDTH-RegisterBtn_Width)/2, CGRectGetMaxY(registerTip.frame)+14.f, RegisterBtn_Width, 30.f)];
    [_registerBtn setBackgroundImage:[UIImage imageNamed:@"Register_Btn_BG"] forState:UIControlStateNormal];
    //_registerBtn.backgroundColor = [UIColor colorWithRed:227/255.f green:75/255.f blue:45/255.f alpha:1.f];
    [_registerBtn setTitle:REGISTER_PAGE_REGISTER_BTN_TITLE forState:UIControlStateNormal];
    [_registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registerBtn];
    

    
    self.pickerSuperView = [[UIView alloc] initWithFrame:CGRectMake(0.f, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.pickerSuperView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    [self.view addSubview:self.pickerSuperView];
    
    UITapGestureRecognizer *tapPickerSuperView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerSuperViewTapped)];
    [self.pickerSuperView addGestureRecognizer:tapPickerSuperView];
    
    self.birthdayDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.f, SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
    [self.birthdayDatePicker setMinimumDate:[NSDate dateWithString:BIRTHDAY_MINIMUM_DATE]];
    [self.birthdayDatePicker setMaximumDate:[NSDate date]];
    self.birthdayDatePicker.datePickerMode = UIDatePickerModeDate;
    RACSignal *pickerChoosen = [self.birthdayDatePicker rac_signalForControlEvents:UIControlEventValueChanged];
    [pickerChoosen subscribeNext:^(UIDatePicker *picker){
        self.birthdayDate.text = [NSString stringFromDate:picker.date];
    }];
    [self.pickerSuperView addSubview:self.birthdayDatePicker];
    
    [RACObserve([UIManagement sharedInstance], regsiterResult) subscribeNext:^(NSDictionary *registerResult){
        if (registerResult) {
            if (![registerResult[ASI_REQUEST_HAS_ERROR] boolValue]) {
                [self showProgressWithText:@"注册成功" withDelayTime:2.0f];
                NSDictionary *data = registerResult[ASI_REQUEST_DATA];
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
                [self showProgressWithText:registerResult[ASI_REQUEST_ERROR_MESSAGE] withDelayTime:3.f];
            }
        }
    }];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    RAC(self.registerBtn,enabled) = [RACSignal combineLatest:@[
                                                                       self.usernameInput.rac_textSignal,
                                                                       self.veriCodeInput.rac_textSignal,
                                                                       RACObserve(self, birthdayDate)] reduce:^(NSString *username,NSString *veriCode,UILabel *date){
                                                                           return @(username.length>0&&veriCode.length==6&&date.text.length >0);
                                                                       }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ViewControllerMethod
- (void)backToLogin
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)registerAction
{
    [self showProgressWithText:@"正在注册..."];
    [[UIManagement sharedInstance] regsiter:self.phoneNumInput.text withPassword:[self.phoneNumInput.text substringFromIndex:[self.phoneNumInput.text length]-6] withName:self.usernameInput.text withSex:[self.sexControl getCurrentChooseSex] withBirthday:self.birthdayDate.text withVerifyCode:self.veriCodeInput.text];
}

- (void)pickerSuperViewTapped
{
    [self hidePicker];
}

- (void)viewPicker{
    if (self.pickerSuperView.frame.origin.y == SCREEN_HEIGHT) {
        [self closeKeyboard];
        [UIView animateWithDuration:0.5 animations:^{
            CGRect pickerFrame = self.pickerSuperView.frame;
            pickerFrame.origin.y = 0;
            self.pickerSuperView.frame = pickerFrame;
        }];
    }
}

- (void)hidePicker{
    if (self.pickerSuperView.frame.origin.y != SCREEN_HEIGHT) {
        [UIView animateWithDuration:0.5 animations:^{
            CGRect pickerFrame = self.pickerSuperView.frame;
            pickerFrame.origin.y = SCREEN_HEIGHT;
            self.pickerSuperView.frame = pickerFrame;
        }];
    }
}
#pragma mark - Tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Register_TableviewCell_Height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    @weakify (self);
    static NSString *cellIden = @"registerTableViewCellIden";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
        cell.textLabel.font = [UIFont systemFontOfSize:16.f];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        switch (indexPath.row) {
            case 0:
            {
                cell.textLabel.text = @"姓名:";
                //self.usernameInput = [[UITextField alloc] initWithFrame:CGRectMake(90.f, (Register_TableviewCell_Height-30.f)/2, SCREEN_WIDTH-SCREEN_WIDTH/30-200.f, 30.f)];
                self.usernameInput = [[UITextField alloc] init];
                self.usernameInput.textColor = [UIColor lightGrayColor];
                self.usernameInput.delegate = self;
                [cell.contentView addSubview:self.usernameInput];
                
                //self.sexControl = [[ChooseSexControl alloc] initWithOrigin:CGPointMake(SCREEN_WIDTH-Control_Width-SCREEN_WIDTH/30, (Register_TableviewCell_Height-Control_Height)/2)];
                self.sexControl = [[ChooseSexControl alloc] init];
                [cell.contentView addSubview:self.sexControl];
                
                
                [self.sexControl mas_makeConstraints:^(MASConstraintMaker *make){
                    make.width.mas_equalTo(Control_Width);
                    make.height.mas_equalTo(Control_Height);
                    make.top.mas_equalTo((Register_TableviewCell_Height-Control_Height)/2);
                    //make.left.equalTo(self.usernameInput.mas_right).with.mas_offset(10);
                    make.right.mas_equalTo(-10);
                }];
                
                [self.usernameInput mas_makeConstraints:^(MASConstraintMaker *make){
                    make.left.mas_equalTo(90);
                    make.top.mas_equalTo((Register_TableviewCell_Height-30)/2);
                    make.height.mas_equalTo(30);
                    make.right.equalTo(self.sexControl.mas_left).with.mas_offset(-10);
                }];
            }
                break;
            case 1:
            {
                cell.textLabel.text = @"出生日期:";
                
                self.birthdayDate = [[UILabel alloc] initWithFrame:CGRectMake(90.f, (Register_TableviewCell_Height-30.f)/2, SCREEN_WIDTH-SCREEN_WIDTH/30-196.f, 30.f)];
                self.birthdayDate.textColor = [UIColor lightGrayColor];
                [cell.contentView addSubview:self.birthdayDate];
                
                
                self.chooseBirthdayDate = [UIButton buttonWithType:UIButtonTypeCustom];
                [self.chooseBirthdayDate setTitle:@"选择时间 >" forState:UIControlStateNormal];
                [self.chooseBirthdayDate setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
                [self.chooseBirthdayDate setFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/30-100.f, (Register_TableviewCell_Height-24.f)/2, 100.f, 24.f)];
                [[self.chooseBirthdayDate rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *sender){
                    [self viewPicker];
                }];
                [cell.contentView addSubview:self.chooseBirthdayDate];
            }
                break;
            case 2:
            {
                cell.textLabel.text = @"手机号码:";
                
                self.phoneNumInput = [[UITextField alloc] initWithFrame:CGRectMake(90.f, (Register_TableviewCell_Height-30.f)/2, SCREEN_WIDTH-SCREEN_WIDTH/30-196.f, 30.f)];
                self.phoneNumInput.textColor = [UIColor lightGrayColor];
                self.phoneNumInput.delegate = self;
                [cell.contentView addSubview:self.phoneNumInput];
                
                self.getVeriCode = [UIButton buttonWithType:UIButtonTypeCustom];
                [self.getVeriCode setTitle:@"获取验证码" forState:UIControlStateNormal];
                [self.getVeriCode setBackgroundImage:[UIImage imageNamed:@"Register_GetVeriCode"] forState:UIControlStateNormal];
                self.getVeriCode.titleLabel.font = [UIFont systemFontOfSize:14.f];
                //self.getVeriCode.backgroundColor = [UIColor colorWithRed:85/255.f green:194/255.f blue:43/255.f alpha:1.f];
                [self.getVeriCode setFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/30-95.f, (Register_TableviewCell_Height-25.f)/2, 95.f, 25.f)];
                [[self.getVeriCode rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *sender){
                    @strongify(self);
                    [self closeKeyboard];
                    sender.enabled = NO;
                    self.smsTime = 120;
                    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(lastTime) userInfo:nil repeats:YES];
                    [[UIManagement sharedInstance] getVerifyCode:self.phoneNumInput.text withType:0];
                }];
                [cell.contentView addSubview:self.getVeriCode];
                
                RAC(self.getVeriCode,enabled) = [RACSignal combineLatest:@[
                                                                           self.phoneNumInput.rac_textSignal] reduce:^(NSString *phoneNum){
                                                                               return @([NSString isTelNumber:phoneNum]);
                                                                           }];
            }
                break;
            case 3:
            {
                cell.textLabel.text = @"验证码:";
                
                self.veriCodeInput = [[UITextField alloc] initWithFrame:CGRectMake(90.f, (Register_TableviewCell_Height-30.f)/2, SCREEN_WIDTH-SCREEN_WIDTH/30-90, 30.f)];
                self.veriCodeInput.textColor = [UIColor lightGrayColor];
                self.veriCodeInput.delegate = self;
                [cell.contentView addSubview:self.veriCodeInput];
            }
                break;
            default:
                break;
        }
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self closeKeyboard];
}

#pragma mark - controlKeybord
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self closeKeyboard];
}

- (CGFloat)getCurrentOffSet{
    CGRect textfieldFrame;
    if ([_phoneNumInput isFirstResponder]) {
        textfieldFrame = [_phoneNumInput.superview convertRect:_phoneNumInput.frame toView:self.view];
        NSLog(@"%@,%@",self.view,_phoneNumInput.superview);
    }else if ([_veriCodeInput isFirstResponder]){
        textfieldFrame = [_veriCodeInput.superview convertRect:_veriCodeInput.frame toView:self.view];
    }
    CGFloat offset = CGRectGetMaxY(textfieldFrame)+40 - (SCREEN_HEIGHT-KeyBoardHeight-64);
    return offset;
}

- (void)openKeyboard{
    [UIView animateWithDuration:0.5 animations:^{
        CGFloat offset = [self getCurrentOffSet];
        if (offset > 0) {
            CGRect viewFrame = self.view.frame;
            viewFrame.origin.y =  -offset;
            self.view.frame = viewFrame;
        }
    }];
}

- (void)closeKeyboard{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect viewFrame = self.view.frame;
        viewFrame.origin.y = 64;
        self.view.frame = viewFrame;
        if ([_usernameInput isFirstResponder]) {
            [_usernameInput resignFirstResponder];
        }else if([_veriCodeInput isFirstResponder])
        {
            [_veriCodeInput resignFirstResponder];
        }else if ([_phoneNumInput isFirstResponder]){
            [_phoneNumInput resignFirstResponder];
        }
    }];
}
#pragma mark - UITextFiled
/*
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    return YES;
}
*/
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([_phoneNumInput isFirstResponder] && self.view.frame.origin.y != -[self getCurrentOffSet]) {
        [self openKeyboard];
    }else if ([_veriCodeInput isFirstResponder] && self.view.frame.origin.y != -[self getCurrentOffSet]){
        [self openKeyboard];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self closeKeyboard];
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - NSTimer
-(void)lastTime{
    self.smsTime = self.smsTime - 1;
    if (self.smsTime == 0) {
        [self.timer invalidate];
        self.timer = nil;
        self.getVeriCode.enabled = YES;
        [self.getVeriCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    }else{
        [self.getVeriCode setTitle:[NSString stringWithFormat:@"%ld秒后重试", (long)self.smsTime] forState:UIControlStateNormal];
    }
}
@end

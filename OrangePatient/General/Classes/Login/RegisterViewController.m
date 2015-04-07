//
//  RegisterViewController.m
//  OrangePatient
//
//  Created by ZhangQing on 3/11/15.
//  Copyright (c) 2015 Orange. All rights reserved.
//

#define RegisterBtn_Width SCREEN_WIDTH*2/3

#import "RegisterViewController.h"
#import "ChooseSexControl.h"

#import "UIManagement.h"
#import <QuartzCore/QuartzCore.h>
@interface RegisterViewController ()<UITableViewDataSource,UITableViewDelegate>
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
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setFrame:CGRectMake((SCREEN_WIDTH-RegisterBtn_Width)/2, CGRectGetMaxY(registerTip.frame)+14.f, RegisterBtn_Width, 30.f)];
    registerBtn.layer.masksToBounds = YES;
    registerBtn.layer.cornerRadius = 5.f;
    registerBtn.backgroundColor = [UIColor colorWithRed:227/255.f green:75/255.f blue:45/255.f alpha:1.f];
    [registerBtn setTitle:REGISTER_PAGE_REGISTER_BTN_TITLE forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    
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
            [self closeProgress];
            if (registerResult[@"hasError"]) {
                NSDictionary *data = registerResult[@"data"];
                
            }else{
                [self showProgressWithText:registerResult[@"errorMessage"] withDelayTime:2.f];
            }
        }
    }];
    // Do any additional setup after loading the view.
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
    [[UIManagement sharedInstance] regsiter:self.usernameInput.text withPassword:[self.phoneNumInput.text substringFromIndex:[self.phoneNumInput.text length]-6] withName:self.usernameInput.text withSex:[self.sexControl getCurrentChooseSex] withBirthday:self.birthdayDate.text withVerifyCode:self.veriCodeInput.text];
}

- (void)pickerSuperViewTapped
{
    [self hidePicker];
}

- (void)viewPicker
{
    if (self.pickerSuperView.frame.origin.y == SCREEN_HEIGHT) {
        [UIView animateWithDuration:0.5 animations:^{
            CGRect pickerFrame = self.pickerSuperView.frame;
            pickerFrame.origin.y = 0;
            self.pickerSuperView.frame = pickerFrame;
        }];
    }
    
}

- (void)hidePicker
{
    if (self.pickerSuperView.frame.origin.y != SCREEN_HEIGHT) {
        [UIView animateWithDuration:0.5 animations:^{
            CGRect pickerFrame = self.pickerSuperView.frame;
            pickerFrame.origin.y = SCREEN_HEIGHT;
            self.pickerSuperView.frame = pickerFrame;
        }];
    }
    
}
#pragma mark - Tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Register_TableviewCell_Height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
                self.usernameInput = [[UITextField alloc] initWithFrame:CGRectMake(90.f, (Register_TableviewCell_Height-30.f)/2, SCREEN_WIDTH-SCREEN_WIDTH/30-200.f, 30.f)];
                self.usernameInput.textColor = [UIColor lightGrayColor];
                [cell.contentView addSubview:self.usernameInput];
                
                self.sexControl = [[ChooseSexControl alloc] initWithOrigin:CGPointMake(SCREEN_WIDTH-Control_Width-SCREEN_WIDTH/30, (Register_TableviewCell_Height-Control_Height)/2)];
                [cell.contentView addSubview:self.sexControl];
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
                RACSignal *chooseBirthdaySingnal = [self.chooseBirthdayDate rac_signalForControlEvents:UIControlEventTouchUpInside];
                [chooseBirthdaySingnal subscribeNext:^(UIButton *sender){
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
                [cell.contentView addSubview:self.phoneNumInput];
                
                self.getVeriCode = [UIButton buttonWithType:UIButtonTypeCustom];
                [self.getVeriCode setTitle:@"获取验证码" forState:UIControlStateNormal];
                self.getVeriCode.titleLabel.font = [UIFont systemFontOfSize:14.f];
                self.getVeriCode.backgroundColor = [UIColor colorWithRed:85/255.f green:194/255.f blue:43/255.f alpha:1.f];
                [self.getVeriCode setFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/30-100.f, (Register_TableviewCell_Height-24.f)/2, 100.f, 24.f)];
                RACSignal *getVeriCodeSingnal = [self.getVeriCode rac_signalForControlEvents:UIControlEventTouchUpInside];
                [getVeriCodeSingnal subscribeNext:^(UIButton *sender){
                    [[UIManagement sharedInstance] getVerifyCode:self.phoneNumInput.text withType:0];
                }];
                [cell.contentView addSubview:self.getVeriCode];
            }
                break;
            case 3:
            {
                cell.textLabel.text = @"验证码:";
                
                self.phoneNumInput = [[UITextField alloc] initWithFrame:CGRectMake(90.f, (Register_TableviewCell_Height-30.f)/2, SCREEN_WIDTH-SCREEN_WIDTH/30-90, 30.f)];
                [cell.contentView addSubview:self.phoneNumInput];
            }
                break;
            default:
                break;
        }
    }
    
    
    return cell;
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

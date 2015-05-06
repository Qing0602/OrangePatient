//
//  SubmitDatingInfoViewController.m
//  OrangePatient
//
//  Created by ZhangQing on 15/4/8.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "SubmitDatingInfoViewController.h"

#import "ScreeingDatingDoctorsModel.h"

#import "ChooseSexControl.h"

#import "UIManagement.h"
@interface SubmitDatingInfoViewController()<UIScrollViewDelegate,UITextFieldDelegate>
//scrollview
@property (nonatomic, strong)UIScrollView *contentScrollview;
//姓名
@property (nonatomic, strong)UITextField *nameInput;
//性别
@property (nonatomic, strong)ChooseSexControl *sexControl;
//年龄
@property (nonatomic, strong)UITextField *ageInput;
//身份证号
@property (nonatomic, strong)UITextField *identityIDInput;
//医保卡号
@property (nonatomic, strong)UITextField *medicalIDInput;
//电话号码
@property (nonatomic, strong)UITextField *phoneNumberInput;
//doctorModel
@property (nonatomic, strong)ScreeingDatingDoctorsModel *doctorModel;
@end
@implementation SubmitDatingInfoViewController

#pragma mark - 
- (void)setConstantsWithLabel:(UILabel *)label targetLabel:(UILabel *)targetLabel{
     const CGFloat labelOffset = 30.f;
    [label mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(targetLabel.mas_left);
        make.width.equalTo(targetLabel.mas_width);
        make.height.equalTo(targetLabel.mas_height);
        make.top.equalTo(targetLabel.mas_bottom).with.offset(labelOffset);
    }];
}

- (void)setConstantsWithTextfield:(UITextField *)textfield targetLabel:(UILabel *)targetLabel{
    [textfield mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(targetLabel.mas_right).with.offset(20);
        make.right.mas_equalTo(-10);
        make.top.equalTo(targetLabel.mas_top).with.offset(-4);
        make.bottom.equalTo(targetLabel.mas_bottom).with.offset(4);
    }];
}

- (UITextField *)creatTextFiled{
    UITextField *textfield = [[UITextField alloc] init];
    textfield.borderStyle = UITextBorderStyleRoundedRect;
    textfield.delegate = self;
    return textfield;
}

- (UILabel *)creatLabel{
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentRight;
    label.backgroundColor = [UIColor clearColor];
    return label;
}

#pragma mark - Getter&Setter
- (UITextField *)nameInput{
    if (!_nameInput) {
        _nameInput = [self creatTextFiled];
        _nameInput.returnKeyType = UIReturnKeyNext;
    }
    return _nameInput;
}

- (UITextField *)ageInput{
    if (!_ageInput) {
        _ageInput = [self creatTextFiled];
        _ageInput.keyboardType = UIKeyboardTypeNumberPad;
        _ageInput.returnKeyType = UIReturnKeyNext;
    }
    return _ageInput;
}

- (UITextField *)identityIDInput{
    if (!_identityIDInput) {
        _identityIDInput = [self creatTextFiled];
        _identityIDInput.returnKeyType = UIReturnKeyNext;
    }
    return _identityIDInput;
}

- (UITextField *)medicalIDInput{
    if (!_medicalIDInput) {
        _medicalIDInput = [self creatTextFiled];
        _medicalIDInput.returnKeyType = UIReturnKeyNext;
    }
    return _medicalIDInput;
}

- (UITextField *)phoneNumberInput{
    if (!_phoneNumberInput) {
        _phoneNumberInput = [self creatTextFiled];
    }
    return _phoneNumberInput;
}

- (ChooseSexControl *)sexControl{
    if (!_sexControl) {
        _sexControl = [[ChooseSexControl alloc] init];
    }
    return _sexControl;
}
#pragma mark - LifeCycle
- (instancetype)initWithDoctorModel:(ScreeingDatingDoctorsModel *)model{
    self = [super init];
    if (self) {
        _doctorModel = model;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"提交预约信息";
    
    UILabel *userNameLabel = [self creatLabel];
    userNameLabel.text = @"姓名:";
    [self.view addSubview:userNameLabel];
    
    UILabel *sexLabel = [self creatLabel];
    sexLabel.text = @"性别:";
    [self.view addSubview:sexLabel];
    
    UILabel *ageLabel = [self creatLabel];
    ageLabel.text = @"年龄:";
    [self.view addSubview:ageLabel];
    
    UILabel *identityIDLabel = [self creatLabel];
    identityIDLabel.text = @"身份证号:";
    [self.view addSubview:identityIDLabel];
    
    UILabel *medicalIDLabel = [self creatLabel];
    medicalIDLabel.text = @"医保卡号";
    [self.view addSubview:medicalIDLabel];
    
    UILabel *phoneNumLabel = [self creatLabel];
    phoneNumLabel.text = @"电话号码:";
    [self.view addSubview:phoneNumLabel];
    
    UIButton *datingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    datingBtn.backgroundColor = [UIColor orangeColor];
    [datingBtn setTitle:@"预约" forState:UIControlStateNormal];
    [datingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    datingBtn.layer.cornerRadius = 4.f;
    datingBtn.layer.borderWidth = 1.f;
    datingBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [[datingBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *sender){
        [self showProgressWithText:@"正在提交"];
        [[UIManagement sharedInstance] appointment:self.doctorModel.doctorID withTimeStamp:[[NSDate date] timeIntervalSinceNow]];
    }];
    [self.view addSubview:datingBtn];
    
    [self.view addSubview:self.nameInput];
    [self.view addSubview:self.sexControl];
    [self.view addSubview:self.ageInput];
    [self.view addSubview:self.identityIDInput];
    //[self.view addSubview:self.medicalIDInput];
    [self.view addSubview:self.phoneNumberInput];
    
    
    
    [userNameLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(6);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(20);
    }];
    
    [self setConstantsWithLabel:sexLabel targetLabel:userNameLabel];
    [self setConstantsWithLabel:ageLabel targetLabel:sexLabel];
    [self setConstantsWithLabel:identityIDLabel targetLabel:ageLabel];
    //[self setConstantsWithLabel:medicalIDLabel targetLabel:identityIDLabel];
    [self setConstantsWithLabel:phoneNumLabel targetLabel:identityIDLabel];
    
    [self setConstantsWithTextfield:self.nameInput targetLabel:userNameLabel];
    [self.sexControl mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(sexLabel.mas_right).with.offset(20);
        make.centerY.equalTo(sexLabel.mas_centerY);
        make.width.mas_equalTo(Control_Width);
        make.height.mas_equalTo(Control_Height);
    }];
    [self setConstantsWithTextfield:self.ageInput targetLabel:ageLabel];
    [self setConstantsWithTextfield:self.identityIDInput targetLabel:identityIDLabel];
    //[self setConstantsWithTextfield:self.medicalIDInput targetLabel:medicalIDLabel];
    [self setConstantsWithTextfield:self.phoneNumberInput targetLabel:phoneNumLabel];
    
    [datingBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(self.view);
        make.top.equalTo(phoneNumLabel.mas_bottom).with.offset(30);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    //kvo
    [RACObserve([UIManagement sharedInstance], appointmentDoctorResult) subscribeNext:^(NSDictionary *dic){
        if (dic) {
            if (![dic[ASI_REQUEST_HAS_ERROR] boolValue]) {
                [self closeProgress];
                NSArray *dataArr = dic[ASI_REQUEST_DATA];
            }else{
                [self showProgressWithText:dic[ASI_REQUEST_ERROR_MESSAGE] withDelayTime:2.f];
            }
        }
    }];
}


#pragma mark - controlKeybord
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self closeKeyboard];
}

- (CGFloat)getCurrentOffSet{
    CGRect textfieldFrame;
    if ([_nameInput isFirstResponder]) {
        textfieldFrame = _nameInput.frame;
    }else if([_ageInput isFirstResponder]){
        textfieldFrame = _ageInput.frame;
    }else if ([_identityIDInput isFirstResponder]){
        textfieldFrame = _identityIDInput.frame;
    }else if ([_medicalIDInput isFirstResponder]){
        textfieldFrame = _medicalIDInput.frame;
    }else if ([_phoneNumberInput isFirstResponder]){
        textfieldFrame = _phoneNumberInput.frame;
    }else{
        return 64;
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
        if ([_nameInput isFirstResponder]) {
            [_nameInput resignFirstResponder];
        }else if([_ageInput isFirstResponder]){
            [_ageInput resignFirstResponder];
        }else if ([_identityIDInput isFirstResponder]){
            [_identityIDInput resignFirstResponder];
        }else if ([_medicalIDInput isFirstResponder]){
            [_medicalIDInput resignFirstResponder];
        }else if ([_phoneNumberInput isFirstResponder]){
            [_phoneNumberInput resignFirstResponder];
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
    if (self.view.frame.origin.y != -[self getCurrentOffSet]) {
        [self openKeyboard];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([_nameInput isFirstResponder]) {
        [_ageInput becomeFirstResponder];
    }else if([_ageInput isFirstResponder]){
        [_identityIDInput becomeFirstResponder];
    }else if ([_identityIDInput isFirstResponder]){
        [_medicalIDInput becomeFirstResponder];
    }else if ([_medicalIDInput isFirstResponder]){
        [_phoneNumberInput becomeFirstResponder];
    }else if ([_phoneNumberInput isFirstResponder]){
        [self closeKeyboard];
        return YES;
    }
    
    return NO;
    
}

@end

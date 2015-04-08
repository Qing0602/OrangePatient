//
//  SubmitDatingInfoViewController.m
//  OrangePatient
//
//  Created by ZhangQing on 15/4/8.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "SubmitDatingInfoViewController.h"

#import "ChooseSexControl.h"
@interface SubmitDatingInfoViewController()<UIScrollViewDelegate>
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
@end
@implementation SubmitDatingInfoViewController

- (UITextField *)creatTextFiled{
    UITextField *textfield = [[UITextField alloc] init];
    return textfield;
}

#pragma mark - Getter&Setter
- (UITextField *)nameInput{
    if (!_nameInput) {
        _nameInput = [self creatTextFiled];
    }
    return _nameInput;
}

- (UITextField *)ageInput{
    if (!_ageInput) {
        _ageInput = [self creatTextFiled];
    }
    return _ageInput;
}

- (UITextField *)identityIDInput{
    if (!_identityIDInput) {
        _identityIDInput = [self creatTextFiled];
    }
    return _identityIDInput;
}

- (UITextField *)medicalIDInput{
    if (!_medicalIDInput) {
        _medicalIDInput = [self creatTextFiled];
    }
    return _medicalIDInput;
}

- (UITextField *)phoneNumberInput{
    if (!_phoneNumberInput) {
        _phoneNumberInput = [self creatTextFiled];
    }
    return _phoneNumberInput;
}
#pragma mark - LifeCycle
- (void)viewDidLoad{
    [super viewDidLoad];
    
}

@end

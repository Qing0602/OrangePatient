//
//  SendProblemToDoctorViewController.m
//  OrangePatient
//
//  Created by ZhangQing on 15/4/2.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "SendProblemToDoctorViewController.h"

#import "ChooseSexControl.h"
@interface SendProblemToDoctorViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UIView *pickerSuperView;
//年龄
@property (nonatomic, strong)UITextField *ageInput;
//选择性别
@property (nonatomic, strong)ChooseSexControl *sexControl;
//就医日期显示
@property (nonatomic, strong)UILabel *seeDoctorDate;
//就医日期选择picker
@property (nonatomic, strong)UIDatePicker *seeDoctorDatePicker;
//选择就医时间
@property (nonatomic, strong)UIButton *chooseSeeDoctorDate;
//诊断说明
@property (nonatomic, strong)UITextField * symptomInput;
//上传资料状态
@property (nonatomic, strong)UILabel *uploadInfoStatus;
//上传资料
@property (nonatomic, strong)UIButton *uploadInfoBtn;
@end

@implementation SendProblemToDoctorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"问题描述";
    
    UITableView *problemTable = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH, SendProblemToDoctor_TableviewCell_LargeHeight*2+SendProblemToDoctor_TableviewCell_NormalHeight*2) style:UITableViewStylePlain];
    problemTable.delegate = self;
    problemTable.dataSource = self;
    problemTable.scrollEnabled = NO;
    //registerTable.separatorInset = UIEdgeInsetsMake(0.f, 0.f, 0.f, 0.f);
    problemTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:problemTable];
    
    UILabel *tip = [[UILabel alloc] init];
    tip.textColor = [UIColor lightGrayColor];
    tip.numberOfLines = 2;
    tip.font = [UIFont systemFontOfSize:13.f];
    tip.text = @"请尽可能的详细描述你的症状,疾病和身体状况,以便得到医生全面的解答";
    [self.view addSubview:tip];
    
    [tip mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.equalTo(problemTable.mas_bottom).offset(6);
        make.height.mas_equalTo(36);
    }];
    
    self.pickerSuperView = [[UIView alloc] initWithFrame:CGRectMake(0.f, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.pickerSuperView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    [self.view addSubview:self.pickerSuperView];
    
    UITapGestureRecognizer *tapPickerSuperView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerSuperViewTapped)];
    [self.pickerSuperView addGestureRecognizer:tapPickerSuperView];
    
    self.seeDoctorDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.f, SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
    [self.seeDoctorDatePicker setMinimumDate:[NSDate dateWithString:BIRTHDAY_MINIMUM_DATE]];
    [self.seeDoctorDatePicker setMaximumDate:[NSDate date]];
    self.seeDoctorDatePicker.datePickerMode = UIDatePickerModeDate;
    RACSignal *pickerChoosen = [self.seeDoctorDatePicker rac_signalForControlEvents:UIControlEventValueChanged];
    [pickerChoosen subscribeNext:^(UIDatePicker *picker){
        self.seeDoctorDate.text = [NSString stringFromDate:picker.date];
    }];
    [self.pickerSuperView addSubview:self.seeDoctorDatePicker];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UITableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row<2?SendProblemToDoctor_TableviewCell_NormalHeight:SendProblemToDoctor_TableviewCell_LargeHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"sendProblemCell"];
    cell.textLabel.font = [UIFont systemFontOfSize:16.f];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    switch (indexPath.row) {
        case 0:{
            cell.textLabel.text = @"年龄:";
            
            self.ageInput = [[UITextField alloc] init];
            self.ageInput.textColor = [UIColor lightGrayColor];
            self.ageInput.keyboardType = UIKeyboardTypeNumberPad;
            [cell.contentView addSubview:self.ageInput];
            
            self.sexControl = [[ChooseSexControl alloc] init];
            [cell.contentView addSubview:self.sexControl];
            
            
            [self.sexControl mas_makeConstraints:^(MASConstraintMaker *make){
                make.width.mas_equalTo(Control_Width);
                make.height.mas_equalTo(Control_Height);
                make.top.mas_equalTo((SendProblemToDoctor_TableviewCell_NormalHeight-Control_Height)/2);
                make.right.mas_equalTo(-10);
            }];
            
            [self.ageInput mas_makeConstraints:^(MASConstraintMaker *make){
                make.left.mas_equalTo(80);
                make.top.mas_equalTo((SendProblemToDoctor_TableviewCell_NormalHeight-30)/2);
                make.height.mas_equalTo(30);
                make.right.equalTo(self.sexControl.mas_left).with.mas_offset(-10);
            }];
        }
            break;
        case 1:{
            cell.textLabel.text = @"上次就诊时间:";
            
            self.seeDoctorDate = [[UILabel alloc] init];
            self.seeDoctorDate.textColor = [UIColor lightGrayColor];
            self.seeDoctorDate.backgroundColor = [UIColor yellowColor];
            [cell.contentView addSubview:self.seeDoctorDate];
            
            self.chooseSeeDoctorDate = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.chooseSeeDoctorDate setTitle:@"选择时间 >" forState:UIControlStateNormal];
            self.chooseSeeDoctorDate.titleLabel.font = [UIFont systemFontOfSize:13.f];
            [self.chooseSeeDoctorDate setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [[self.chooseSeeDoctorDate rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *sender){
                [self viewPicker];
            }];
            [cell.contentView addSubview:self.chooseSeeDoctorDate];
            
            [_chooseSeeDoctorDate mas_makeConstraints:^(MASConstraintMaker *make){
                make.right.mas_equalTo(-10);
                make.centerY.equalTo(cell.contentView.mas_centerY);
                make.width.mas_equalTo(70);
                make.height.mas_equalTo(24);
            }];
            
            [_seeDoctorDate mas_makeConstraints:^(MASConstraintMaker *make){
                make.left.mas_equalTo(124);
                make.right.equalTo(self.chooseSeeDoctorDate.mas_left).with.offset(-6);
                make.centerY.equalTo(self.chooseSeeDoctorDate.mas_centerY);
                make.height.mas_equalTo(16);
            }];
        }
            break;
        case 2:{
            cell.textLabel.text = @"诊断说明:";
            cell.detailTextLabel.text = @"如嗜睡、头昏、易怒等...";
            
            self.symptomInput = [[UITextField alloc] init];
            self.symptomInput.textColor = [UIColor lightGrayColor];
            self.symptomInput.backgroundColor = [UIColor yellowColor];
            [cell.contentView addSubview:self.symptomInput];
            
            [_symptomInput mas_makeConstraints:^(MASConstraintMaker *make){
                make.left.mas_equalTo(100);
                make.top.mas_equalTo(8);
                make.height.mas_equalTo(26);
                make.right.mas_equalTo(-10);
            }];
            
        }
            break;
        case 3:{
            cell.textLabel.text = @"上传资料/报告:";
            cell.detailTextLabel.text = @"资料、报告类型为.jpg或.pdf文件";
            
            self.uploadInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.uploadInfoBtn setTitle:@"上传" forState:UIControlStateNormal];
            self.uploadInfoBtn.titleLabel.font = [UIFont systemFontOfSize:13.f];
            [self.uploadInfoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.uploadInfoBtn setBackgroundImage:[UIImage imageNamed:@"Cell_Btn_BG"] forState:UIControlStateNormal];
            [[self.uploadInfoBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *sender){
                
            }];
            [cell.contentView addSubview:self.uploadInfoBtn];
            
            [_uploadInfoBtn mas_makeConstraints:^(MASConstraintMaker *make){
                make.right.mas_equalTo(-10);
                make.top.mas_equalTo(10);
                make.width.mas_equalTo(60);
                make.height.mas_equalTo(25);
            }];
        }
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self closeKeyboard];
}
#pragma mark - picker
- (void)pickerSuperViewTapped{
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

#pragma mark - Keyboard
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
        if ([_ageInput isFirstResponder]) {
            [_ageInput resignFirstResponder];
        }else if([_symptomInput isFirstResponder])
        {
            [_symptomInput resignFirstResponder];
        }
    }];
}

- (CGFloat)getCurrentOffSet{
    CGRect textfieldFrame;
    if ([_ageInput isFirstResponder]) {
        textfieldFrame = [_ageInput.superview convertRect:_ageInput.frame toView:self.view];
        NSLog(@"%@,%@",self.view,_ageInput.superview);
    }else if ([_symptomInput isFirstResponder]){
        textfieldFrame = [_symptomInput.superview convertRect:_symptomInput.frame toView:self.view];
    }
    CGFloat offset = CGRectGetMaxY(textfieldFrame)+40 - (SCREEN_HEIGHT-KeyBoardHeight-64);
    return offset;
}
#pragma mark - UITextFiled
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([_ageInput isFirstResponder] && self.view.frame.origin.y != -[self getCurrentOffSet]) {
        [self openKeyboard];
    }else if ([_symptomInput isFirstResponder] && self.view.frame.origin.y != -[self getCurrentOffSet]){
        [self openKeyboard];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self closeKeyboard];
    return YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self closeKeyboard];
}
@end

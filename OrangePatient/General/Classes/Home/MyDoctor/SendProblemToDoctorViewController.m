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
@end

@implementation SendProblemToDoctorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"问题描述";
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
    return indexPath.row<2?SendProblemToDoctor_TableviewCell_NormalHeight:50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sendProblemCell"];
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
                make.left.mas_equalTo(90);
                make.top.mas_equalTo((SendProblemToDoctor_TableviewCell_NormalHeight-30)/2);
                make.height.mas_equalTo(30);
                make.right.equalTo(self.sexControl.mas_left).with.mas_offset(-10);
            }];
        }
            break;
        case 1:{
            cell.textLabel.text = @"上次就诊时间:";
        }
            break;
        case 2:{
            cell.textLabel.text = @"诊断说明:";
        }
            break;
        case 3:{
            cell.textLabel.text = @"上传资料/报告:";
        }
            break;
        default:
            break;
    }
    
    return cell;
}
@end

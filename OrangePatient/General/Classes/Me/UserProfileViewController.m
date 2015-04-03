//
//  UserProfileViewController.m
//  OrangePatient
//
//  Created by singlew on 15/4/2.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "UserProfileViewController.h"
#import "EGOImageView.h"
#import "EditorTelPhoneViewController.h"
#import "AreaViewController.h"

@interface UserProfileViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) UITableView *userProfileTableView;

@property (nonatomic,strong) EGOImageView *avatar;
@property (nonatomic,strong) UILabel *userNameLabel;
@property (nonatomic,strong) UILabel *birthdayLabel;
@property (nonatomic,strong) UILabel *telPhoneLabel;
@property (nonatomic,strong) UILabel *areaLabel;
@property (nonatomic,strong) UIView *pickerView;
@property (nonatomic,strong) UIDatePicker *datePicker;

-(void) changeNickName : (NSNotification *) notification;
-(void) changeTelPhone : (NSNotification *) notification;
@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userProfileTableView = [[UITableView alloc] init];
    self.userProfileTableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.userProfileTableView.delegate = self;
    self.userProfileTableView.dataSource = self;
    self.userProfileTableView.showsVerticalScrollIndicator = NO;
    self.userProfileTableView.scrollEnabled = NO;
    self.userProfileTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.userProfileTableView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_userProfileTableView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_userProfileTableView]-0-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_userProfileTableView(308)]" options:0 metrics:nil views:views]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNickName:) name:@"changeNickName" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTelPhone:) name:@"changeTelPhone" object:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 88.0f;
    }else{
        return 44.0f;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIden = @"settingTableViewCellIden";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
        cell.textLabel.font = [UIFont systemFontOfSize:16.f];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = [UIColor whiteColor];
        UILabel *line = [[UILabel alloc] init];
        line.translatesAutoresizingMaskIntoConstraints = NO;
        line.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
        [cell.contentView addSubview:line];
        
        UILabel *title = [[UILabel alloc] init];
        title.translatesAutoresizingMaskIntoConstraints = NO;
        title.font = [UIFont systemFontOfSize:14.0f];
        [cell.contentView addSubview:title];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(line,title);
        
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[line]-0-|" options:0 metrics:nil views:views]];
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[line(1)]-0-|" options:0 metrics:nil views:views]];
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[title(<=80)]" options:0 metrics:nil views:views]];
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[title]-|" options:0 metrics:nil views:views]];
        
        switch (indexPath.row) {
            case 0:{
                title.text = @"头像";
                self.avatar = [[EGOImageView alloc] init];
                self.avatar.translatesAutoresizingMaskIntoConstraints = NO;
                [cell.contentView addSubview:self.avatar];
                views = NSDictionaryOfVariableBindings(_avatar);
                [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_avatar(60)]-10-|" options:0 metrics:nil views:views]];
                [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-11-[_avatar(60)]" options:0 metrics:nil views:views]];
            }
                break;
            case 1:{
                title.text = @"用户名";
                self.userNameLabel = [[UILabel alloc] init];
                self.userNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
                self.userNameLabel.text = @"11111";
                [cell.contentView addSubview:self.userNameLabel];
                
                views = NSDictionaryOfVariableBindings(_userNameLabel);
                [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_userNameLabel]-10-|" options:0 metrics:nil views:views]];
                [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_userNameLabel]-|" options:0 metrics:nil views:views]];
            }
                break;
            case 2:{
                title.text = @"性别";
            }
                break;
            case 3:{
                title.text = @"出生日期";
                self.birthdayLabel = [[UILabel alloc] init];
                self.birthdayLabel.translatesAutoresizingMaskIntoConstraints = NO;
                self.birthdayLabel.text = @"";
                [cell.contentView addSubview:self.birthdayLabel];
                
                views = NSDictionaryOfVariableBindings(_birthdayLabel);
                [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_birthdayLabel]-10-|" options:0 metrics:nil views:views]];
                [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_birthdayLabel]-|" options:0 metrics:nil views:views]];
            }
                break;
            case 4:{
                title.text = @"联系电话";
                self.telPhoneLabel = [[UILabel alloc] init];
                self.telPhoneLabel.translatesAutoresizingMaskIntoConstraints = NO;
                self.telPhoneLabel.text = @"33333";
                [cell.contentView addSubview:self.telPhoneLabel];
                
                views = NSDictionaryOfVariableBindings(_telPhoneLabel);
                [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_telPhoneLabel]-10-|" options:0 metrics:nil views:views]];
                [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_telPhoneLabel]-|" options:0 metrics:nil views:views]];
            }
                break;
            case 5:{
                title.text = @"地区";
                self.areaLabel = [[UILabel alloc] init];
                self.areaLabel.translatesAutoresizingMaskIntoConstraints = NO;
                self.areaLabel.text = @"44444";
                [cell.contentView addSubview:self.areaLabel];
                
                views = NSDictionaryOfVariableBindings(_areaLabel);
                [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_areaLabel]-10-|" options:0 metrics:nil views:views]];
                [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_areaLabel]-|" options:0 metrics:nil views:views]];
            }
                break;
            default:
                break;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            [self.datePicker removeFromSuperview];
            [self.pickerView removeFromSuperview];
            self.datePicker = nil;
            self.pickerView = nil;
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从图片库选择", nil];
            [actionSheet showInView:self.view];
        }
            break;
        case 1:{
            [self.datePicker removeFromSuperview];
            [self.pickerView removeFromSuperview];
            self.datePicker = nil;
            self.pickerView = nil;
            EditorNickNameViewController *nickName = [[EditorNickNameViewController alloc] init];
            [self.navigationController pushViewController:nickName animated:YES];
        }
        case 2:{
            [self.datePicker removeFromSuperview];
            [self.pickerView removeFromSuperview];
            self.datePicker = nil;
            self.pickerView = nil;
        }
            break;
        case 3:{
            if (self.pickerView != nil) {
                return;
            }
            self.pickerView = [[UIView alloc] init];
            self.pickerView.translatesAutoresizingMaskIntoConstraints = NO;
            self.pickerView.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:self.pickerView];
            
            self.datePicker = [[UIDatePicker alloc] init];
            self.datePicker.datePickerMode = UIDatePickerModeDate;
            NSString *date = self.birthdayLabel.text;
            if (date != nil && ![date isEqualToString:@""]) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSDate *currentDate=[formatter dateFromString:date];
                [self.datePicker setDate:currentDate];
            }else{
                [self.datePicker setDate:[NSDate date]];
            }
            [self.datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
            [self.pickerView addSubview:self.datePicker];
            
            NSDictionary *views = NSDictionaryOfVariableBindings(_pickerView,_datePicker);
            [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_pickerView]-0-|" options:0 metrics:nil views:views]];
            [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_pickerView(216)]-0-|" options:0 metrics:nil views:views]];
            [self.pickerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_datePicker]-0-|" options:0 metrics:nil views:views]];
            [self.pickerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_datePicker(216)]-0-|" options:0 metrics:nil views:views]];        }
            break;
        case 4:{
            [self.datePicker removeFromSuperview];
            [self.pickerView removeFromSuperview];
            self.datePicker = nil;
            self.pickerView = nil;
            EditorTelPhoneViewController *telPhoneName = [[EditorTelPhoneViewController alloc] init];
            [self.navigationController pushViewController:telPhoneName animated:YES];
        }
            break;
        case 5:{
            [self.datePicker removeFromSuperview];
            [self.pickerView removeFromSuperview];
            self.datePicker = nil;
            self.pickerView = nil;
            AreaViewController *area = [[AreaViewController alloc] init];
            [self.navigationController pushViewController:area animated:YES];
        }
        default:
            break;
    }
}

-(void) changeNickName : (NSNotification *) notification{
    NSString *userName = notification.object;
    self.userNameLabel.text = userName;
}

-(void) changeTelPhone : (NSNotification *) notification{
    NSString *telPhone = notification.object;
    self.telPhoneLabel.text = telPhone;
}

-(void)datePickerValueChanged:(id)sender{
    UIDatePicker *control = (UIDatePicker*)sender;
    NSString *dateString = [NSString stringFromDate:control.date];
    self.birthdayLabel.text = dateString;
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        ipc.delegate = self;
        [self presentViewController:ipc animated:YES completion:^{
            
        }];
    }else if (buttonIndex == 1) {
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        ipc.delegate = self;
        [self presentViewController:ipc animated:YES completion:^{
            
        }];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    NSData *data = UIImageJPEGRepresentation(image, 0.5f);
    // 上传头像代码

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

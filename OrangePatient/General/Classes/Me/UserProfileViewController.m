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
#import "ChooseSexControl.h"
#import "UIManagement.h"
#import "EGOCache.h"

@interface UserProfileViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) UITableView *userProfileTableView;

@property (nonatomic,strong) EGOImageView *avatar;
@property (nonatomic,strong) UILabel *userNameLabel;
@property (nonatomic,strong) UILabel *birthdayLabel;
@property (nonatomic,strong) UILabel *telPhoneLabel;
@property (nonatomic,strong) UILabel *areaLabel;
@property (nonatomic,strong) UIView *pickerView;
@property (nonatomic,strong) UIDatePicker *datePicker;
@property (nonatomic,strong) NSArray *areaResult;
//选择性别
@property (nonatomic, strong)ChooseSexControl *sexControl;

-(void) saveProfile;
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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveProfile)];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_userProfileTableView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_userProfileTableView]-0-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_userProfileTableView(308)]" options:0 metrics:nil views:views]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNickName:) name:@"changeNickName" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTelPhone:) name:@"changeTelPhone" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeArea:) name:@"changeArea" object:nil];
    
    [self showProgressWithText:@"正在加载"];
    [[UIManagement sharedInstance] getUserProfile:[UIManagement sharedInstance].userAccount.userUid];
    
    [[UIManagement sharedInstance] addObserver:self forKeyPath:@"updateUserProfileResult" options:0 context:nil];
    [[UIManagement sharedInstance] addObserver:self forKeyPath:@"changeAvatarResult" options:0 context:nil];
    [[UIManagement sharedInstance] addObserver:self forKeyPath:@"userProfileResult" options:0 context:nil];
}

-(void) saveProfile{
    NSMutableDictionary *json = [[NSMutableDictionary alloc] init];
    if (self.userNameLabel.text == nil || [self.userNameLabel.text isEqualToString:@""]) {
        [self showProgressWithText:@"用户名不能为空" withDelayTime:2.0f];
    }else{
        [json setObject:self.userNameLabel.text forKey:@"nickname"];
    }
    
    NSInteger sex = [self.sexControl getCurrentChooseSex];
    [json setObject:[NSNumber numberWithInteger:sex] forKey:@"sex"];
    
    if (self.birthdayLabel.text == nil || [self.birthdayLabel.text isEqualToString:@""]) {
        [self showProgressWithText:@"出生日期不能为空" withDelayTime:2.0f];
    }else{
        [json setObject:self.birthdayLabel.text forKey:@"birthday"];
    }
    
    if (self.telPhoneLabel.text == nil || [self.telPhoneLabel.text isEqualToString:@""]) {
        [self showProgressWithText:@"电话不能为空" withDelayTime:2.0f];
    }else{
        [json setObject:self.telPhoneLabel.text forKey:@"telephone"];
    }
    
    if (self.areaResult != nil || [self.areaResult count] != 0) {
        [json setObject:[NSString stringWithFormat:@"%ld,%ld",(long)[self.areaResult[0][@"code"] integerValue],(long)[self.areaResult[1][@"name"] integerValue]] forKey:@"district_city"];
    }
    [[UIManagement sharedInstance] updateUserProfile:[UIManagement sharedInstance].userAccount.userUid withBody:json];
    
}

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"updateUserProfileResult"]) {
        if ([[UIManagement sharedInstance].updateUserProfileResult[ASI_REQUEST_HAS_ERROR] boolValue] == YES) {
            [self showProgressWithText:[UIManagement sharedInstance].updateUserProfileResult[ASI_REQUEST_ERROR_MESSAGE] withDelayTime:3.0f];
        }else{
            [self showProgressWithText:@"保存成功" withDelayTime:2.0f];
        }
    }else if ([keyPath isEqualToString:@"changeAvatarResult"]){
        if ([[UIManagement sharedInstance].changeAvatarResult[ASI_REQUEST_HAS_ERROR] boolValue] == YES) {
            [self showProgressWithText:[UIManagement sharedInstance].changeAvatarResult[ASI_REQUEST_ERROR_MESSAGE] withDelayTime:3.0f];
        }else{
            [self closeProgress];
            NSDictionary *data = [UIManagement sharedInstance].userProfileResult[ASI_REQUEST_DATA];
            [[EGOCache globalCache] clearCache];
            NSString *urlStr = data[@"avatar"];
            [self.avatar setImageURL:[NSURL URLWithString:urlStr]];
        }
    }else if ([keyPath isEqualToString:@"userProfileResult"]){
        if ([[UIManagement sharedInstance].userProfileResult[ASI_REQUEST_HAS_ERROR] boolValue] == YES) {
            [self showProgressWithText:[UIManagement sharedInstance].userProfileResult[ASI_REQUEST_ERROR_MESSAGE] withDelayTime:3.0f];
        }else{
            [self closeProgress];
            NSDictionary *data = [UIManagement sharedInstance].userProfileResult[ASI_REQUEST_DATA];
            NSString *urlStr = data[@"avatar"];
            [self.avatar setImageURL:[NSURL URLWithString:urlStr]];
            self.userNameLabel.text = data[@"nickname"];
            self.birthdayLabel.text = data[@"birthday"];
            self.telPhoneLabel.text = data[@"telephone"];
            NSArray *array = data[@"district_city"];
            NSMutableString *ms = [[NSMutableString alloc] initWithCapacity:20];
            for (NSDictionary *dic in array) {
                [ms appendString:dic[@"name"]];
                [ms appendString:@" "];
            }
            self.areaLabel.text = [ms description];
        }
    }
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
                self.userNameLabel.text = @"";
                [cell.contentView addSubview:self.userNameLabel];
                
                views = NSDictionaryOfVariableBindings(_userNameLabel);
                [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_userNameLabel]-10-|" options:0 metrics:nil views:views]];
                [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_userNameLabel]-|" options:0 metrics:nil views:views]];
            }
                break;
            case 2:{
                title.text = @"性别";
                self.sexControl = [[ChooseSexControl alloc] init];
                self.sexControl.translatesAutoresizingMaskIntoConstraints = NO;
                [cell.contentView addSubview:self.sexControl];
                views = NSDictionaryOfVariableBindings(_sexControl);
                [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_sexControl(100)]-10-|" options:0 metrics:nil views:views]];
                [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-7-[_sexControl(30)]" options:0 metrics:nil views:views]];
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

-(void) changeArea : (NSNotification *) notification{
    self.areaResult = notification.object;
    self.areaLabel.text = [NSString stringWithFormat:@"%@ %@",self.areaResult[0][@"name"],self.areaResult[1][@"name"]];
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
        ipc.allowsEditing = YES;
        ipc.delegate = self;
        [self presentViewController:ipc animated:YES completion:^{
            
        }];
    }else if (buttonIndex == 1) {
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        ipc.allowsEditing = YES;
        ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        ipc.delegate = self;
        [self presentViewController:ipc animated:YES completion:^{
            
        }];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:^{
        [self showProgressWithText:@"正在上传头像"];
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSData *data = UIImageJPEGRepresentation(image, 0.5f);
        // 上传头像代码
        [[UIManagement sharedInstance] changeAvatar:[UIManagement sharedInstance].userAccount.userUid withImage:data];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) dealloc{
    [[UIManagement sharedInstance] removeObserver:self forKeyPath:@"updateUserProfileResult"];
    [[UIManagement sharedInstance] removeObserver:self forKeyPath:@"changeAvatarResult"];
    [[UIManagement sharedInstance] removeObserver:self forKeyPath:@"userProfileResult"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

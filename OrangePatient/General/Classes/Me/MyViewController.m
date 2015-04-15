//
//  MyViewController.m
//  OrangePatient
//
//  Created by singlew on 15/4/2.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "MyViewController.h"
#import "EGOImageView.h"
#import "SettingViewController.h"
#import "UserProfileViewController.h"
#import "AboutViewController.h"
#import "FeedBackViewController.h"
#import "FeedBackViewController.h"
#import "UIManagement.h"

@interface MyViewController ()<UIAlertViewDelegate>
@property (nonatomic,strong) UIView *myView;
@property (nonatomic,strong) EGOImageView *avatar;
@property (nonatomic,strong) UILabel *nickName;
@property (nonatomic,strong) UILabel *uid;
@property (nonatomic,strong) UILabel *regTime;

@property (nonatomic,strong) UITableView *settingTabelView;

-(void) goToUserProfile : (UIGestureRecognizer *) gesture;
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myView = [[UIView alloc] init];
    self.myView.translatesAutoresizingMaskIntoConstraints = NO;
    self.myView.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToUserProfile:)];
    [self.myView addGestureRecognizer:tap];
    [self.view addSubview:self.myView];
    
    self.avatar = [[EGOImageView alloc] init];
    self.avatar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.avatar setImageURL:[NSURL URLWithString:[UIManagement sharedInstance].userAccount.userAvatar]];
    self.avatar.layer.cornerRadius = 35.5f;
    self.avatar.layer.masksToBounds = YES;
    [self.myView addSubview:self.avatar];
    
    self.nickName = [[UILabel alloc] init];
    self.nickName.translatesAutoresizingMaskIntoConstraints = NO;
    self.nickName.text = [UIManagement sharedInstance].userAccount.userNickName;
    self.nickName.font = [UIFont boldSystemFontOfSize:15.0f];
    [self.myView addSubview:self.nickName];
    
    self.uid = [[UILabel alloc] init];
    self.uid.translatesAutoresizingMaskIntoConstraints = NO;
    self.uid.text = [NSString stringWithFormat:@"橙橙号：%@",[UIManagement sharedInstance].userAccount.userOid];
    self.uid.font = [UIFont systemFontOfSize:14.0f];
    [self.myView addSubview:self.uid];
    
    self.regTime = [[UILabel alloc] init];
    self.regTime.translatesAutoresizingMaskIntoConstraints = NO;
    self.regTime.text = @"";
    self.regTime.font = [UIFont systemFontOfSize:13.0f];
    self.regTime.textColor = [UIColor grayColor];
    [self.myView addSubview:self.regTime];
    
    self.settingTabelView = [[UITableView alloc] init];
    self.settingTabelView.translatesAutoresizingMaskIntoConstraints = NO;
    self.settingTabelView.delegate = self;
    self.settingTabelView.dataSource = self;
    self.settingTabelView.showsVerticalScrollIndicator = NO;
    self.settingTabelView.scrollEnabled = NO;
    self.settingTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.settingTabelView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_myView,_avatar,_nickName,_uid,_regTime,_settingTabelView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_myView]-0-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_myView(113)]-10-[_settingTabelView(264)]" options:0 metrics:nil views:views]];
    [self.myView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[_avatar(71)]" options:0 metrics:nil views:views]];
    [self.myView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_avatar(71)]" options:0 metrics:nil views:views]];
    [self.myView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_avatar]-10-[_nickName]-0-|" options:0 metrics:nil views:views]];
    [self.myView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_avatar]-10-[_uid]-0-|" options:0 metrics:nil views:views]];
    [self.myView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_avatar]-10-[_regTime]-0-|" options:0 metrics:nil views:views]];
    [self.myView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_nickName]-10-[_uid]-10-[_regTime]" options:NSLayoutFormatAlignAllLeft metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_settingTabelView]-0-|" options:0 metrics:nil views:views]];
    [[UIManagement sharedInstance] addObserver:self forKeyPath:@"checkVersionResult" options:0 context:nil];
}

-(void) goToUserProfile : (UIGestureRecognizer *) gesture{
    UserProfileViewController *userProfile = [[UserProfileViewController alloc] init];
    userProfile.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:userProfile animated:YES];
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
        NSDictionary *views = NSDictionaryOfVariableBindings(line);
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[line]-0-|" options:0 metrics:nil views:views]];
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[line(1)]-0-|" options:0 metrics:nil views:views]];
        switch (indexPath.row) {
            case 0:{
                cell.textLabel.text = @"设置";
                cell.imageView.image = [UIImage imageNamed:@"MySetting"];
            }
                break;
            case 1:{
                cell.textLabel.text = @"系统通知";
            }
                break;
            case 2:{
                cell.textLabel.text = @"推荐给朋友";
                cell.imageView.image = [UIImage imageNamed:@"MyRecommend"];
            }
                break;
            case 3:{
                cell.textLabel.text = @"检查更新";
            }
                break;
            case 4:{
                cell.textLabel.text = @"意见反馈";
            }
                break;
            case 5:{
                cell.textLabel.text = @"关于橙意";
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
            SettingViewController *setting = [[SettingViewController alloc] init];
            setting.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:setting animated:YES];
        }
            break;
        case 1:
            
            break;
        case 2:
            break;
        case 3:
            [self showProgressWithText:@"正在检查更新"];
            [[UIManagement sharedInstance] checkVersion:@"1.0" withVersionCode:@"1"];
            break;
        case 4:{
            FeedBackViewController *feedBack = [[FeedBackViewController alloc] init];
            feedBack.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:feedBack animated:YES];
        }
            break;
        case 5:{
            AboutViewController *about = [[AboutViewController alloc] init];
            about.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:about animated:YES];
        }
            break;
        default:
            break;
    }
}

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"checkVersionResult"]) {
        if ([[UIManagement sharedInstance].checkVersionResult[ASI_REQUEST_HAS_ERROR] boolValue] == YES) {
            [self showProgressWithText:[UIManagement sharedInstance].checkVersionResult[ASI_REQUEST_ERROR_MESSAGE] withDelayTime:3.0f];
        }else{
            [self closeProgress];
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"" message:@"发现新版本,是否更新" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
            [alter show];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        // NO
    }else{

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc{
    [[UIManagement sharedInstance] removeObserver:self forKeyPath:@"checkVersionResult"];
}

@end

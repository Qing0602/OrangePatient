//
//  SettingViewController.m
//  OrangePatient
//
//  Created by singlew on 15/4/2.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "SettingViewController.h"
#import "UIManagement.h"

@interface SettingViewController ()<UIActionSheetDelegate>
@property (nonatomic,strong) UITableView *settingTabelView;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    
    self.settingTabelView = [[UITableView alloc] init];
    self.settingTabelView.translatesAutoresizingMaskIntoConstraints = NO;
    self.settingTabelView.delegate = self;
    self.settingTabelView.dataSource = self;
    self.settingTabelView.showsVerticalScrollIndicator = NO;
    self.settingTabelView.scrollEnabled = NO;
    self.settingTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.settingTabelView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_settingTabelView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_settingTabelView]-0-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_settingTabelView(88)]" options:0 metrics:nil views:views]];
    [[UIManagement sharedInstance] addObserver:self forKeyPath:@"logoutResult" options:0 context:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
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
                cell.textLabel.text = @"修改密码";
            }
                break;
            case 1:{
                cell.textLabel.text = @"退出登录";
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
            ChangePasswordViewController *setting = [[ChangePasswordViewController alloc] init];
            [self.navigationController pushViewController:setting animated:YES];
        }
            break;
        case 1:{
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"退出登录", nil];
            [actionSheet showInView:self.view];
        }
            break;
        default:
            break;
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [[UIManagement sharedInstance] logout];
    }else if (buttonIndex == 1) {
        NSLog(@"cancel");
    }
}

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"logoutResult"]) {
        if ([[UIManagement sharedInstance].logoutResult[ASI_REQUEST_HAS_ERROR] boolValue] == YES) {
            [self showProgressWithText:[UIManagement sharedInstance].logoutResult[ASI_REQUEST_ERROR_MESSAGE] withDelayTime:3.0f];
        }else{
            // 退出
            
            [self.tabBarController setSelectedIndex:0];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) dealloc{
    [[UIManagement sharedInstance] removeObserver:self forKeyPath:@"logoutResult"];
}

@end

//
//  MyDeviceViewController.m
//  OrangePatient
//
//  Created by singlew on 15/3/13.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "MyDeviceViewController.h"
#import "ConnectionedDeviceTableViewCell.h"
#import "UIManagement.h"
#import "BlueToothModel.h"


@interface MyDeviceViewController ()<ConnectionedCellDelegate,UIAlertViewDelegate>
@property (nonatomic,strong) NSMutableArray *uuidArray;
//@property (nonatomic,strong) NSArray *peripheralArray;
@property (nonatomic,strong) UITableView *deviceTable;
@property (nonatomic,strong) CBCentralManager *central;
@property (nonatomic,strong) NSString *uuid;
@property (nonatomic,strong) UIButton *searchButton;
@property (nonatomic,strong) BlueToothModel *deleteModel;
-(void) searchDevice;
@end

@implementation MyDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"数据采集";
    UIButton *rightButtonT=[UIButton buttonWithType:UIButtonTypeCustom];
    rightButtonT.frame=CGRectMake(0.0f, 0.0f, 44.0f, 44.0f);
    [rightButtonT setImage:[UIImage imageNamed:@"NavSearchDevice"] forState:UIControlStateNormal];
    [rightButtonT setImage:[UIImage imageNamed:@"NavSearchDevice"] forState:UIControlStateHighlighted];
    rightButtonT.backgroundColor = [UIColor clearColor];
    [rightButtonT addTarget:self action:@selector(searchDevice) forControlEvents:UIControlEventTouchUpInside];
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 44.0f, 44.0f)];
    [rightView addSubview:rightButtonT];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    [[UIManagement sharedInstance] addObserver:self forKeyPath:@"getMyDeviceResult" options:0 context:nil];
    [[UIManagement sharedInstance] addObserver:self forKeyPath:@"deleteMydeviceResult" options:0 context:nil];
    
}

-(void) viewDidAppear:(BOOL)animated{
    [self showProgressWithText:@"加载中..."];
    [[UIManagement sharedInstance] getMyDevice];
}

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"getMyDeviceResult"]) {
        if ([[UIManagement sharedInstance].getMyDeviceResult[ASI_REQUEST_HAS_ERROR] boolValue] == YES) {
            [self showProgressWithText:[UIManagement sharedInstance].getMyDeviceResult[ASI_REQUEST_ERROR_MESSAGE] withDelayTime:3.0f];
        }else{
            [self closeProgress];
            NSDictionary *data  = [UIManagement sharedInstance].getMyDeviceResult[ASI_REQUEST_DATA];
            self.uuidArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in data) {
                BlueToothModel *model = [[BlueToothModel alloc] init];
                if ([model converJson:dic]) {
                    [self.uuidArray addObject:model];
                }
            }
            
            NSMutableArray *uuids = [[NSMutableArray alloc] init];
            if ([self.uuidArray count] != 0) {
                for (BlueToothModel *model in self.uuidArray) {
                    [uuids addObject:model.uuid];
                }
                [self.deviceTable reloadData];
            }
            BOOL result = [UIModelCoding serializeModel:self.uuidArray withFileName:@"coreToothCache.cac"];
            NSLog(@"%d",result);
            [self reloadView];
        }
    }else if([keyPath isEqualToString:@"deleteMydeviceResult"]){
        if ([[UIManagement sharedInstance].deleteMydeviceResult[ASI_REQUEST_HAS_ERROR] boolValue] == YES) {
            [self showProgressWithText:[UIManagement sharedInstance].deleteMydeviceResult[ASI_REQUEST_ERROR_MESSAGE] withDelayTime:3.0f];
        }else{
            [self closeProgress];
            BlueToothModel *deleted = nil;
            for (BlueToothModel *model in self.uuidArray) {
                if ([model.uuid isEqualToString:self.deleteModel.uuid]) {
                    deleted = model;
                    break;
                }
            }
            if (deleted != nil) {
                [self.uuidArray removeObject:deleted];
                BOOL result = [UIModelCoding serializeModel:self.uuidArray withFileName:@"coreToothCache.cac"];
                NSLog(@"%d",result);
                [self.deviceTable reloadData];
            }
            [self reloadView];
        }
    }
}

-(void) reloadView{
    if ([self.uuidArray count] == 0 || self.uuidArray == nil) {
        if (self.deviceTable != nil) {
            [self.deviceTable removeFromSuperview];
            self.deviceTable = nil;
        }
        self.searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.searchButton setImage:[UIImage imageNamed:@"SearchDevice"] forState:UIControlStateNormal];
        [self.searchButton setImage:[UIImage imageNamed:@"SearchDevice"] forState:UIControlStateHighlighted];
        self.searchButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self.searchButton addTarget:self action:@selector(searchDevice) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.searchButton];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_searchButton);
        NSDictionary *metrics = @{@"imageEdge":@228.0};
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_searchButton(imageEdge)]" options:0 metrics:metrics views:views]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_searchButton(imageEdge)]" options:0 metrics:metrics views:views]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.searchButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.searchButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    }else{
        if (self.searchButton != nil) {
            [self.searchButton removeFromSuperview];
            self.searchButton = nil;
        }
        self.deviceTable = [[UITableView alloc] init];
        self.deviceTable.translatesAutoresizingMaskIntoConstraints = NO;
        self.deviceTable.delegate = self;
        self.deviceTable.dataSource = self;
        self.deviceTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:self.deviceTable];
        NSDictionary *views = NSDictionaryOfVariableBindings(_deviceTable);
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_deviceTable]-0-|" options:0 metrics:nil views:views]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_deviceTable]-0-|" options:0 metrics:nil views:views]];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.uuidArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 83.5f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *connectionedCell = @"connectionedCellIdentifier";
    ConnectionedDeviceTableViewCell *cell = [self.deviceTable dequeueReusableCellWithIdentifier:connectionedCell];
    if (cell == nil) {
        cell = [[ConnectionedDeviceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:connectionedCell];
    }
    cell.userInteractionEnabled =YES;
    cell.delegate = self;
    [cell setModel:[self.uuidArray objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BlueToothModel *per = [self.uuidArray objectAtIndex:indexPath.row];
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:per.uuid];
    BlueToothDataViewController *blueToothData = [[BlueToothDataViewController alloc] initBlueToothDataVC:uuid];
    [self.navigationController pushViewController:blueToothData animated:YES];
}

-(void) searchDevice{
    SearchBlueToothViewController *search = [[SearchBlueToothViewController alloc] init];
    [self.navigationController pushViewController:search animated:YES];
}

-(void) clickUnlockDevice : (BlueToothModel *) peripheral{
    self.deleteModel = peripheral;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"确定解绑设备" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex != 0) {
        [self showProgressWithText:@"正在删除..."];
        [[UIManagement sharedInstance] deleteDevice:self.deleteModel.uuid];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) dealloc{
    [[UIManagement sharedInstance] removeObserver:self forKeyPath:@"getMyDeviceResult"];
    [[UIManagement sharedInstance] removeObserver:self forKeyPath:@"deleteMydeviceResult"];
}
@end

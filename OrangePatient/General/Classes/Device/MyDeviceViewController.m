//
//  MyDeviceViewController.m
//  OrangePatient
//
//  Created by singlew on 15/3/13.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "MyDeviceViewController.h"
#import "ConnectionedDeviceTableViewCell.h"
#import "UIModelCoding.h"

@interface MyDeviceViewController ()
@property (nonatomic,strong) NSMutableArray *uuidArray;
@property (nonatomic,strong) NSArray *peripheralArray;
@property (nonatomic,strong) UITableView *deviceTable;
@property (nonatomic,strong) CBCentralManager *central;
-(void) searchDevice;
@end

@implementation MyDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.uuidArray = [UIModelCoding deserializeModel:@"coreToothCache.cac"];
    if (self.uuidArray == nil) {
        self.uuidArray = [[NSMutableArray alloc] init];
    }
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
    
    if ([self.uuidArray count] == 0) {
        UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [searchButton setImage:[UIImage imageNamed:@"SearchDevice"] forState:UIControlStateNormal];
        [searchButton setImage:[UIImage imageNamed:@"SearchDevice"] forState:UIControlStateHighlighted];
        searchButton.translatesAutoresizingMaskIntoConstraints = NO;
        [searchButton addTarget:self action:@selector(searchDevice) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:searchButton];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(searchButton);
        NSDictionary *metrics = @{@"imageEdge":@228.0};
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[searchButton(imageEdge)]" options:0 metrics:metrics views:views]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[searchButton(imageEdge)]" options:0 metrics:metrics views:views]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:searchButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:searchButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    }else{
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

-(void) viewDidAppear:(BOOL)animated{
    if ([self.uuidArray count] != 0) {
        self.central = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        self.peripheralArray = [self.central retrievePeripheralsWithIdentifiers:self.uuidArray];
        [self.deviceTable reloadData];
    }
}


- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
            // 扫描设备
            break;
        case CBCentralManagerStatePoweredOff:
            NSLog(@"CBCentralManagerStatePoweredOff");
            break;
        case CBCentralManagerStateResetting:
            NSLog(@"CBCentralManagerStateResetting");
            break;
        case CBCentralManagerStateUnauthorized:
            NSLog(@"CBCentralManagerStateUnauthorized");
            break;
        case CBCentralManagerStateUnknown:
            NSLog(@"CBCentralManagerStateUnknown");
            break;
        case CBCentralManagerStateUnsupported:
            NSLog(@"CBCentralManagerStateUnsupported");
            break;
        default:
            NSLog(@"default");
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.peripheralArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *connectionedCell = @"connectionedCellIdentifier";
    ConnectionedDeviceTableViewCell *cell = [self.deviceTable dequeueReusableCellWithIdentifier:connectionedCell];
    if (cell == nil) {
        cell = [[ConnectionedDeviceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:connectionedCell];
    }
    cell.userInteractionEnabled =YES;
    [cell setModel:[self.peripheralArray objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CBPeripheral *per = [self.peripheralArray objectAtIndex:indexPath.row];
    BlueToothDataViewController *blueToothData = [[BlueToothDataViewController alloc] initBlueToothDataVC:per];
    [self.navigationController pushViewController:blueToothData animated:YES];
}

-(void) searchDevice{
    SearchBlueToothViewController *search = [[SearchBlueToothViewController alloc] init];
    [self.navigationController pushViewController:search animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

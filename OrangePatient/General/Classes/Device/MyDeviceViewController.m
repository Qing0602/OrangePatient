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
@property (nonatomic,strong) UITableView *deviceTable;
@property (nonatomic,strong) CBCentralManager *central;
@end

@implementation MyDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.uuidArray = [UIModelCoding deserializeModel:@"coreToothCache.cac"];
    if (self.uuidArray == nil) {
        self.uuidArray = [[NSMutableArray alloc] init];
    }
    
    if ([self.uuidArray count] == 0) {
        UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [searchButton setImage:[UIImage imageNamed:@"SearchDevice"] forState:UIControlStateNormal];
        [searchButton setImage:[UIImage imageNamed:@"SearchDevice"] forState:UIControlStateHighlighted];
        searchButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:searchButton];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(searchButton);
        NSDictionary *metrics = @{@"imageEdge":@150.0};
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
        NSArray *array = [self.central retrievePeripheralsWithIdentifiers:self.uuidArray];
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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *connectionedCell = @"connectionedCell";
    ConnectionedDeviceTableViewCell *cell;
    if ([self.deviceTable dequeueReusableCellWithIdentifier:connectionedCell] != nil) {
        cell = (ConnectionedDeviceTableViewCell *)[self.deviceTable dequeueReusableCellWithIdentifier:connectionedCell];
    }else{
        cell = [[ConnectionedDeviceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:connectionedCell];
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

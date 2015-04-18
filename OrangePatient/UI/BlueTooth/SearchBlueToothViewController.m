//
//  SearchBlueToothViewController.m
//  OrangeDoctor
//
//  Created by singlew on 15/3/4.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "SearchBlueToothViewController.h"
#import "UIModelCoding.h"
#import "UIColor+Base.h"
#import "BlueToothModel.h"
#import "UIManagement.h"

@interface SearchBlueToothViewController ()
@property (nonatomic,strong) NSMutableArray *uuidArray;
@property (nonatomic,strong) NSMutableArray *peripheralArray;
@property (nonatomic,strong) BlueToothModel *blueToothModel;
@end

@implementation SearchBlueToothViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.uuidArray = [UIModelCoding deserializeModel:@"coreToothCache.cac"];
    if (self.uuidArray == nil) {
        self.uuidArray = [[NSMutableArray alloc] init];
    }
    self.peripheralArray = [[NSMutableArray alloc] init];
    
    self.title = @"索搜设备";
    
    self.deviceCount = [[UILabel alloc] init];
    self.deviceCount.translatesAutoresizingMaskIntoConstraints = NO;
    self.deviceCount.backgroundColor = [UIColor colorWithHexString:@"#eb6100"];
    self.deviceCount.textColor = [UIColor whiteColor];
    self.deviceCount.textAlignment = UITextAlignmentCenter;
    self.deviceCount.text = @"索搜到0个新设备";
    self.deviceCount.font = [UIFont boldSystemFontOfSize:15.0f];
    [self.view addSubview:self.deviceCount];
    
    self.deviceTableView = [[UITableView alloc] init];
    self.deviceTableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.deviceTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.deviceTableView.delegate = self;
    self.deviceTableView.dataSource = self;
    [self.view addSubview:self.deviceTableView];
    
    NSDictionary *views = @{@"topLayoutGuide":self.topLayoutGuide,@"bottomLayoutGuide":self.bottomLayoutGuide,
                            @"deviceCount":self.deviceCount,@"deviceTableView":self.deviceTableView};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[deviceCount]-0-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[deviceTableView]-0-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide]-0-[deviceCount(46)]-0-[deviceTableView]-0-[bottomLayoutGuide]" options:0 metrics:nil views:views]];
    
    [[UIManagement sharedInstance] addObserver:self forKeyPath:@"registerDeviceResult" options:0 context:nil];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.uuidArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 138.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *discoveryDeviceCell = @"discoveryDeviceTableViewCellIdentifier";
    DiscoveryDeviceTableViewCell *cell = [self.deviceTableView dequeueReusableCellWithIdentifier:discoveryDeviceCell];
    if (cell == nil) {
        cell = [[DiscoveryDeviceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:discoveryDeviceCell];
    }
    [cell setModel:[self.uuidArray objectAtIndex:indexPath.row]];
    cell.delegate = self;
    return cell;
}

-(void) clickAddDevice : (BlueToothModel *) peripheral{
    self.blueToothModel = peripheral;
    [self.central stopScan];
    [[UIManagement sharedInstance] registerDevice:peripheral.sn withName:peripheral.spID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
            // 扫描设备
            [self.central scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey : @YES}];
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

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.central = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
}

// 发现设备
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    if (peripheral) {
        
        BOOL result = NO;
        for (BlueToothModel *model in self.uuidArray) {
            if ([model.sn isEqualToString:peripheral.identifier.UUIDString]) {
                result = YES;
            }
        }
        
        if (!result) {
            NSRange foundObj=[peripheral.name rangeOfString:@"SpO" options:NSCaseInsensitiveSearch];
            if (foundObj.length > 0) {
                BlueToothModel *model = [[BlueToothModel alloc] init];
                model.sn = peripheral.identifier.UUIDString;
                model.isAdd = NO;
                model.spID = peripheral.name;
                model.name = @"动态血氧仪";
                [self.uuidArray addObject:model];
                BOOL result = [UIModelCoding serializeModel:self.uuidArray withFileName:@"coreToothCache.cac"];
                NSLog(@"%d",result);
                [self.deviceTableView reloadData];
            }
        }
        
        self.deviceCount.text = [NSString stringWithFormat:@"索搜到%lu个新设备",(unsigned long)[self.peripheralArray count]];
    }
}

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"registerDeviceResult"]) {
        if ([[UIManagement sharedInstance].registerDeviceResult[ASI_REQUEST_HAS_ERROR] boolValue] == YES) {
            [self showProgressWithText:[UIManagement sharedInstance].registerDeviceResult[ASI_REQUEST_ERROR_MESSAGE] withDelayTime:3.0f];
        }else{
            BlueToothModel *model = [[BlueToothModel alloc] init];
            model.sn = self.blueToothModel.sn;
            for (BlueToothModel *model in self.uuidArray) {
                if ([model.spID isEqualToString:self.blueToothModel.spID]) {
                    model.isAdd = YES;
                }
            }
            [self.deviceTableView reloadData];
            BlueToothDataViewController *blueToothData = [[BlueToothDataViewController alloc] initBlueToothDataVC:[[NSUUID alloc] initWithUUIDString:self.blueToothModel.sn]];
            [self.navigationController pushViewController:blueToothData animated:YES];
        }
    }
}

-(void) dealloc{
    [[UIManagement sharedInstance] removeObserver:self forKeyPath:@"registerDeviceResult"];
}

@end

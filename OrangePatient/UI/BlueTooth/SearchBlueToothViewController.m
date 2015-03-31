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

@interface SearchBlueToothViewController ()
@property (nonatomic,strong) NSMutableArray *uuidArray;
@property (nonatomic,strong) NSMutableArray *peripheralArray;

-(void) addBlueToothCache : (NSUUID *) identifier;
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
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.peripheralArray count];
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
    [cell setModel:[self.peripheralArray objectAtIndex:indexPath.row]];
    cell.delegate = self;
    return cell;
}

-(void) clickAddDevice : (CBPeripheral *) peripheral{
    [self addBlueToothCache:peripheral.identifier];
    [self.central stopScan];
    BlueToothDataViewController *blueToothData = [[BlueToothDataViewController alloc] initBlueToothDataVC:peripheral.identifier];
    [self.navigationController pushViewController:blueToothData animated:YES];
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
        for (CBPeripheral *per in self.peripheralArray) {
            if ([per.identifier.UUIDString isEqual:peripheral.identifier.UUIDString]) {
                result = YES;
            }
        }
        if (!result) {
            [self.peripheralArray addObject:peripheral];
            [self.deviceTableView reloadData];
        }
        
        self.deviceCount.text = [NSString stringWithFormat:@"索搜到%lu个新设备",(unsigned long)[self.peripheralArray count]];
    }
}

-(void) addBlueToothCache : (NSUUID *) identifier{
    BOOL isHave = NO;
    for (NSUUID * uuid in self.uuidArray) {
        if ([uuid.UUIDString isEqualToString:identifier.UUIDString]) {
            isHave = YES;
        }
    }
    
    if (!isHave) {
        [self.uuidArray addObject:identifier];
        BOOL result = [UIModelCoding serializeModel:self.uuidArray withFileName:@"coreToothCache.cac"];
        NSLog(@"%d",result);
    }
}

@end

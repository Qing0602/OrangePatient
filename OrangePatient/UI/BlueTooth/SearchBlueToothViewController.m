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

//服务的UUID
#define UUIDSTR_ISSC_PROPRIETARY_SERVICE        @"49535343-FE7D-4AE5-8FA9-9FAFD2O5E455"
#define UUIDSTR_CONNECTION_PARAMETER_CHAR       @"49535343-6DAA-4DO2-ABF6-19569ACA69FE"
#define UUIDSTR_AIR_PATCH_CHAR                  @"49535343-ACA3-481C-91EC-D85E28A6O318"
// 写入的特性UUID
#define UUIDSTR_ISSC_TRANS_TX                   @"49535343-8841-43F4-A8D4-ECBE34729BB3"
// 读取特性的UUID
#define UUIDSTR_ISSC_TRANS_RX                   @"49535343-1E4D-4BD9-BA61-23C647249616"

@interface SearchBlueToothViewController ()
@property (nonatomic,strong) NSMutableData *mutableData;
@property (nonatomic,strong) NSMutableArray *analyesData;
@property (nonatomic,strong) NSMutableArray *uuidArray;
@property (nonatomic) Action action;

-(void) addBlueToothCache : (NSUUID *) identifier;
-(void) getBlueToothData : (CBCharacteristic *) rx withTx : (CBCharacteristic*) tx;
-(void) removeBlueToothData : (CBCharacteristic*) rx withTx : (CBCharacteristic*) tx;

-(BOOL) getDateWithByte : (Byte *) bytes withIndex : (int) index;
-(BOOL) getTimeWithByte : (Byte *) bytes withIndex : (int) index;
-(BOOL) getDataWithByte : (Byte *) bytes withIndex : (int) index;
@end

@implementation SearchBlueToothViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mutableData = nil;
    self.action = kNone;
    self.uuidArray = [UIModelCoding deserializeModel:@"coreToothCache.cac"];
    if (self.uuidArray == nil) {
        self.uuidArray = [[NSMutableArray alloc] init];
    }
    
    self.deviceCount = [[UILabel alloc] init];
    self.deviceCount.translatesAutoresizingMaskIntoConstraints = NO;
    self.deviceCount.backgroundColor = [UIColor colorWithHexString:@"#eb6100"];
    self.deviceCount.textColor = [UIColor whiteColor];
    self.deviceCount.textAlignment = UITextAlignmentCenter;
    self.deviceCount.font = [UIFont boldSystemFontOfSize:15.0f];
    [self.view addSubview:self.deviceCount];
    
    self.deviceTableView = [[UITableView alloc] init];
    self.deviceTableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.deviceTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.deviceTableView.delegate = self;
    self.deviceTableView.dataSource = self;
    [self.view addSubview:self.deviceTableView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_deviceCount,_deviceTableView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_deviceCount]-0-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_deviceTableView]-0-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_deviceCount(46)]-[_deviceTableView]-0-|" options:0 metrics:nil views:views]];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *connectionedCell = @"connectionedCellIdentifier";
//    ConnectionedDeviceTableViewCell *cell = [self.deviceTable dequeueReusableCellWithIdentifier:connectionedCell];
//    if (cell == nil) {
//        cell = [[ConnectionedDeviceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:connectionedCell];
//    }
//    [cell setModel:[self.peripheralArray objectAtIndex:indexPath.row]];
    return nil;
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
        
        self.action = kGetData;
//        self.action = kRemoveData;
        self.peripheral = peripheral;
        [self addBlueToothCache:peripheral.identifier];
        self.peripheral.delegate = self;
        // 连接设备
        [self.central connectPeripheral:peripheral options:@{CBConnectPeripheralOptionNotifyOnConnectionKey : @YES}];
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

// 连接设备成功
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    [peripheral discoverServices:nil];
}

// 连接设备失败
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"error");
}

// 发现服务并查找特征
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    for (CBService *service in peripheral.services) {
        NSLog(@"%@",service);
        if ([service.UUID isEqual:[CBUUID UUIDWithString:@"49535343-FE7D-4AE5-8FA9-9FAFD205E455"]]) {
            [self.peripheral discoverCharacteristics:nil forService:service];
        }
    }
}

-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    CBCharacteristic *rx;
    CBCharacteristic *tx;
    for(CBCharacteristic *c in service.characteristics){
        if ([c.UUID isEqual:[CBUUID UUIDWithString:UUIDSTR_ISSC_TRANS_RX]]) {
            rx = c;
        }
        if ([c.UUID isEqual:[CBUUID UUIDWithString:UUIDSTR_ISSC_TRANS_TX]]) {
            tx = c;
        }
    }
    
    if (self.action == kGetData) {
        [self getBlueToothData:rx withTx:tx];
    }else if (self.action == kRemoveData){
        [self removeBlueToothData:rx withTx:tx];
    }
}

// 获取完整数据
-(void) getBlueToothData : (CBCharacteristic *) rx withTx : (CBCharacteristic*) tx{
    if (rx != nil && tx != nil) {
        Byte command[] = { 0x7D, 0x81, 0xA6, 0xFF, 0xFF };
        self.mutableData = [[NSMutableData alloc] init];
        self.analyesData = [[NSMutableArray alloc] init];
        NSData *data = [[NSData alloc] initWithBytes:command length:5];
        [self.peripheral setNotifyValue:YES forCharacteristic:rx];
        [self.peripheral writeValue: data forCharacteristic:tx type:CBCharacteristicWriteWithResponse];
    }
}

// 删除蓝牙数据
-(void) removeBlueToothData : (CBCharacteristic*) rx withTx : (CBCharacteristic*) tx{
    if (tx != nil) {
        Byte command[] = { 0x7D, 0x81, 0xAE, 0xFF, 0xFF };
        NSData *data = [[NSData alloc] initWithBytes:command length:5];
        [self.peripheral setNotifyValue:YES forCharacteristic:rx];
        [self.peripheral writeValue: data forCharacteristic:tx type:CBCharacteristicWriteWithResponse];
    }
}

// 监听数据
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    NSData *data = characteristic.value;
    [self.mutableData appendData:data];
    Byte *byteData = (Byte *)[self.mutableData bytes];
    
    if (self.action == kRemoveData) {
        // 删除完成
    }else{
        if (data.length == 4 && byteData[0] == 0x18) {
            // 无数据
        }else{
            for(int i=0;i<[self.mutableData length];i++){
                if ( byteData[i] == 0x18 ) {
                    [self analyes:self.mutableData];
                }
            }
        }
    }
}

// 分析数据
-(void) analyes : (NSMutableData *) data{
    Byte *bytes = (Byte *)[data bytes];
    for(int i=0;i<[data length];i++){
        if (bytes[i] == 0x07) {
            [self getDateWithByte:bytes withIndex:i];
            i += 7;
            continue;
        }
        if (bytes[i] == 0x12) {
            [self getTimeWithByte:bytes withIndex:i];
            i += 7;
            continue;
        }
        if (bytes[i] == 0x0F) {
            [self getDataWithByte:bytes withIndex:i];
            i += 7;
            continue;
        }
        if (bytes[i] == 0x18) {
            break;
        }
    }
}

// 获取日期
-(BOOL) getDateWithByte:(Byte *)bytes withIndex:(int)index{
    BOOL result = YES;
    NSInteger height = bytes[index+1];
    BlueToothDateData *date = [[BlueToothDateData alloc] init];
    
    NSInteger yearHeight = ( height >> 3 ) & 0x01;
    if (yearHeight == 1) {
        date.years = bytes[index + 4] + 128;
    }else{
        date.years = bytes[index + 4] - 128;
    }
    
    yearHeight = ( height >> 4 ) & 0x01;
    if (yearHeight == 1) {
        date.years = date.years * 100 + bytes[index + 5] + 128;
    }else{
        date.years = date.years * 100 + bytes[index + 5] - 128;
    }
    
    NSInteger monthHeight = ( height >> 5 ) & 0x01;
    if (monthHeight == 1) {
        date.month = bytes[index + 6] + 128;
    }else{
        date.month = bytes[index + 6] - 128;
    }
    
    NSInteger dayHeight = ( height >> 6 ) & 0x01;
    if (dayHeight == 1) {
        date.days = bytes[index + 7] + 128;
    }else{
        date.days = bytes[index + 7] - 128;
    }
    [self.analyesData addObject:date];
    return result;
}

// 获取时间
-(BOOL) getTimeWithByte : (Byte *) bytes withIndex : (int) index{
    BOOL result = YES;
    NSInteger height = bytes[index+1];
    BlueToothTimeData *time = [[BlueToothTimeData alloc] init];
    
    NSInteger hourHeight = ( height >> 3 ) & 0x01;
    if (hourHeight == 1) {
        time.hours = bytes[index + 4] + 128;
    }else{
        time.hours = bytes[index + 4] - 128;
    }
    
    NSInteger minHeight = ( height >> 4 ) & 0x01;
    if (minHeight == 1) {
        time.mins = bytes[index + 5] + 128;
    }else{
        time.mins = bytes[index + 5] - 128;
    }
    
    NSInteger secHeight = ( height >> 5 ) & 0x01;
    if (secHeight == 1) {
        time.sec = bytes[index + 6] + 128;
    }else{
        time.sec = bytes[index + 6] - 128;
    }
    [self.analyesData addObject:time];
    return result;
}

// 获取血氧、脉率数据
-(BOOL) getDataWithByte : (Byte *) bytes withIndex : (int) index{
    BOOL result = YES;
    
    NSInteger height = bytes[index+1];
    BlueToothData *data = [[BlueToothData alloc] init];
    
    for (int i = index + 2; i < index + 8; i++) {
        NSInteger dataHeight = (height >> (i - index - 1)) & 0x01;
        if (bytes[i] == 0x80) {
            break;
        }
        
        if (dataHeight == 1) {
            [data.data addObject:[NSNumber numberWithInteger:(bytes[i] + 128)]];
        }else{
            [data.data addObject:[NSNumber numberWithInteger:(bytes[i] - 128)]];
        }
    }
    [self.analyesData addObject:data];
    return result;
}
@end

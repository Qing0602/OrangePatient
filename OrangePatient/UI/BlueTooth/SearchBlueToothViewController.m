//
//  SearchBlueToothViewController.m
//  OrangeDoctor
//
//  Created by singlew on 15/3/4.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "SearchBlueToothViewController.h"

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
-(BOOL) getDateWithByte : (Byte *) bytes withIndex : (int) index;
-(BOOL) getTimeWithByte : (Byte *) bytes withIndex : (int) index;
-(BOOL) getDataWithByte : (Byte *) bytes withIndex : (int) index;
@end

@implementation SearchBlueToothViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mutableData = nil;
    self.central = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
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


// 发现设备
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    if (peripheral) {
        self.peripheral = peripheral;
        self.peripheral.delegate = self;
        [self.central connectPeripheral:peripheral options:@{CBConnectPeripheralOptionNotifyOnConnectionKey : @YES}];
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
    if (rx != nil && tx != nil) {
        Byte command[] = { 0x7D, 0x81, 0xA6, 0xFF, 0xFF };
        self.mutableData = [[NSMutableData alloc] init];
        self.analyesData = [[NSMutableArray alloc] init];
        NSData *adata = [[NSData alloc] initWithBytes:command length:5];
        [self.peripheral setNotifyValue:YES forCharacteristic:rx];
        [self.peripheral writeValue: adata forCharacteristic:tx type:CBCharacteristicWriteWithResponse];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    NSData *data = characteristic.value;
    [self.mutableData appendData:data];
    Byte *byteData = (Byte *)[self.mutableData bytes];
    
    for(int i=0;i<[self.mutableData length];i++){
        if ( byteData[i] == 0x18 ) {
            [self analyes:self.mutableData];
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

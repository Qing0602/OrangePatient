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
#define UUIDSTR_ISSC_TRANS_TX                   @"49535343-8841-43F4-A8D4-ECBE34729BB3"
// 读取特性的UUID
#define UUIDSTR_ISSC_TRANS_RX                   @"49535343-1E4D-4BD9-BA61-23C647249616"

@interface SearchBlueToothViewController ()

@end

@implementation SearchBlueToothViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.central = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        //发现设备后即可连接该设备 调用完该方法后会调用代理CBCentralManagerDelegate的- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral表示连接上了设别
        //如果不能连接会调用 - (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
        [self.central connectPeripheral:peripheral options:@{CBConnectPeripheralOptionNotifyOnConnectionKey : @YES}];
    }
}

// 连接设备成功
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    NSLog(@"yes");
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
            //[self.peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:kCharacteristicUUID]] forService:service];
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
        NSData *adata = [[NSData alloc] initWithBytes:command length:5];
        [self.peripheral setNotifyValue:YES forCharacteristic:rx];
        [self.peripheral writeValue: adata forCharacteristic:tx type:CBCharacteristicWriteWithResponse];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    NSData *data = characteristic.value;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"%@",dic);
}

-(void)getDeviceData:(NSDictionary *)dicDeviceData{
    NSLog(@"%@",dicDeviceData);
}

-(void)getOperateResult:(NSDictionary *)dicOperateResult{
    NSLog(@"1");
}

-(void)getError:(NSDictionary *)dicError{
    NSLog(@"1");
}

@end

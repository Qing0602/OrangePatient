//
//  BlueToothDataViewController.m
//  OrangePatient
//
//  Created by singlew on 15/3/19.
//  Copyright (c) 2015年 Orange. All rights reserved.
//


//服务的UUID
//#define UUIDSTR_ISSC_PROPRIETARY_SERVICE        @"49535343-FE7D-4AE5-8FA9-9FAFD2O5E455"
//#define UUIDSTR_CONNECTION_PARAMETER_CHAR       @"49535343-6DAA-4DO2-ABF6-19569ACA69FE"
//#define UUIDSTR_AIR_PATCH_CHAR                  @"49535343-ACA3-481C-91EC-D85E28A6O318"
#define UUIDSERVICE                             @"49535343-FE7D-4AE5-8FA9-9FAFD205E455"
// 写入的特性UUID
#define UUIDSTR_ISSC_TRANS_TX                   @"49535343-8841-43F4-A8D4-ECBE34729BB3"
// 读取特性的UUID
#define UUIDSTR_ISSC_TRANS_RX                   @"49535343-1E4D-4BD9-BA61-23C647249616"

#import "BlueToothDataViewController.h"
#import "UIModelCoding.h"
#import "UIManagement.h"
#import "BlueToothModel.h"

@interface BlueToothDataViewController ()
@property (nonatomic,strong) NSUUID *deviceUUID;
@property (nonatomic,strong) NSMutableData *mutableData;
@property (nonatomic,strong) CBPeripheral *peripheral;
@property (nonatomic,strong) CBCharacteristic *rx;
@property (nonatomic,strong) CBCharacteristic *tx;
@property (nonatomic,strong) BlueToothModel *currentModel;
@property (nonatomic) BlueOperationType BlueOperation;

// 二代表空间数量
@property (nonatomic) NSInteger count;

-(void) setData : (NSArray *)data;
-(void) getBlueToothData;
-(void) removeBlueToothData;
-(NSTimeInterval) getStartDate;
-(NSTimeInterval) getEndDate;
-(NSMutableArray *) formatData;

// 校对时间
-(void) updateDateTime;

// 获取二代血氧未读数量
-(void) getSPOCount;
// 获取二代血氧
-(void) getSPO;
// 继续获取血氧 -- 二代表
-(void) continueGetSPO;
// 解析二代血氧数据 -- 返回是否还有未读取数据
-(NSInteger) analyesSPO : (Byte *)bytes with : (NSInteger) head;
// 添加一组数据到血氧model
-(void) addDataToSPOModel;
// 分析卡路里数据
-(DataType) analysesSPO : (NSData *) data;
// 解析片段数据空间信息
-(NSInteger) analyesCount : (Byte *)bytes;
// 血氧数据获取完成
-(void) finishedSPO;

// 获取二代卡路里未读数量
-(void) getCaloriesCount;
// 获取二代卡路里单个数量
-(void) getCalories;
// 继续获取二代表卡路里数据
-(void) continueGetCalories;
// 获取二代连续卡路里数据
-(void) getBlockCalories;
// 添加一组数据到卡路里model
-(void) addDataToCaloriesModel;
// 分析卡路里数据
-(DataType) analysesCalories : (NSData *) data;
// 卡路里数据获取完成
-(void) finishedCalories;


// 获取二代脉搏波未读数据
-(void) getBPCount;
// 获取二代脉搏波单个数据
-(void) getBP;
// 继续获取二代脉搏波数据
-(void) continueGetBP;
// 获取二代连续脉搏波数据
-(void) getBlockBP;
// 添加一组数据到脉搏波model
-(void) addDataToBPModel;
// 分析脉搏波数据
-(DataType) analysesBP : (NSData *) data;
// 脉搏数据获取完成
-(void) finishedBP;


// 二代数据model
@property (nonatomic,strong) BlueToothModel2 *blueToothModel2;

@end

@implementation BlueToothDataViewController

-(id) initBlueToothDataVC : (NSUUID *) uuid{
    self = [super init];
    if (self != nil) {
        self.deviceUUID = uuid;
        NSMutableArray *uuidArray = [UIModelCoding deserializeModel:@"coreToothCache.cac"];
        for (BlueToothModel *model in uuidArray) {
            if ([model.sn isEqualToString:uuid.UUIDString]) {
                self.currentModel = model;
            }
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.BlueOperation = kNone;
    
    self.bgViewOne = [[UIView alloc] init];
    self.bgViewOne.translatesAutoresizingMaskIntoConstraints = NO;
    self.bgViewOne.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgViewOne];
    
    self.deviceImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DeviceImage"]];
    self.deviceImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self.bgViewOne addSubview:self.deviceImage];
    
    self.deviceName = [[UILabel alloc] init];
    self.deviceName.translatesAutoresizingMaskIntoConstraints = NO;
    self.deviceName.backgroundColor = [UIColor clearColor];
    self.deviceName.textAlignment = NSTextAlignmentLeft;
    self.deviceName.textColor = [UIColor blackColor];
    self.deviceName.font = [UIFont systemFontOfSize:17.0f];
    self.deviceName.text = @"动态血氧仪";
    [self.bgViewOne addSubview:self.deviceName];
    
    self.deviceDescription = [[UILabel alloc] init];
    self.deviceDescription.translatesAutoresizingMaskIntoConstraints = NO;
    self.deviceDescription.backgroundColor = [UIColor clearColor];
    self.deviceDescription.textAlignment = NSTextAlignmentLeft;
    self.deviceDescription.textColor = [UIColor colorWithHexString:@"#f38441"];
    self.deviceDescription.font = [UIFont boldSystemFontOfSize:12.0f];
    self.deviceDescription.text = self.currentModel.name;
    [self.bgViewOne addSubview:self.deviceDescription];
    
    self.state = [[UILabel alloc] init];
    self.state.translatesAutoresizingMaskIntoConstraints = NO;
    self.state.backgroundColor = [UIColor colorWithHexString:@"#28ab28"];
    self.state.textColor = [UIColor whiteColor];
    self.state.textAlignment = NSTextAlignmentCenter;
    self.state.font = [UIFont boldSystemFontOfSize:14.0f];
//    self.state.text = @"√\n传输成功";
    self.state.text = @"传输中...";
    self.state.numberOfLines = 2;
    [self.bgViewOne addSubview:self.state];
    
    NSDictionary *views = @{@"topLayoutGuide":self.topLayoutGuide,@"bgViewOne":self.bgViewOne,@"deviceImage":self.deviceImage,
                            @"deviceName":self.deviceName,@"deviceDescription":self.deviceDescription,@"state":self.state};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[bgViewOne]-0-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide]-10-[bgViewOne(81)]" options:0 metrics:nil views:views]];
    
    [self.bgViewOne addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[deviceImage(81)]-20-[deviceName(>=120)]-[state(91)]-0-|" options:0 metrics:nil views:views]];
    
    [self.bgViewOne addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[deviceImage]-20-[deviceDescription(>=120)]" options:0 metrics:nil views:views]];
    [self.bgViewOne addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[deviceName]-10-[deviceDescription]" options:0 metrics:nil views:views]];
    [self.bgViewOne addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[deviceImage(80)]" options:0 metrics:nil views:views]];
    [self.bgViewOne addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[state(80)]" options:0 metrics:nil views:views]];
    
    
    self.bgViewTwo = [[UIView alloc] init];
    self.bgViewTwo.translatesAutoresizingMaskIntoConstraints = NO;
    self.bgViewTwo.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgViewTwo];
    
    self.lineOne = [[UILabel alloc] init];
    self.lineOne.translatesAutoresizingMaskIntoConstraints = NO;
    self.lineOne.backgroundColor = [UIColor colorWithHexString:@"#ecebed"];
    [self.bgViewTwo addSubview:self.lineOne];
    
    self.lineTwo = [[UILabel alloc] init];
    self.lineTwo.translatesAutoresizingMaskIntoConstraints = NO;
    self.lineTwo.backgroundColor = [UIColor colorWithHexString:@"#ecebed"];
    [self.bgViewTwo addSubview:self.lineTwo];
    
    self.prNumber = [[UILabel alloc] init];
    self.prNumber.translatesAutoresizingMaskIntoConstraints = NO;
    self.prNumber.backgroundColor = [UIColor clearColor];
    self.prNumber.textAlignment = NSTextAlignmentCenter;
    self.prNumber.textColor = [UIColor colorWithHexString:@"#eb6100"];
    self.prNumber.font = [UIFont systemFontOfSize:41.0f];
    [self.bgViewTwo addSubview:self.prNumber];
    
    self.prName = [[UILabel alloc] init];
    self.prName.translatesAutoresizingMaskIntoConstraints = NO;
    self.prName.backgroundColor = [UIColor clearColor];
    self.prName.textAlignment = NSTextAlignmentCenter;
    self.prName.text = @"脉率 PR";
    self.prName.font = [UIFont systemFontOfSize:12.0f];
    [self.bgViewTwo addSubview:self.prName];
    
    self.spo2Number = [[UILabel alloc] init];
    self.spo2Number.translatesAutoresizingMaskIntoConstraints = NO;
    self.spo2Number.backgroundColor = [UIColor clearColor];
    self.spo2Number.textAlignment = NSTextAlignmentCenter;
    self.spo2Number.textColor = [UIColor colorWithHexString:@"#369af1"];
    self.spo2Number.font = [UIFont systemFontOfSize:41.0f];
    [self.bgViewTwo addSubview:self.spo2Number];
    
    self.spo2Name = [[UILabel alloc] init];
    self.spo2Name.translatesAutoresizingMaskIntoConstraints = NO;
    self.spo2Name.backgroundColor = [UIColor clearColor];
    self.spo2Name.textAlignment = NSTextAlignmentCenter;
    self.spo2Name.text = @"血氧饱和度 SPO2";
    self.spo2Name.font = [UIFont systemFontOfSize:12.0f];
    [self.bgViewTwo addSubview:self.spo2Name];
    
    self.bpNumber = [[UILabel alloc] init];
    self.bpNumber.translatesAutoresizingMaskIntoConstraints = NO;
    self.bpNumber.backgroundColor = [UIColor clearColor];
    self.bpNumber.textAlignment = NSTextAlignmentCenter;
    self.bpNumber.textColor = [UIColor colorWithHexString:@"#d5493c"];
    self.bpNumber.font = [UIFont systemFontOfSize:41.0f];
    [self.bgViewTwo addSubview:self.bpNumber];
    
    self.bpName = [[UILabel alloc] init];
    self.bpName.translatesAutoresizingMaskIntoConstraints = NO;
    self.bpName.backgroundColor = [UIColor clearColor];
    self.bpName.textAlignment = NSTextAlignmentCenter;
    self.bpName.text = @"血压 BP";
    self.bpName.font = [UIFont systemFontOfSize:12.0f];
    [self.bgViewTwo addSubview:self.bpName];
    
    self.caloriesNumber = [[UILabel alloc] init];
    self.caloriesNumber.translatesAutoresizingMaskIntoConstraints = NO;
    self.caloriesNumber.backgroundColor = [UIColor clearColor];
    self.caloriesNumber.textAlignment = NSTextAlignmentCenter;
    self.caloriesNumber.textColor = [UIColor colorWithHexString:@"#80ca00"];
    self.caloriesNumber.font = [UIFont systemFontOfSize:41.0f];
    [self.bgViewTwo addSubview:self.caloriesNumber];
    
    self.caloriesName = [[UILabel alloc] init];
    self.caloriesName.translatesAutoresizingMaskIntoConstraints = NO;
    self.caloriesName.backgroundColor = [UIColor clearColor];
    self.caloriesName.textAlignment = NSTextAlignmentCenter;
    self.caloriesName.text = @"卡路里 Calories";
    self.caloriesName.font = [UIFont systemFontOfSize:12.0f];
    [self.bgViewTwo addSubview:self.caloriesName];
    
    NSDictionary *viewsPart2 = NSDictionaryOfVariableBindings(_bgViewOne,_bgViewTwo,_lineOne,_lineTwo,_prNumber,_prName,_spo2Number,_spo2Name,_bpNumber,_bpName,_caloriesNumber,_caloriesName);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_bgViewTwo]-0-|" options:0 metrics:nil views:viewsPart2]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_bgViewOne]-10-[_bgViewTwo(191)]" options:0 metrics:nil views:viewsPart2]];
    
    [self.bgViewTwo addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_lineOne(1)]" options:0 metrics:nil views:viewsPart2]];
    [self.bgViewTwo addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_lineOne]-0-|" options:0 metrics:nil views:viewsPart2]];
    [self.bgViewTwo addConstraint:[NSLayoutConstraint constraintWithItem:self.lineOne attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.bgViewTwo attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.bgViewTwo addConstraint:[NSLayoutConstraint constraintWithItem:self.lineOne attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.bgViewTwo attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    [self.bgViewTwo addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_lineTwo]-0-|" options:0 metrics:nil views:viewsPart2]];
    [self.bgViewTwo addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_lineTwo(1)]" options:0 metrics:nil views:viewsPart2]];
    [self.bgViewTwo addConstraint:[NSLayoutConstraint constraintWithItem:self.lineTwo attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.bgViewTwo attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.bgViewTwo addConstraint:[NSLayoutConstraint constraintWithItem:self.lineTwo attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.bgViewTwo attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    [self.bgViewTwo addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_prNumber]-0-[_lineOne]-0-[_spo2Number]-0-|" options:0 metrics:nil views:viewsPart2]];
    [self.bgViewTwo addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_prName]-0-[_lineOne]-0-[_spo2Name]-0-|" options:0 metrics:nil views:viewsPart2]];
    [self.bgViewTwo addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_prNumber(62)]-0-[_prName]-0-[_lineTwo]" options:0 metrics:nil views:viewsPart2]];
    [self.bgViewTwo addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_spo2Number(62)]-0-[_spo2Name]-0-[_lineTwo]" options:0 metrics:nil views:viewsPart2]];
    
    [self.bgViewTwo addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_bpNumber]-0-[_lineOne]-0-[_caloriesNumber]-0-|" options:0 metrics:nil views:viewsPart2]];
    [self.bgViewTwo addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_bpName]-0-[_lineOne]-0-[_caloriesName]-0-|" options:0 metrics:nil views:viewsPart2]];
    [self.bgViewTwo addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_lineTwo]-0-[_bpNumber(62)]-0-[_bpName]-0-|" options:0 metrics:nil views:viewsPart2]];
    [self.bgViewTwo addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_lineTwo]-0-[_caloriesNumber(62)]-0-[_caloriesName]-0-|" options:0 metrics:nil views:viewsPart2]];
    
    [[UIManagement sharedInstance] addObserver:self forKeyPath:@"uploadMyDeviceData" options:0 context:nil];
    
    NSArray *oldData = [UIModelCoding deserializeModel:[NSString stringWithFormat:@"%@.cac",self.deviceUUID.UUIDString]];
    [self setData:oldData];
    [self updateDateTime];
}

-(void) setData : (NSArray *)data{
    if (data != nil) {
        BlueToothData *blueToothData = [data lastObject];
        self.spo2Number.text = [NSString stringWithFormat:@"%ld",(long)[blueToothData.data[0] integerValue]];
        self.prNumber.text = [NSString stringWithFormat:@"%ld",(long)[blueToothData.data[1] integerValue]];
        self.bpNumber.text = @"- -";
        self.caloriesNumber.text = @"- -";
    }else{
        self.spo2Number.text = @"- -";
        self.prNumber.text = @"- -";
        self.bpNumber.text = @"- -";
        self.caloriesNumber.text = @"- -";
    }
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.central = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
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

// 发现设备
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    if (peripheral) {
        
        if ([peripheral.identifier isEqual:self.deviceUUID]) {
            self.peripheral = peripheral;
            self.peripheral.delegate = self;
        }
        
        // 连接设备
        [self.central connectPeripheral:peripheral options:@{CBConnectPeripheralOptionNotifyOnConnectionKey : @YES}];
        [self.central stopScan];
    }
}


// 连接设备成功
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    NSRange foundObj202=[[peripheral.name uppercaseString] rangeOfString:@"SPO202" options:NSCaseInsensitiveSearch];
    NSRange foundObj209=[[peripheral.name uppercaseString] rangeOfString:@"SPO209" options:NSCaseInsensitiveSearch];
    if (foundObj202.length > 0) {
        self.deviceVersion = kSPO202;
    }else if (foundObj209.length > 0){
        self.deviceVersion = kSPO209;
        self.blueToothModel2 = [[BlueToothModel2 alloc] init];
    }else{
        [self showProgressWithText:@"未知设备" withDelayTime:2.0f];
        return;
    }
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
    
    for(CBCharacteristic *c in service.characteristics){
        if ([c.UUID isEqual:[CBUUID UUIDWithString:UUIDSTR_ISSC_TRANS_RX]]) {
            self.rx = c;
        }
        if ([c.UUID isEqual:[CBUUID UUIDWithString:UUIDSTR_ISSC_TRANS_TX]]) {
            self.tx = c;
        }
    }
    
    if (self.deviceVersion == kSPO202) {
        [self getBlueToothData];
    }else{
        [self getSPOCount];
//        [self getCalories];
    }
}

// 获取完整数据 -- 一代表
-(void) getBlueToothData{
    if (self.rx != nil && self.tx != nil) {
        self.BlueOperation = kGetBlueData;
        Byte command[] = { 0x7D, 0x81, 0xA6, 0xFF, 0xFF };
        self.mutableData = [[NSMutableData alloc] init];
        self.analyesData = [[NSMutableArray alloc] init];
        NSData *data = [[NSData alloc] initWithBytes:command length:5];
        [self.peripheral setNotifyValue:YES forCharacteristic:self.rx];
        [self.peripheral writeValue: data forCharacteristic:self.tx type:CBCharacteristicWriteWithResponse];
    }
}

// 删除蓝牙数据 -- 一代表
-(void) removeBlueToothData{
    if (self.tx != nil) {
        self.BlueOperation = kDeleteBlueData;
        Byte command[] = { 0x7D, 0x81, 0xAE, 0xFF, 0xFF };
        self.mutableData = [[NSMutableData alloc] init];
        NSData *data = [[NSData alloc] initWithBytes:command length:5];
        [self.peripheral setNotifyValue:YES forCharacteristic:self.rx];
        [self.peripheral writeValue: data forCharacteristic:self.tx type:CBCharacteristicWriteWithResponse];
    }
}



// 校对时间
-(void) updateDateTime{
    if (self.rx != nil && self.tx != nil) {
        NSDate *now = [NSDate date];
        
        Byte year = (now.year - 2000);
        NSInteger yearInt = now.year - 2000;
        
        Byte month = now.month;
        NSInteger monthInt = now.month;
        
        Byte day = now.day;
        NSInteger dayInt = now.day;
        
        Byte hour = now.hour + 8;
        NSInteger hourInt = now.hour;
        
        Byte mins = now.minute;
        NSInteger minsInt = now.minute;
        
        Byte second = now.seconds;
        NSInteger secondInt = now.seconds;
        
        NSInteger sum = yearInt + monthInt + dayInt + hourInt + minsInt + secondInt + 3;
        Byte temp = sum;
    
        Byte command[] = { 0x83, year, month, day, hour,mins,second,0x00,0x00,temp};
        NSData *data = [[NSData alloc] initWithBytes:command length:10];
        [self.peripheral setNotifyValue:YES forCharacteristic:self.rx];
        [self.peripheral writeValue: data forCharacteristic:self.tx type:CBCharacteristicWriteWithResponse];
    }
}



// 获取二代血氧未读数量
-(void) getSPOCount{
    if (self.rx != nil && self.tx != nil) {
        Byte command[] = { 0x90, 0x00, 0x10 };
        self.mutableData = [[NSMutableData alloc] init];
        NSData *data = [[NSData alloc] initWithBytes:command length:3];
        [self.peripheral setNotifyValue:YES forCharacteristic:self.rx];
        [self.peripheral writeValue: data forCharacteristic:self.tx type:CBCharacteristicWriteWithResponse];
    }
}

// 获取血氧 -- 二代表
-(void) getSPO{
    if (self.rx != nil && self.tx != nil) {
        Byte command[] = { 0x91, 0x00, 0x11 };
        self.mutableData = [[NSMutableData alloc] init];
        NSData *data = [[NSData alloc] initWithBytes:command length:3];
        [self.peripheral setNotifyValue:YES forCharacteristic:self.rx];
        [self.peripheral writeValue: data forCharacteristic:self.tx type:CBCharacteristicWriteWithResponse];
    }
}

// 继续获取血氧 -- 二代表
-(void) continueGetSPO{
    if (self.rx != nil && self.tx != nil) {
        Byte command[] = { 0x91, 0x01, 0x12 };
        NSData *data = [[NSData alloc] initWithBytes:command length:3];
        [self.peripheral setNotifyValue:YES forCharacteristic:self.rx];
        [self.peripheral writeValue: data forCharacteristic:self.tx type:CBCharacteristicWriteWithResponse];
    }
}

// 血氧数据获取完成
-(void) finishedSPO{
    if (self.rx != nil && self.tx != nil) {
        Byte command[] = { 0x91, 0x7F, 0x10 };
        NSData *data = [[NSData alloc] initWithBytes:command length:3];
        [self.peripheral setNotifyValue:YES forCharacteristic:self.rx];
        [self.peripheral writeValue: data forCharacteristic:self.tx type:CBCharacteristicWriteWithResponse];
    }
}




// 获取二代卡路里未读数量
-(void) getCaloriesCount{
    if (self.rx != nil && self.tx != nil) {
        Byte command[] = { 0x90, 0x01, 0x11 };
        self.mutableData = [[NSMutableData alloc] init];
        NSData *data = [[NSData alloc] initWithBytes:command length:3];
        [self.peripheral setNotifyValue:YES forCharacteristic:self.rx];
        [self.peripheral writeValue: data forCharacteristic:self.tx type:CBCharacteristicWriteWithResponse];
    }
}

// 获取二代卡路里单个数量
-(void) getCalories{
    if (self.rx != nil && self.tx != nil) {
        Byte command[] = { 0x92, 0x00, 0x12 };
        self.mutableData = [[NSMutableData alloc] init];
        NSData *data = [[NSData alloc] initWithBytes:command length:3];
        [self.peripheral setNotifyValue:YES forCharacteristic:self.rx];
        [self.peripheral writeValue: data forCharacteristic:self.tx type:CBCharacteristicWriteWithResponse];
    }
}

// 继续获取二代表卡路里数据
-(void) continueGetCalories{
    if (self.rx != nil && self.tx != nil) {
        Byte command[] = { 0x92, 0x01, 0x13 };
        self.mutableData = [[NSMutableData alloc] init];
        NSData *data = [[NSData alloc] initWithBytes:command length:3];
        [self.peripheral setNotifyValue:YES forCharacteristic:self.rx];
        [self.peripheral writeValue: data forCharacteristic:self.tx type:CBCharacteristicWriteWithResponse];
    }
}

// 获取二代连续卡路里数据
-(void) getBlockCalories{
    
}

// 卡路里数据获取完成
-(void) finishedCalories{
    if (self.rx != nil && self.tx != nil) {
        Byte command[] = { 0x92, 0x7F, 0x11 };
        self.mutableData = [[NSMutableData alloc] init];
        NSData *data = [[NSData alloc] initWithBytes:command length:3];
        [self.peripheral setNotifyValue:YES forCharacteristic:self.rx];
        [self.peripheral writeValue: data forCharacteristic:self.tx type:CBCharacteristicWriteWithResponse];
    }
}




// 获取二代脉搏波未读数据
-(void) getBPCount{
    if (self.rx != nil && self.tx != nil) {
        Byte command[] = { 0x90, 0x04, 0x14 };
        self.mutableData = [[NSMutableData alloc] init];
        NSData *data = [[NSData alloc] initWithBytes:command length:3];
        [self.peripheral setNotifyValue:YES forCharacteristic:self.rx];
        [self.peripheral writeValue: data forCharacteristic:self.tx type:CBCharacteristicWriteWithResponse];
    }
}

// 获取二代脉搏波单个数据
-(void) getBP{
    if (self.rx != nil && self.tx != nil) {
        Byte command[] = { 0x98, 0x00, 0x18 };
        self.mutableData = [[NSMutableData alloc] init];
        NSData *data = [[NSData alloc] initWithBytes:command length:3];
        [self.peripheral setNotifyValue:YES forCharacteristic:self.rx];
        [self.peripheral writeValue: data forCharacteristic:self.tx type:CBCharacteristicWriteWithResponse];
    }
}


// 继续获取二代脉搏波数据
-(void) continueGetBP{
    if (self.rx != nil && self.tx != nil) {
        Byte command[] = { 0x98, 0x01, 0x19 };
        self.mutableData = [[NSMutableData alloc] init];
        NSData *data = [[NSData alloc] initWithBytes:command length:3];
        [self.peripheral setNotifyValue:YES forCharacteristic:self.rx];
        [self.peripheral writeValue: data forCharacteristic:self.tx type:CBCharacteristicWriteWithResponse];
    }
}

// 获取二代连续脉搏波数据
-(void) getBlockBP{
    
}

// 脉搏数据获取完成
-(void) finishedBP{
    if (self.rx != nil && self.tx != nil) {
        Byte command[] = { 0x98, 0x7F, 0x17 };
        self.mutableData = [[NSMutableData alloc] init];
        NSData *data = [[NSData alloc] initWithBytes:command length:3];
        [self.peripheral setNotifyValue:YES forCharacteristic:self.rx];
        [self.peripheral writeValue: data forCharacteristic:self.tx type:CBCharacteristicWriteWithResponse];
    }
}


// 监听数据
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    if (self.deviceVersion == kSPO209) {
        NSData *data = characteristic.value;
        [self.mutableData appendData:data];
        Byte *bytes = (Byte *)[self.mutableData bytes];
        switch (bytes[0]) {
            case 0xD3:
                {
                    // 脉率血氧
                    DataType type = [self analysesSPO:self.mutableData];
                    if (type == kDataIsFinshed) {
                        // 接收一组完成，还有剩余数据
                        [self addDataToSPOModel];
                        [self continueGetSPO];
                    }else if(type == kDataIsOver){
                        // 接收全部完成,没有剩余数据
                        [self addDataToSPOModel];
                        
                    }else{
                        
                    }
                }
                break;
            case 0xE2:{
                // 卡路里
                DataType type = [self analysesCalories:self.mutableData];
                if (type == kDataIsFinshed) {
                    // 接收一组完成，还有剩余数据
                    [self addDataToCaloriesModel];
                    [self continueGetCalories];
                }else if(type == kDataIsOver){
                    // 接收全部完成,没有剩余数据
                    [self addDataToCaloriesModel];
                    
                }else{
                    
                }
            }
                break;
            case 0xF3:{
                // 校对时间
                if (bytes[1] == 0x00) {
                    NSLog(@"ok");
                }
            }
                break;
            case 0xE8:{
                // 脉搏波
                DataType type = [self analysesBP:self.mutableData];
                if (type == kDataIsFinshed) {
                    // 接收一组完成，还有剩余数据
                    [self addDataToBPModel];
                    [self continueGetBP];
                }else if(type == kDataIsOver){
                    // 接收全部完成,没有剩余数据
                    [self addDataToBPModel];
                    
                }else{
                    
                }
            }
                break;
            case 0xE0:
                {
                    self.count = [self analyesCount:bytes];
                    NSInteger type = bytes[1];
                    if (self.count > 0) {
                        if (type == 0) {
                            [self getSPO];
                        }else if (type == 1){
                            NSLog(@"C");
                        }
                    }
                }
                break;
            default:
                break;
        }
    }else{
        NSData *data = characteristic.value;
        [self.mutableData appendData:data];
        Byte *byteData = (Byte *)[self.mutableData bytes];
        if (self.BlueOperation == kGetBlueData) {
            if (data.length == 4 && byteData[0] == 0x18) {
                // 无数据
                self.state.text = @"无新数据";
            }else{
                for(int i=0;i<[self.mutableData length];i++){
                    if ( byteData[i] == 0x18 ) {
                        [self analyes:self.mutableData];
                        self.state.text = @"√\n传输成功";
                        if (data != nil) {
                            NSTimeInterval start = [self getStartDate];
                            NSTimeInterval end = start + [self getEndDate];
                            NSMutableArray *data = [self formatData];
                            NSDictionary *json = @{@"start_time":[NSNumber numberWithLong:start],@"end_time":[NSNumber numberWithLong:end],@"data_len":[NSNumber numberWithInteger:[data count]],@"data":data};
                            [[UIManagement sharedInstance] postDeviceData:start withEndTime:end withPeripheralID:self.currentModel.uuid withData:json];
                        }
                        break;
                    }
                }
            }
        }else if (self.BlueOperation == kDeleteBlueData){
            NSLog(@"删除数据 0b81");
        }
    }
}

-(NSTimeInterval) getStartDate{
    BlueToothDateData *dateData = self.analyesData[0];
    NSString *date = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)dateData.years,(long)dateData.month,(long)dateData.days];
    BlueToothTimeData *timeData = self.analyesData[1];
    NSString *time = [NSString stringWithFormat:@"%ld:%ld:%ld",(long)timeData.hours,(long)timeData.mins,(long)timeData.sec];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-M-d H:m:s"];
    NSString *temp = [NSString stringWithFormat:@"%@ %@",date,time];
    NSDate *destDate= [dateFormatter dateFromString:temp];
    return [destDate timeIntervalSince1970];
}

-(NSTimeInterval) getEndDate{
    NSInteger count = 0;
    for (int i = 2; i<[self.analyesData count]; i++) {
        BlueToothData *blueTooth = self.analyesData[i];
        count += [blueTooth.data count];
    }
    return count / 2 * 5;
}

-(NSMutableArray *) formatData{
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    for (int i = 2; i<[self.analyesData count]; i++) {
        BlueToothData *blueTooth = self.analyesData[i];
        for (NSNumber *number in blueTooth.data) {
            [dataArray addObject:number];
        }
    }
    
    if ([dataArray count] == 0) {
        return nil;
    }else{
        return dataArray;
    }
}

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"uploadMyDeviceData"]) {
        if ([[UIManagement sharedInstance].uploadMyDeviceData[ASI_REQUEST_HAS_ERROR] boolValue] == YES) {
            [self showProgressWithText:[UIManagement sharedInstance].uploadMyDeviceData[ASI_REQUEST_ERROR_MESSAGE] withDelayTime:3.0f];
        }else{
            [self showProgressWithText:@"上传数据完毕" withDelayTime:2.0f];
//            [self removeBlueToothData];
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
    [self setData:self.analyesData];
    [UIModelCoding serializeModel:self.analyesData withFileName:[NSString stringWithFormat:@"%@.cac",self.peripheral.identifier.UUIDString]];
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

// 解析二代血氧数据 -- 返回是否还有未读取数据
-(NSInteger) analyesSPO : (Byte *)bytes with : (NSInteger) head{
    NSInteger count = 0;
    NSInteger len = sizeof(bytes);
    for (int i = 0 ; i < len ; i++) {
        if (bytes[i] == head) {
            count += 1;
        }
    }
    return count;
}

// 解析片段数据空间信息
-(NSInteger) analyesCount : (Byte *)bytes{
    NSInteger count = 0;
    
    NSNumber *low = [NSNumber numberWithInteger:bytes[3]];
    NSNumber *high = [NSNumber numberWithInteger:bytes[4]];
    count = [high integerValue] * 128 + [low integerValue];
    return count;
}

// 分析卡路里数据
-(DataType) analysesCalories : (NSData *) data{
    DataType result = kDataIsNotFinsh;
    NSInteger len = [data length];
    NSInteger temp = len % 11;
    NSInteger count = len / 11;
    if (temp == 0 && count == 16) {
        // 数据完整，判断是否还有数据
        Byte *bytes = (Byte *)[data bytes];
        BOOL isOver = NO;
        for (int i = 1; i < len; i += 11) {
            NSInteger height = bytes[i];
            if (((height >> 6) & 0x01) == 1) {
                isOver = YES;
                break;
            }
        }
        if (isOver) {
            result = kDataIsOver;
        }else{
            result = kDataIsFinshed;
        }
    }else if(temp == 0 && count != 16){
        // 数据不满16包，判断是否还有数据
        Byte *bytes = (Byte *)[data bytes];
        BOOL isOver = NO;
        for (int i = 1; i < len; i += 11) {
            NSInteger height = bytes[i];
            if (((height >> 6) & 0x01) == 1) {
                isOver = YES;
                break;
            }
        }
        if (isOver) {
            result = kDataIsOver;
        }else{
            result = kDataIsNotFinsh;
        }
    }
    
    return result;
}

// 分析卡路里数据
-(DataType) analysesSPO : (NSData *) data{
    DataType result = kDataIsNotFinsh;
    NSInteger len = [data length];
    NSInteger temp = len % 11;
    NSInteger count = len / 11;
    if (temp == 0 && count == 16) {
        // 数据完整，判断是否还有数据
        Byte *bytes = (Byte *)[data bytes];
        BOOL isOver = NO;
        for (int i = 1; i < len; i += 11) {
            NSInteger height = bytes[i];
            if (((height >> 6) & 0x01) == 1) {
                isOver = YES;
                break;
            }
        }
        if (isOver) {
            result = kDataIsOver;
        }else{
            result = kDataIsFinshed;
        }
    }else if(temp == 0 && count != 16){
        // 数据不满16包，判断是否还有数据
        Byte *bytes = (Byte *)[data bytes];
        BOOL isOver = NO;
        for (int i = 1; i < len; i += 11) {
            NSInteger height = bytes[i];
            if (((height >> 6) & 0x01) == 1) {
                isOver = YES;
                break;
            }
        }
        if (isOver) {
            result = kDataIsOver;
        }else{
            result = kDataIsNotFinsh;
        }
    }
    
    return result;
}

// 分析脉搏波数据
-(DataType) analysesBP : (NSData *) data{
    DataType result = kDataIsNotFinsh;
    NSInteger len = [data length];
    NSInteger temp = len % 17;
    NSInteger count = len / 17;
    if (temp == 0 && count == 16) {
        // 数据完整，判断是否还有数据
        Byte *bytes = (Byte *)[data bytes];
        BOOL isOver = NO;
        for (int i = 1; i < len; i += 17) {
            NSInteger height = bytes[i];
            if (((height >> 6) & 0x01) == 1) {
                isOver = YES;
                break;
            }
        }
        if (isOver) {
            result = kDataIsOver;
        }else{
            result = kDataIsFinshed;
        }
    }else if(temp == 0 && count != 16){
        // 数据不满16包，判断是否还有数据
        Byte *bytes = (Byte *)[data bytes];
        BOOL isOver = NO;
        for (int i = 1; i < len; i += 17) {
            NSInteger height = bytes[i];
            if (((height >> 6) & 0x01) == 1) {
                isOver = YES;
                break;
            }
        }
        if (isOver) {
            result = kDataIsOver;
        }else{
            result = kDataIsNotFinsh;
        }
    }
    
    return result;
}

// 添加一组数据到卡路里model
-(void) addDataToCaloriesModel{
    for (NSInteger i = 0; i<[self.mutableData length]; i += 11) {
        NSData *data = [self.mutableData subdataWithRange:NSMakeRange(i * 11, 11)];
        [self.blueToothModel2.caloriesArray addObject:data];
    }
}

// 添加一组数据到血氧model
-(void) addDataToSPOModel{
    for (NSInteger i = 0; i<[self.mutableData length]; i += 11) {
        NSData *data = [self.mutableData subdataWithRange:NSMakeRange(i * 11, 11)];
        [self.blueToothModel2.spo2Array addObject:data];
    }
}

// 添加一组数据到脉搏波model
-(void) addDataToBPModel{
    for (NSInteger i = 0; i<[self.mutableData length]; i += 17) {
        NSData *data = [self.mutableData subdataWithRange:NSMakeRange(i * 17, 17)];
        [self.blueToothModel2.bpArray addObject:data];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) dealloc{
    [[UIManagement sharedInstance] removeObserver:self forKeyPath:@"uploadMyDeviceData"];
}

@end

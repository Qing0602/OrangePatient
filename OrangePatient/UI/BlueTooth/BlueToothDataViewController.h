//
//  BlueToothDataViewController.h
//  OrangePatient
//
//  Created by singlew on 15/3/19.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrangeBaseViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "BlueToothDateData.h"
#import "BlueToothTimeData.h"
#import "BlueToothData.h"
#import "BlueToothModel2.h"

typedef enum{
    kNone = 0,
    kGetBlueData,
    kDeleteBlueData,
}BlueOperationType;

typedef enum{
    kSPO202,
    kSPO209,
}DeviceVersion;

typedef enum{
    // 单独一组包未完成
    kDataIsNotFinsh,
    // 单独一组包传输完成
    kDataIsFinshed,
    // 所有数据接收完成
    kDataIsOver,
}DataType;

@interface BlueToothDataViewController : OrangeBaseViewController<CBCentralManagerDelegate,CBPeripheralDelegate>

@property (nonatomic,strong) CBCentralManager *central;
//√
@property (nonatomic,strong) UIView *bgViewOne;
@property (nonatomic,strong) UIImageView *deviceImage;
@property (nonatomic,strong) UILabel *deviceName;
@property (nonatomic,strong) UILabel *deviceDescription;
@property (nonatomic,strong) UILabel *state;

@property (nonatomic,strong) UIView *bgViewTwo;
@property (nonatomic,strong) UILabel *lineOne;
@property (nonatomic,strong) UILabel *lineTwo;
@property (nonatomic,strong) UILabel *prNumber;
@property (nonatomic,strong) UILabel *prName;
@property (nonatomic,strong) UILabel *spo2Number;
@property (nonatomic,strong) UILabel *spo2Name;
@property (nonatomic,strong) UILabel *bpNumber;
@property (nonatomic,strong) UILabel *bpName;
@property (nonatomic,strong) UILabel *caloriesNumber;
@property (nonatomic,strong) UILabel *caloriesName;

@property (nonatomic) DeviceVersion deviceVersion;

@property (nonatomic,strong) NSMutableArray *analyesData;
-(id) initBlueToothDataVC : (NSUUID *) uuid;
@end

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

@property (nonatomic,strong) NSMutableArray *analyesData;
-(id) initBlueToothDataVC : (NSUUID *) uuid;
@end

//
//  SearchBlueToothViewController.h
//  OrangeDoctor
//
//  Created by singlew on 15/3/4.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h> 
#import "DiscoveryDeviceTableViewCell.h"
#import "OrangeBaseViewController.h"
#import "BlueToothDataViewController.h"

@interface SearchBlueToothViewController : OrangeBaseViewController<CBCentralManagerDelegate,CBPeripheralDelegate,UITableViewDataSource,UITableViewDelegate,DiscoveryCellDelegate>
@property (nonatomic,strong) CBCentralManager *central;
//@property (nonatomic,strong) CBPeripheral *peripheral;

@property (nonatomic,strong) UILabel *deviceCount;
@property (nonatomic,strong) UITableView *deviceTableView;
@end

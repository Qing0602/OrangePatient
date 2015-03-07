//
//  SearchBlueToothViewController.h
//  OrangeDoctor
//
//  Created by singlew on 15/3/4.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h> 

@interface SearchBlueToothViewController : UIViewController<CBCentralManagerDelegate,CBPeripheralDelegate>
@property (nonatomic,strong) CBCentralManager *central;
@property (nonatomic,strong) CBPeripheral *peripheral;
@end

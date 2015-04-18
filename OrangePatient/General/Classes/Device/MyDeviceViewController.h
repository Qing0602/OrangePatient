//
//  MyDeviceViewController.h
//  OrangePatient
//
//  Created by singlew on 15/3/13.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrangeBaseViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "SearchBlueToothViewController.h"
#import "BlueToothDataViewController.h"

@interface MyDeviceViewController : OrangeBaseViewController<UITableViewDataSource,UITableViewDelegate>

@end

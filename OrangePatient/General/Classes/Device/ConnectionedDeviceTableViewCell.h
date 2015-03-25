//
//  ConnectionedDeviceTableViewCell.h
//  OrangePatient
//
//  Created by singlew on 15/3/17.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "BlueToothDataViewController.h"

@protocol ConnectionedCellDelegate <NSObject>

-(void) clickUnlockDevice : (CBPeripheral *) peripheral;

@end


@interface ConnectionedDeviceTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *deviceImage;
@property (nonatomic,strong) UILabel *deviceName;
@property (nonatomic,strong) UILabel *deviceDescription;
@property (nonatomic,strong) UIButton *deleteButton;

@property (nonatomic,strong) CBPeripheral *peripheral;
@property (nonatomic) id<ConnectionedCellDelegate> delegate;
-(void) setModel : (CBPeripheral *) model;
@end

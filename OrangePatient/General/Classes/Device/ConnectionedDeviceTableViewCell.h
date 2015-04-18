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
#import "BlueToothModel.h"

@protocol ConnectionedCellDelegate <NSObject>

-(void) clickUnlockDevice : (BlueToothModel *) peripheral;

@end


@interface ConnectionedDeviceTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *deviceImage;
@property (nonatomic,strong) UILabel *deviceName;
@property (nonatomic,strong) UILabel *deviceDescription;
@property (nonatomic,strong) UIButton *deleteButton;

@property (nonatomic,strong) BlueToothModel *peripheral;
@property (nonatomic) id<ConnectionedCellDelegate> delegate;
-(void) setModel : (BlueToothModel *) model;
@end

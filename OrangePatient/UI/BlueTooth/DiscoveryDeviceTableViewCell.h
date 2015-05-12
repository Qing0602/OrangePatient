//
//  DiscoveryDeviceTableViewCell.h
//  OrangePatient
//
//  Created by singlew on 15/3/18.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "BlueToothModel.h"

@protocol DiscoveryCellDelegate <NSObject>

-(void) clickAddDevice : (BlueToothModel *) peripheral;

@end

@interface DiscoveryDeviceTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *deviceImage;
@property (nonatomic,strong) UILabel *deviceName;
@property (nonatomic,strong) UILabel *deviceDescription;
@property (nonatomic,strong) UIButton *addDevice;
@property (nonatomic,strong) UILabel *lineThree;

@property (nonatomic,strong) BlueToothModel *peripheral;

@property (nonatomic) id<DiscoveryCellDelegate> delegate;

-(void) setModel : (BlueToothModel *) peripheral;
@end

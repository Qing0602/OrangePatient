//
//  DiscoveryDeviceTableViewCell.h
//  OrangePatient
//
//  Created by singlew on 15/3/18.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscoveryDeviceTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *bgImage;
@property (nonatomic,strong) UIImageView *deviceImage;
@property (nonatomic,strong) UILabel *deviceName;
@property (nonatomic,strong) UILabel *deviceDescription;
@property (nonatomic,strong) UIButton *addDevice;
@end

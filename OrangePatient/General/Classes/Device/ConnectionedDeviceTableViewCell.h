//
//  ConnectionedDeviceTableViewCell.h
//  OrangePatient
//
//  Created by singlew on 15/3/17.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConnectionedDeviceTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *deviceImage;
@property (nonatomic,strong) UILabel *deviceName;
@property (nonatomic,strong) UILabel *deviceDescription;
@property (nonatomic,strong) UIButton *deleteButton;
-(void) setModel : (id) model;
@end

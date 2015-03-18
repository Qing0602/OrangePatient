//
//  DiscoveryDeviceTableViewCell.m
//  OrangePatient
//
//  Created by singlew on 15/3/18.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "DiscoveryDeviceTableViewCell.h"

@implementation DiscoveryDeviceTableViewCell

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        self.bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SearchDeviceCellBg"]];
//        self.bgImage.frame = CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, 207);
        self.bgImage.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.bgImage];
        
        
        self.deviceImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DeviceImage"]];
        self.deviceImage.translatesAutoresizingMaskIntoConstraints = NO;
        [self.bgImage addSubview:self.deviceImage];
        
        self.deviceName = [[UILabel alloc] init];
        self.deviceName.translatesAutoresizingMaskIntoConstraints = NO;
        self.deviceName.backgroundColor = [UIColor clearColor];
        self.deviceName.numberOfLines = 1;
        [self.bgImage addSubview:self.deviceName];
        
        self.deviceDescription = [[UILabel alloc] init];
        self.deviceDescription.translatesAutoresizingMaskIntoConstraints = NO;
        self.deviceDescription.backgroundColor = [UIColor clearColor];
        self.deviceDescription.numberOfLines = 1;
        [self.bgImage addSubview:self.deviceDescription];
        
        self.addDevice = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.addDevice setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self.addDevice setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
        self.addDevice.titleLabel.textColor = [UIColor blackColor];
        [self.addDevice setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.addDevice setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [self.bgImage addSubview:self.addDevice];
        
    }
    return self;
}

-(void) layoutSubviews{
    [super layoutSubviews];
    NSDictionary *views = NSDictionaryOfVariableBindings(_bgImage,_deviceImage,_deviceName,_deviceDescription,_addDevice);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_bgImage]-0-|" options:0 metrics:0 views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_bgImage]-0-|" options:0 metrics:0 views:views]];
    
    [self.bgImage addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_deviceImage(87)]-10-[_deviceName(120)]" options:0 metrics:nil views:views]];
    [self.bgImage addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_deviceImage(90)]" options:0 metrics:nil views:views]];
    [self.bgImage addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_deviceDescription(120)]" options:0 metrics:nil views:views]];
    [self.bgImage addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_deviceName]-15-[_deviceDescription]" options:NSLayoutFormatAlignAllLeft metrics:0 views:views]];
    
    self.addDevice.frame = CGRectMake(SCREEN_WIDTH - 80.0f - 10.0f, 20.0f, 80.0f, 40.0f);
}

-(void) setModel : (CBPeripheral *) peripheral{
    if (peripheral != nil) {
        self.deviceName.text = @"动态血氧仪";
        self.deviceDescription.text = peripheral.name;
        self.peripheral = peripheral;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

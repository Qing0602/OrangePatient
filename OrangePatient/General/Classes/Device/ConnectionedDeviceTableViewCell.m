//
//  ConnectionedDeviceTableViewCell.m
//  OrangePatient
//
//  Created by singlew on 15/3/17.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "ConnectionedDeviceTableViewCell.h"

@implementation ConnectionedDeviceTableViewCell

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        self.deviceImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DeviceImage"]];
        self.deviceImage.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.deviceImage];
        
        self.deviceName = [[UILabel alloc] init];
        self.deviceName.translatesAutoresizingMaskIntoConstraints = NO;
        self.deviceName.backgroundColor = [UIColor clearColor];
        self.deviceName.numberOfLines = 1;
        [self addSubview:self.deviceName];
        
        self.deviceDescription = [[UILabel alloc] init];
        self.deviceDescription.translatesAutoresizingMaskIntoConstraints = NO;
        self.deviceDescription.backgroundColor = [UIColor clearColor];
        self.deviceDescription.numberOfLines = 1;
        [self addSubview:self.deviceDescription];
        
        self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.deleteButton setTitle:@"解除绑定" forState:UIControlStateNormal];
        [self.deleteButton setTitle:@"解除绑定" forState:UIControlStateHighlighted];
        self.deleteButton.titleLabel.textColor = [UIColor blackColor];
        [self.deleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.deleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [self addSubview:self.deleteButton];
    }
    return self;
}

-(void) layoutSubviews{
    [super layoutSubviews];
    NSDictionary *views = NSDictionaryOfVariableBindings(_deviceImage,_deviceName,_deviceDescription,_deleteButton);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_deviceImage(81)]-10-[_deviceName(120)]" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_deviceImage(80)]" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_deviceDescription(120)]" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_deviceName]-15-[_deviceDescription]" options:NSLayoutFormatAlignAllLeft metrics:0 views:views]];
    
    self.deleteButton.frame = CGRectMake(SCREEN_WIDTH - 80.0f - 10.0f, 20.0f, 80.0f, 40.0f);
}

-(void) setModel:(CBPeripheral *)model{
    if (model != nil) {
        self.deviceName.text = @"动态血氧仪";
        self.deviceDescription.text = model.name;
        self.peripheral = model;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

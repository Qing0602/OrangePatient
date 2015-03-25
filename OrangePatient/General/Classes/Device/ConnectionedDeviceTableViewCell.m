//
//  ConnectionedDeviceTableViewCell.m
//  OrangePatient
//
//  Created by singlew on 15/3/17.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "ConnectionedDeviceTableViewCell.h"

@interface ConnectionedDeviceTableViewCell ()
-(void) unlockDevice;
@end

@implementation ConnectionedDeviceTableViewCell

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        
        self.deviceImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"UnlockDeviceImage"]];
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
        self.deviceDescription.textColor = [UIColor orangeColor];
        self.deviceDescription.font = [UIFont systemFontOfSize:13.0f];
        [self addSubview:self.deviceDescription];
        
        self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.deleteButton setImage:[UIImage imageNamed:@"UnlockDevice"] forState:UIControlStateNormal];
        [self.deleteButton setImage:[UIImage imageNamed:@"UnlockDevice"] forState:UIControlStateHighlighted];
        [self.deleteButton addTarget:self action:@selector(unlockDevice) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.deleteButton];
    }
    return self;
}

-(void) layoutSubviews{
    [super layoutSubviews];
    NSDictionary *views = NSDictionaryOfVariableBindings(_deviceImage,_deviceName,_deviceDescription,_deleteButton);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_deviceImage(83)]-10-[_deviceName(120)]" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_deviceImage(83.5)]" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_deviceDescription(120)]" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-12-[_deviceName]-10-[_deviceDescription]" options:NSLayoutFormatAlignAllLeft metrics:0 views:views]];
    
    self.deleteButton.frame = CGRectMake(SCREEN_WIDTH - 80.0f - 10.0f, 20.0f, 83.0f, 28.5f);
}

-(void) setModel:(CBPeripheral *)model{
    if (model != nil) {
        self.deviceName.text = @"动态血氧仪";
        self.deviceDescription.text = model.name;
        self.peripheral = model;
    }
}

-(void) unlockDevice{
    if (self.delegate != nil) {
        if ([self.delegate respondsToSelector:@selector(clickUnlockDevice:)]) {
            [self.delegate clickUnlockDevice:self.peripheral];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

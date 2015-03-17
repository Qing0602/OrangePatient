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
        self.deviceName.text = @"1111111";
        self.deviceName.backgroundColor = [UIColor redColor];
        self.deviceName.numberOfLines = 1;
        [self addSubview:self.deviceName];
        
        self.deviceDescription = [[UILabel alloc] init];
        self.deviceDescription.translatesAutoresizingMaskIntoConstraints = NO;
        self.deviceDescription.backgroundColor = [UIColor clearColor];
        self.deviceDescription.numberOfLines = 1;
        self.deviceDescription.backgroundColor = [UIColor greenColor];
        self.deviceDescription.text = @"222222";
        [self addSubview:self.deviceDescription];
        
        self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.deleteButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self.deleteButton setTitle:@"解除绑定" forState:UIControlStateNormal];
        [self.deleteButton setTitle:@"解除绑定" forState:UIControlStateHighlighted];
        self.deleteButton.titleLabel.textColor = [UIColor blackColor];
        self.deleteButton.tintColor = [UIColor blackColor];
        self.deleteButton.backgroundColor = [UIColor greenColor];
        [self addSubview:self.deleteButton];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_deviceImage,_deviceName,_deviceDescription,_deleteButton);
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_deviceImage(87)]-10-[_deviceName(120)]" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_deleteButton(40)]-10-|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_deviceName]-15-[_deviceDescription]" options:NSLayoutFormatAlignAllLeft metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_deviceImage(90)]" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_deleteButton(40)]" options:0 metrics:nil views:views]];
//        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.deleteButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        [self needsUpdateConstraints];
    }
    return self;
}

-(void) setModel:(id)model{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

//
//  DiscoveryDeviceTableViewCell.m
//  OrangePatient
//
//  Created by singlew on 15/3/18.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "DiscoveryDeviceTableViewCell.h"

@interface DiscoveryDeviceTableViewCell ()
-(void) clickAddDevice;
@end

@implementation DiscoveryDeviceTableViewCell

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        
        self.topLable = [[UILabel alloc] init];
        self.topLable.translatesAutoresizingMaskIntoConstraints = NO;
        self.topLable.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
        [self addSubview:self.topLable];
        
        self.deviceImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DeviceImage"]];
        self.deviceImage.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.deviceImage];
        
        self.deviceName = [[UILabel alloc] init];
        self.deviceName.translatesAutoresizingMaskIntoConstraints = NO;
        self.deviceName.backgroundColor = [UIColor clearColor];
        self.deviceName.font = [UIFont boldSystemFontOfSize:15.0f];
        self.deviceName.numberOfLines = 1;
        [self addSubview:self.deviceName];
        
        self.deviceDescription = [[UILabel alloc] init];
        self.deviceDescription.translatesAutoresizingMaskIntoConstraints = NO;
        self.deviceDescription.backgroundColor = [UIColor clearColor];
        self.deviceDescription.font = [UIFont systemFontOfSize:13.0f];
        self.deviceDescription.textColor = [UIColor orangeColor];
        self.deviceDescription.numberOfLines = 1;
        [self addSubview:self.deviceDescription];
        
        self.addDevice = [UIButton buttonWithType:UIButtonTypeCustom];
        self.addDevice.translatesAutoresizingMaskIntoConstraints = NO;
        [self.addDevice setImage:[UIImage imageNamed:@"AddDevice"] forState:UIControlStateNormal];
        [self.addDevice setImage:[UIImage imageNamed:@"AddDevice"] forState:UIControlStateHighlighted];
        [self.addDevice addTarget:self action:@selector(clickAddDevice) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.addDevice];
        
        self.lineOne = [[UILabel alloc] init];
        self.lineOne.translatesAutoresizingMaskIntoConstraints = NO;
        self.lineOne.backgroundColor = [UIColor colorWithHexString:@"#e3e3e5"];
        [self addSubview:self.lineOne];
        
        self.lineTwo = [[UILabel alloc] init];
        self.lineTwo.translatesAutoresizingMaskIntoConstraints = NO;
        self.lineTwo.backgroundColor = [UIColor colorWithHexString:@"#e3e3e5"];
        [self addSubview:self.lineTwo];
        
        self.lineThree = [[UILabel alloc] init];
        self.lineThree.translatesAutoresizingMaskIntoConstraints = NO;
        self.lineThree.backgroundColor = [UIColor colorWithHexString:@"#c8c7cc"];
        [self addSubview:self.lineThree];
    }
    return self;
}

-(void) layoutSubviews{
    [super layoutSubviews];
    NSDictionary *views = NSDictionaryOfVariableBindings(_topLable,_deviceImage,_deviceName,_deviceDescription,_addDevice,_lineOne,_lineTwo,_lineThree);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_topLable]-0-|" options:0 metrics:0 views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_deviceImage(81)]-10-[_deviceName(120)]" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_topLable(11)]-0-[_deviceImage(80)]-0-[_lineOne(1)]-0-[_lineTwo(45)]" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_lineOne]-0-|" options:0 metrics:nil views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_deviceDescription(120)]" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[_deviceName]-15-[_deviceDescription]" options:NSLayoutFormatAlignAllLeft metrics:0 views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_lineTwo(1)]-1-[_addDevice(180)]" options:0 metrics:nil views:views]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.lineTwo attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_lineOne]-0-[_addDevice(43.5)]" options:0 metrics:nil views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_lineThree]-0-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_lineThree(2)]-0-|" options:0 metrics:nil views:views]];
}

-(void) clickAddDevice{
    if (self.delegate != nil) {
        if ([self.delegate respondsToSelector:@selector(clickAddDevice:)]) {
            [self.delegate clickAddDevice:self.peripheral];
        }
    }
}

-(void) setModel : (BlueToothModel *) peripheral{
    if (peripheral != nil) {
        self.deviceName.text = peripheral.name;
        self.deviceDescription.text = peripheral.spID;
        self.peripheral = peripheral;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

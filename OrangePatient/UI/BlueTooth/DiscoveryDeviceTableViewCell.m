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
        self.addDevice.backgroundColor = [UIColor colorWithHexString:@"#eb6100"];
        [self.addDevice setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.addDevice setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [self.addDevice setTitle:@"添加" forState:UIControlStateNormal];
        [self.addDevice setTitle:@"添加" forState:UIControlStateHighlighted];
        [self.addDevice addTarget:self action:@selector(clickAddDevice) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.addDevice];
        
        self.lineThree = [[UILabel alloc] init];
        self.lineThree.translatesAutoresizingMaskIntoConstraints = NO;
        self.lineThree.backgroundColor = [UIColor colorWithHexString:@"#c8c7cc"];
        [self addSubview:self.lineThree];
    }
    return self;
}

-(void) layoutSubviews{
    [super layoutSubviews];
    NSDictionary *views = NSDictionaryOfVariableBindings(_deviceImage,_deviceName,_deviceDescription,_addDevice,_lineThree);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_deviceImage(81)]-10-[_deviceName(120)]" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_deviceImage(80)]" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_deviceImage(81)]-10-[_deviceDescription(120)]" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[_deviceName]-15-[_deviceDescription]" options:NSLayoutFormatAlignAllLeft metrics:0 views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_addDevice(60)]-16-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_addDevice(25)]" options:0 metrics:nil views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_lineThree]-0-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_deviceImage(81)]-0-[_lineThree(2)]" options:0 metrics:nil views:views]];
}

-(void) clickAddDevice{
    if (self.peripheral.isAdd) {
        return;
    }
    if (self.delegate != nil) {
        if ([self.delegate respondsToSelector:@selector(clickAddDevice:)]) {
            [self.delegate clickAddDevice:self.peripheral];
        }
    }
}

-(void) setModel : (BlueToothModel *) peripheral{
    if (peripheral != nil) {
        self.deviceName.text = @"动态血氧仪";
        self.deviceDescription.text = peripheral.name;
        self.peripheral = peripheral;
        if (peripheral.isAdd) {
            [self.addDevice setImage:nil forState:UIControlStateNormal];
            [self.addDevice setImage:nil forState:UIControlStateHighlighted];
            [self.addDevice setTitle:@"已添加" forState:UIControlStateNormal];
            [self.addDevice setTitle:@"已添加" forState:UIControlStateHighlighted];
        }else{
            [self.addDevice setTitle:@"添加" forState:UIControlStateNormal];
            [self.addDevice setTitle:@"添加" forState:UIControlStateHighlighted];
            [self.addDevice setImage:[UIImage imageNamed:@"AddDevice"] forState:UIControlStateNormal];
            [self.addDevice setImage:[UIImage imageNamed:@"AddDevice"] forState:UIControlStateHighlighted];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

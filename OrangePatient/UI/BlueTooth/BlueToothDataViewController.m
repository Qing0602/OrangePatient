//
//  BlueToothDataViewController.m
//  OrangePatient
//
//  Created by singlew on 15/3/19.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "BlueToothDataViewController.h"

@interface BlueToothDataViewController ()
@property (nonatomic,strong) CBPeripheral *peripheralDevice;
@end

@implementation BlueToothDataViewController

-(id) initBlueToothDataVC : (CBPeripheral *) peripheral{
    self = [super init];
    if (self != nil) {
        self.peripheralDevice = peripheral;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bgViewOne = [[UIView alloc] init];
    self.bgViewOne.translatesAutoresizingMaskIntoConstraints = NO;
    self.bgViewOne.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgViewOne];
    
    self.deviceImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DeviceImage"]];
    self.deviceImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self.bgViewOne addSubview:self.deviceImage];
    
    self.deviceName = [[UILabel alloc] init];
    self.deviceName.translatesAutoresizingMaskIntoConstraints = NO;
    self.deviceName.backgroundColor = [UIColor clearColor];
    self.deviceName.textAlignment = NSTextAlignmentLeft;
    self.deviceName.textColor = [UIColor blackColor];
    self.deviceName.font = [UIFont systemFontOfSize:17.0f];
    self.deviceName.text = @"动态血氧仪";
    [self.bgViewOne addSubview:self.deviceName];
    
    self.deviceDescription = [[UILabel alloc] init];
    self.deviceDescription.translatesAutoresizingMaskIntoConstraints = NO;
    self.deviceDescription.backgroundColor = [UIColor clearColor];
    self.deviceDescription.textAlignment = NSTextAlignmentLeft;
    self.deviceDescription.textColor = [UIColor colorWithHexString:@"#f38441"];
    self.deviceDescription.font = [UIFont boldSystemFontOfSize:12.0f];
    self.deviceDescription.text = @"002200";
    [self.bgViewOne addSubview:self.deviceDescription];
    
    self.state = [[UILabel alloc] init];
    self.state.translatesAutoresizingMaskIntoConstraints = NO;
    self.state.backgroundColor = [UIColor colorWithHexString:@"#28ab28"];
    self.state.textColor = [UIColor whiteColor];
    self.state.textAlignment = NSTextAlignmentCenter;
    self.state.font = [UIFont boldSystemFontOfSize:14.0f];
    self.state.text = @"√\n传输成功";
    self.state.numberOfLines = 2;
    [self.bgViewOne addSubview:self.state];
    
    NSDictionary *views = @{@"topLayoutGuide":self.topLayoutGuide,@"bgViewOne":self.bgViewOne,@"deviceImage":self.deviceImage,
                            @"deviceName":self.deviceName,@"deviceDescription":self.deviceDescription,@"state":self.state};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[bgViewOne]-0-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide]-10-[bgViewOne(81)]" options:0 metrics:nil views:views]];
    
    [self.bgViewOne addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[deviceImage(81)]-20-[deviceName(>=120)]-[state(91)]-0-|" options:0 metrics:nil views:views]];
    
    [self.bgViewOne addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[deviceImage]-20-[deviceDescription(>=120)]" options:0 metrics:nil views:views]];
    [self.bgViewOne addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[deviceName]-10-[deviceDescription]" options:0 metrics:nil views:views]];
    [self.bgViewOne addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[deviceImage(80)]" options:0 metrics:nil views:views]];
    [self.bgViewOne addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[state(80)]" options:0 metrics:nil views:views]];
    
    
    self.bgViewTwo = [[UIView alloc] init];
    self.bgViewTwo.translatesAutoresizingMaskIntoConstraints = NO;
    self.bgViewTwo.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgViewTwo];
    
    self.lineOne = [[UILabel alloc] init];
    self.lineOne.translatesAutoresizingMaskIntoConstraints = NO;
    self.lineOne.backgroundColor = [UIColor colorWithHexString:@"#ecebed"];
    [self.bgViewTwo addSubview:self.lineOne];
    
    self.lineTwo = [[UILabel alloc] init];
    self.lineTwo.translatesAutoresizingMaskIntoConstraints = NO;
    self.lineTwo.backgroundColor = [UIColor colorWithHexString:@"#ecebed"];
    [self.bgViewTwo addSubview:self.lineTwo];
    
    self.prNumber = [[UILabel alloc] init];
    self.prNumber.translatesAutoresizingMaskIntoConstraints = NO;
    self.prNumber.backgroundColor = [UIColor clearColor];
    self.prNumber.textAlignment = NSTextAlignmentCenter;
    self.prNumber.textColor = [UIColor colorWithHexString:@"#eb6100"];
    self.prNumber.font = [UIFont systemFontOfSize:41.0f];
    self.prNumber.text = @"68";
    [self.bgViewTwo addSubview:self.prNumber];
    
    self.prName = [[UILabel alloc] init];
    self.prName.translatesAutoresizingMaskIntoConstraints = NO;
    self.prName.backgroundColor = [UIColor clearColor];
    self.prName.textAlignment = NSTextAlignmentCenter;
    self.prName.text = @"脉率 PR";
    self.prName.font = [UIFont systemFontOfSize:12.0f];
    [self.bgViewTwo addSubview:self.prName];
    
    self.spo2Number = [[UILabel alloc] init];
    self.spo2Number.translatesAutoresizingMaskIntoConstraints = NO;
    self.spo2Number.backgroundColor = [UIColor clearColor];
    self.spo2Number.textAlignment = NSTextAlignmentCenter;
    self.spo2Number.textColor = [UIColor colorWithHexString:@"#369af1"];
    self.spo2Number.font = [UIFont systemFontOfSize:41.0f];
    self.spo2Number.text = @"98";
    [self.bgViewTwo addSubview:self.spo2Number];
    
    self.spo2Name = [[UILabel alloc] init];
    self.spo2Name.translatesAutoresizingMaskIntoConstraints = NO;
    self.spo2Name.backgroundColor = [UIColor clearColor];
    self.spo2Name.textAlignment = NSTextAlignmentCenter;
    self.spo2Name.text = @"血氧饱和度 SPO2";
    self.spo2Name.font = [UIFont systemFontOfSize:12.0f];
    [self.bgViewTwo addSubview:self.spo2Name];
    
    self.bpNumber = [[UILabel alloc] init];
    self.bpNumber.translatesAutoresizingMaskIntoConstraints = NO;
    self.bpNumber.backgroundColor = [UIColor clearColor];
    self.bpNumber.textAlignment = NSTextAlignmentCenter;
    self.bpNumber.textColor = [UIColor colorWithHexString:@"#d5493c"];
    self.bpNumber.font = [UIFont systemFontOfSize:41.0f];
    self.bpNumber.text = @"67/113";
    [self.bgViewTwo addSubview:self.bpNumber];
    
    self.bpName = [[UILabel alloc] init];
    self.bpName.translatesAutoresizingMaskIntoConstraints = NO;
    self.bpName.backgroundColor = [UIColor clearColor];
    self.bpName.textAlignment = NSTextAlignmentCenter;
    self.bpName.text = @"血压 BP";
    self.bpName.font = [UIFont systemFontOfSize:12.0f];
    [self.bgViewTwo addSubview:self.bpName];
    
    self.caloriesNumber = [[UILabel alloc] init];
    self.caloriesNumber.translatesAutoresizingMaskIntoConstraints = NO;
    self.caloriesNumber.backgroundColor = [UIColor clearColor];
    self.caloriesNumber.textAlignment = NSTextAlignmentCenter;
    self.caloriesNumber.textColor = [UIColor colorWithHexString:@"#80ca00"];
    self.caloriesNumber.font = [UIFont systemFontOfSize:41.0f];
    self.caloriesNumber.text = @"2.29";
    [self.bgViewTwo addSubview:self.caloriesNumber];
    
    self.caloriesName = [[UILabel alloc] init];
    self.caloriesName.translatesAutoresizingMaskIntoConstraints = NO;
    self.caloriesName.backgroundColor = [UIColor clearColor];
    self.caloriesName.textAlignment = NSTextAlignmentCenter;
    self.caloriesName.text = @"卡路里 Calories";
    self.caloriesName.font = [UIFont systemFontOfSize:12.0f];
    [self.bgViewTwo addSubview:self.caloriesName];
    
    NSDictionary *viewsPart2 = NSDictionaryOfVariableBindings(_bgViewOne,_bgViewTwo,_lineOne,_lineTwo,_prNumber,_prName,_spo2Number,_spo2Name,_bpNumber,_bpName,_caloriesNumber,_caloriesName);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_bgViewTwo]-0-|" options:0 metrics:nil views:viewsPart2]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_bgViewOne]-10-[_bgViewTwo(191)]" options:0 metrics:nil views:viewsPart2]];
    
    [self.bgViewTwo addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_lineOne(1)]" options:0 metrics:nil views:viewsPart2]];
    [self.bgViewTwo addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_lineOne]-0-|" options:0 metrics:nil views:viewsPart2]];
    [self.bgViewTwo addConstraint:[NSLayoutConstraint constraintWithItem:self.lineOne attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.bgViewTwo attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.bgViewTwo addConstraint:[NSLayoutConstraint constraintWithItem:self.lineOne attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.bgViewTwo attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    [self.bgViewTwo addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_lineTwo]-0-|" options:0 metrics:nil views:viewsPart2]];
    [self.bgViewTwo addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_lineTwo(1)]" options:0 metrics:nil views:viewsPart2]];
    [self.bgViewTwo addConstraint:[NSLayoutConstraint constraintWithItem:self.lineTwo attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.bgViewTwo attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.bgViewTwo addConstraint:[NSLayoutConstraint constraintWithItem:self.lineTwo attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.bgViewTwo attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    [self.bgViewTwo addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_prNumber]-0-[_lineOne]-0-[_spo2Number]-0-|" options:0 metrics:nil views:viewsPart2]];
    [self.bgViewTwo addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_prName]-0-[_lineOne]-0-[_spo2Name]-0-|" options:0 metrics:nil views:viewsPart2]];
    [self.bgViewTwo addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_prNumber(62)]-0-[_prName]-0-[_lineTwo]" options:0 metrics:nil views:viewsPart2]];
    [self.bgViewTwo addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_spo2Number(62)]-0-[_spo2Name]-0-[_lineTwo]" options:0 metrics:nil views:viewsPart2]];
    
    [self.bgViewTwo addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_bpNumber]-0-[_lineOne]-0-[_caloriesNumber]-0-|" options:0 metrics:nil views:viewsPart2]];
    [self.bgViewTwo addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_bpName]-0-[_lineOne]-0-[_caloriesName]-0-|" options:0 metrics:nil views:viewsPart2]];
    [self.bgViewTwo addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_lineTwo]-0-[_bpNumber(62)]-0-[_bpName]-0-|" options:0 metrics:nil views:viewsPart2]];
    [self.bgViewTwo addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_lineTwo]-0-[_caloriesNumber(62)]-0-[_caloriesName]-0-|" options:0 metrics:nil views:viewsPart2]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

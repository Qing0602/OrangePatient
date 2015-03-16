//
//  MyDeviceViewController.m
//  OrangePatient
//
//  Created by singlew on 15/3/13.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "MyDeviceViewController.h"

@interface MyDeviceViewController ()

@end

@implementation MyDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton setImage:[UIImage imageNamed:@"SearchDevice"] forState:UIControlStateNormal];
    [searchButton setImage:[UIImage imageNamed:@"SearchDevice"] forState:UIControlStateHighlighted];
    searchButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:searchButton];

    NSDictionary *views = NSDictionaryOfVariableBindings(searchButton);
    NSDictionary *metrics = @{@"imageEdge":@150.0};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[searchButton(imageEdge)]" options:0 metrics:metrics views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[searchButton(imageEdge)]" options:0 metrics:metrics views:views]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:searchButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:searchButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

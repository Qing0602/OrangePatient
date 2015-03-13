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
    // Do any additional setup after loading the view.
    [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

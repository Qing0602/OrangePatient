//
//  BaseUITabBarController.m
//  iLove
//
//  Created by mtf on 12-11-26.
//  Copyright (c) 2012年 www.fanxer.com. All rights reserved.
//

#import "BaseUITabBarController.h"

@interface BaseUITabBarController ()

@end

@implementation BaseUITabBarController


- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        return YES;
    }
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

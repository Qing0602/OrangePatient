//
//  AboutViewController.m
//  OrangePatient
//
//  Created by singlew on 15/4/5.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *title = [[UILabel alloc] init];
    title.translatesAutoresizingMaskIntoConstraints = NO;
    title.font = [UIFont systemFontOfSize:14.0f];
    title.text = @"关于橙意人家:";
    [self.view addSubview:title];
    
    UITextView *content = [[UITextView alloc] init];
    content.font = [UIFont systemFontOfSize:14.0f];
    content.translatesAutoresizingMaskIntoConstraints = NO;
    content.backgroundColor = [UIColor clearColor];
    content.editable = NO;
    content.text = @"内容";
    [self.view addSubview:content];
    
    NSDictionary *views = @{@"topLayoutGuide":self.topLayoutGuide,@"titleLabel":title,@"content":content};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[titleLabel]-10-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[content]-10-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide]-10-[titleLabel(20)]-10-[content]-10-|" options:0 metrics:nil views:views]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

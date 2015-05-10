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
    
    self.title = @"关于橙意";
    
    UIScrollView *scroll = [[UIScrollView alloc] init];
    scroll.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:scroll];
    
    UIView *anchor = [[UIView alloc] init];
    anchor.translatesAutoresizingMaskIntoConstraints = NO;
    anchor.backgroundColor = [UIColor clearColor];
    [scroll addSubview:anchor];
    
    UIView *temp = [[UIView alloc] init];
    temp.translatesAutoresizingMaskIntoConstraints = NO;
    temp.backgroundColor = [UIColor clearColor];
    [self.view addSubview:temp];
    
    
    UIImageView *aboutPic = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AboutPic"]];
    aboutPic.translatesAutoresizingMaskIntoConstraints = NO;
    aboutPic.contentMode = UIViewContentModeScaleToFill;
    [anchor addSubview:aboutPic];
    
    UILabel *content = [[UILabel alloc] init];
    content.font = [UIFont systemFontOfSize:15.0f];
    content.translatesAutoresizingMaskIntoConstraints = NO;
    content.backgroundColor = [UIColor clearColor];
    content.numberOfLines = 0;
    content.text = @"    橙意家人科技（天津）有限公司位于天津滨海新区津京互联创业咖啡，是一家专注于远程健康管理领域的专业服务提供商。创始团队由多年从事健康管理、移动互联网、医疗器械等领域的资深人士组成，经过近5年的创新研发，形成了完善的医疗级健康管理产品和服务体系，包括：移动穿戴产品、家庭系列产品、社区自助健康体检产品、智能健康数据分析平台、远程健康管理指导服务。\n    2014年是橙意家人加速发展的一年，3月发布了国内首款医疗级可穿戴设备——鼾症监测仪，主要针对睡眠呼吸暂停综合征的筛查，佩戴后可连续采集使用者的血氧饱和度等指标，形成动态血氧趋势图，这些数据会实时上传至云端，可通过手机上安装的APP随时查看报告，并根据数据分析是否患有鼾症及病症的程度。11月与天津市第一中心医院共同在水上公园街社区卫生服务中心建立了国内首家鼾症筛查中心。2015年5月，橙意家人将全新发布睡眠呼吸整体解决方案。";
    [content sizeToFit];
    [anchor addSubview:content];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    float width = [UIScreen mainScreen].bounds.size.width - 20.0f;
    NSDictionary *metrics = @{@"vWidth":[NSNumber numberWithFloat:width]};
    NSDictionary *views = @{@"topLayoutGuide":self.topLayoutGuide,@"aboutPic":aboutPic,@"content":content,@"scroll":scroll,@"anchor":anchor,@"temp":temp};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[scroll]-10-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[scroll]-0-|" options:0 metrics:nil views:views]];
    [scroll addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[anchor(vWidth)]-0-|" options:0 metrics:metrics views:views]];
    [scroll addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[anchor(650)]-0-|" options:0 metrics:nil views:views]];
    
    [anchor addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[aboutPic]-0-|" options:0 metrics:nil views:views]];
    [anchor addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[content]-0-|" options:0 metrics:nil views:views]];
    [anchor addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[aboutPic(273)]-10-[content]" options:0 metrics:nil views:views]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

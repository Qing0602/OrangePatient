//
//  HomeViewController.m
//  OrangePatient
//
//  Created by ZhangQing on 3/17/15.
//  Copyright (c) 2015 Orange. All rights reserved.
//

#import "HomeViewController.h"

#import "HealthInformationViewController.h"
#import "ConsultViewController.h"
#import "MyDoctorViewController.h"
#import "MyDoctorListViewController.h"
#import "MedicalScreeningViewController.h"

#import "ADBannerScrollView.h"

#import "UIManagement.h"
@interface HomeViewController()<ADBannerScrollViewDelegate>

@property (nonatomic, strong)ADBannerScrollView *adScrollView;
@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = HOME_PAGE_TITLE;
    
    _adScrollView = [[ADBannerScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH, SCREEN_WIDTH/2) placeholdImage:[UIImage imageNamed:@""] models:@[@"a",@"a",@"a",@"a",@"a"]];
    [self.view addSubview:_adScrollView];
    
//    CGFloat unUseHeight = SCREEN_HEIGHT-104-CGRectGetHeight(_adScrollView.frame);
//    CGFloat lineHeight = SCREEN_WIDTH-8>unUseHeight?unUseHeight:SCREEN_WIDTH-8;
    
    
   // UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, CGRectGetMaxY(_adScrollView.frame), 2.f,lineHeight)];
    UIImageView *line1 = [[UIImageView alloc] init];
    line1.translatesAutoresizingMaskIntoConstraints = NO;
    [line1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:line1];
    
    UIImageView *line2 = [[UIImageView alloc] init];
    line2.translatesAutoresizingMaskIntoConstraints = NO;
    //UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(4.f, CGRectGetMaxY(_adScrollView.frame)+lineHeight/2.f, SCREEN_WIDTH-8.f,2.f)];
    [line2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:line2];
    
    UIView *bottomLayoutGuide = (id)self.bottomLayoutGuide;
    
    [line1 mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(1);
        make.top.mas_equalTo(CGRectGetMaxY(self.adScrollView.frame));
        make.bottom.equalTo(bottomLayoutGuide.mas_top);
    }];
    
    [line2 mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.centerY.equalTo(line1.mas_centerY);
        make.height.mas_equalTo(1);
    }];
    
    [RACObserve([UIManagement sharedInstance], getMyAppointmentListResult) subscribeNext:^(NSDictionary *dic){
        if (dic) {
            if (![dic[ASI_REQUEST_HAS_ERROR] boolValue]) {
                [self closeProgress];
                NSMutableArray *dataArr = dic[ASI_REQUEST_DATA];
            }else{
                [self showProgressWithText:dic[ASI_REQUEST_ERROR_MESSAGE] withDelayTime:2.f];
            }
        }
    }];
    
    for (int i = 0; i<4; i++) {
    
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i+1;
        [btn handleControlEvents:UIControlEventTouchUpInside actionBlock:^(UIButton *sender){
            switch (sender.tag) {
                case 1:
                {
                    HealthInformationViewController *healthInformation = [[HealthInformationViewController alloc] init];
                    healthInformation.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:healthInformation animated:YES];
                }
                    break;
                case 2:
                {
//                    MyDoctorViewController *myDoctor = [[MyDoctorViewController alloc] init];
//                    myDoctor.hidesBottomBarWhenPushed = YES;
//                    [self.navigationController pushViewController:myDoctor animated:YES];
                    [self showProgressWithText:@"正在获取"];
                    [[UIManagement sharedInstance] getMyAppointmentList:0 withLimit:20];
                }
                    break;
                case 3:
                {
                    
                }
                    break;
                case 4:
                {
                    MedicalScreeningViewController *screening = [[MedicalScreeningViewController alloc] init];
                    screening.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:screening animated:YES];
                }
                    break;
                default:
                    break;
            }
        }];
        //btn.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 256.f green:arc4random() % 256 / 256.f blue:arc4random() % 256 / 256.f alpha:1.f];
        [self.view addSubview:btn];
        
        switch (i) {
            case 0:
            {
                [btn mas_makeConstraints:^(MASConstraintMaker *make){
                    make.left.mas_equalTo(0);
                    make.top.mas_equalTo(CGRectGetMaxY(self.adScrollView.frame));
                    make.bottom.equalTo(line2.mas_top);
                    make.right.equalTo(line1.mas_left).with.offset(-1);
                }];
                [btn setBackgroundImage:[UIImage imageNamed:@"home_icon_information"] forState:UIControlStateNormal];
            }
                break;
            case 1:
            {
                [btn mas_makeConstraints:^(MASConstraintMaker *make){
                    make.left.equalTo(line1.mas_right).with.offset(1);
                    make.top.mas_equalTo(CGRectGetMaxY(self.adScrollView.frame));
                    make.bottom.equalTo(line2.mas_top);
                    make.right.mas_equalTo(0);
                }];
                [btn setBackgroundImage:[UIImage imageNamed:@"home_icon_myDoctor"] forState:UIControlStateNormal];
            }
                break;
            case 2:
            {
                [btn mas_makeConstraints:^(MASConstraintMaker *make){
                    make.left.mas_equalTo(0);
                    make.top.equalTo(line2).with.offset(1);
                    make.bottom.equalTo(bottomLayoutGuide.mas_top);
                    make.right.equalTo(line1.mas_left).with.offset(-1);
                }];
                [btn setBackgroundImage:[UIImage imageNamed:@"home_icon_consult"] forState:UIControlStateNormal];
            }
                break;
            case 3:
            {
                [btn mas_makeConstraints:^(MASConstraintMaker *make){
                    make.left.equalTo(line1.mas_right).with.offset(1);
                    make.top.equalTo(line2).with.offset(1);
                    make.bottom.equalTo(bottomLayoutGuide.mas_top);
                    make.right.mas_equalTo(0);
                }];
                [btn setBackgroundImage:[UIImage imageNamed:@"home_icon_check"] forState:UIControlStateNormal];
            }
                break;
                
            default:
                break;
        }
    }
}



#pragma mark - ADBannerScrollViewDelegate
- (void)itemTapped:(ADBannerModel *)model
{
    
}

@end

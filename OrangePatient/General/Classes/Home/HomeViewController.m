//
//  HomeViewController.m
//  OrangePatient
//
//  Created by ZhangQing on 3/17/15.
//  Copyright (c) 2015 Orange. All rights reserved.
//

#import "HomeViewController.h"
@interface HomeViewController()

@property (nonatomic, strong)ADBannerScrollView *adScrollView;
@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = HOME_PAGE_TITLE;
    
    _adScrollView = [[ADBannerScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH, SCREEN_WIDTH/2) placeholdImage:[UIImage imageNamed:@""] models:@[@"a",@"a",@"a",@"a",@"a"]];
    [self.view addSubview:_adScrollView];
    
    CGFloat unUseHeight = SCREEN_HEIGHT-104-CGRectGetHeight(_adScrollView.frame);
    CGFloat lineHeight = SCREEN_WIDTH-8>unUseHeight?unUseHeight:SCREEN_WIDTH-8;
    UIImageView *line1 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, CGRectGetMaxY(_adScrollView.frame), 1.f,lineHeight)];
    [line1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:line1];
    
    
    
    UIImageView *line2 = [[UIImageView alloc] initWithFrame:CGRectMake(4.f, CGRectGetMaxY(_adScrollView.frame)+lineHeight/2.f, SCREEN_WIDTH-8.f,1.f)];
    [line2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:line2];
    
    for (int i = 0; i<4; i++) {
        CGRect btnFrame;
        CGFloat leftPadding = lineHeight == unUseHeight?(SCREEN_WIDTH-lineHeight)/2:0;
        if (i<2) {
            btnFrame = CGRectMake(leftPadding+lineHeight/2*i, CGRectGetMaxY(_adScrollView.frame)+1,lineHeight/2-1, lineHeight/2-2);
        }else
        {
            btnFrame = CGRectMake(leftPadding+lineHeight/2*(i-2), CGRectGetMaxY(_adScrollView.frame)+1+lineHeight/2,lineHeight/2-1, lineHeight/2-2);
        }
    
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:btnFrame];
        //[btn setImageEdgeInsets:UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)]
        btn.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 256.f green:arc4random() % 256 / 256.f blue:arc4random() % 256 / 256.f alpha:1.f];
        [self.view addSubview:btn];
        
        switch (i) {
            case 0:
            {
                [btn setImage:[UIImage imageNamed:@"IconMessage"] forState:UIControlStateNormal];
                [btn setTitle:@"资讯" forState:UIControlStateNormal];
            }
                break;
            case 1:
            {
                [btn setImage:[UIImage imageNamed:@"IconDoctor"] forState:UIControlStateNormal];
                [btn setTitle:@"我的医生" forState:UIControlStateNormal];
            }
                break;
            case 2:
            {
                [btn setImage:[UIImage imageNamed:@"IconAsk"] forState:UIControlStateNormal];
                [btn setTitle:@"咨询" forState:UIControlStateNormal];
            }
                break;
            case 3:
            {
                [btn setImage:[UIImage imageNamed:@"IconCheck"] forState:UIControlStateNormal];
                [btn setTitle:@"就医筛查" forState:UIControlStateNormal];
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

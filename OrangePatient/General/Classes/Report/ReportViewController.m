//
//  ReportViewController.m
//  OrangePatient
//
//  Created by ZhangQing on 15/4/10.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "ReportViewController.h"
#import "MyReportListViewController.h"

#import "CircularProgressView.h"
@interface ReportViewController ()
@property (nonatomic, strong)CircularProgressView *progressView;
@property (nonatomic, strong)UILabel *odi4ValueLabel;
@property (nonatomic, strong)UILabel *tValueLabel;
@property (nonatomic, strong)UILabel *lsao2ValueLabel;
@end

@implementation ReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [self createNavRightButton:kCustomNavRightTypeReportListIcon withSEL:@selector(checkMyReportList)];
    
    _progressView = [[CircularProgressView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-300)/2, 20, 300.f, 200.f)];
    [self.view addSubview:_progressView];
    
    UILabel *valueTitle = [[UILabel alloc] init];
    valueTitle.text = @"氧减饱和度指数";
    valueTitle.textAlignment = NSTextAlignmentCenter;
    valueTitle.font = [UIFont systemFontOfSize:16.f];
    [self.view addSubview:valueTitle];
    
    NSString *odi4 = @"氧减饱和度指数(Odi4↓)";
    NSString *t = @"低氧时间占比(T<90%)";
    NSString *lsao2 = @"最低血氧饱和度(Lsao2↓)";
    NSMutableAttributedString *odi4AttrStr = [[NSMutableAttributedString alloc] initWithString:odi4];
    [odi4AttrStr setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(odi4.length-2, 1)];
    
    NSMutableAttributedString *lsao2AttrStr = [[NSMutableAttributedString alloc] initWithString:odi4];
    [lsao2AttrStr setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(odi4.length-2, 1)];
    
    
    UILabel *odi4Label = [[UILabel alloc] init];
    odi4Label.textAlignment = NSTextAlignmentRight;
    [odi4Label setAttributedText:odi4AttrStr];
    odi4Label.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:odi4Label];
    
    _odi4ValueLabel = [[UILabel alloc] init];
    _odi4ValueLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:_odi4ValueLabel];
    
    UILabel *tLabel = [[UILabel alloc] init];
    tLabel.font = [UIFont systemFontOfSize:12];
    tLabel.textAlignment = NSTextAlignmentRight;
    tLabel.text = t;
    [self.view addSubview:tLabel];
    
    _tValueLabel = [[UILabel alloc] init];
    _tValueLabel.font = [UIFont systemFontOfSize:12];
    _tValueLabel.textColor = RGBACOLOR(85, 194, 43, 1);
    [self.view addSubview:_tValueLabel];
    
    UILabel *lsao2Label = [[UILabel alloc] init];
    lsao2Label.font = [UIFont systemFontOfSize:12];
    lsao2Label.textAlignment = NSTextAlignmentRight;
    [lsao2Label setAttributedText:lsao2AttrStr];
    [self.view addSubview:lsao2Label];
    
    _lsao2ValueLabel = [[UILabel alloc] init];
    _lsao2ValueLabel.font = [UIFont systemFontOfSize:12];
    _lsao2ValueLabel.textColor = RGBACOLOR(254, 172,175,1);
    [self.view addSubview:_lsao2ValueLabel];
    
    UIButton *downloadReport = [UIButton buttonWithType:UIButtonTypeCustom];
    [downloadReport setTitle:@"下载报告" forState:UIControlStateNormal];
    [downloadReport setBackgroundImage:[UIImage imageNamed:@"Login_Btn_BG"] forState:UIControlStateNormal];
    downloadReport.titleLabel.font = [UIFont systemFontOfSize:13];
    [[downloadReport rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *sender){
        MyReportListViewController *reportList = [[MyReportListViewController alloc] init];
        [self.navigationController pushViewController:reportList animated:YES];
    }];
    [self.view addSubview:downloadReport];
    
    
    [valueTitle mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.progressView.mas_bottom).with.offset(30);
        make.width.mas_equalTo(200);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(16);
    }];
    
    [odi4Label mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(valueTitle.mas_bottom).with.offset(20);
        make.left.mas_equalTo(4);
        make.right.mas_equalTo(-SCREEN_WIDTH*2/5);
        make.height.mas_equalTo(14);
    }];

    [_odi4ValueLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(odi4Label.mas_top);
        make.left.equalTo(odi4Label.mas_right).with.offset(14);
        make.right.mas_equalTo(-4);
        make.height.equalTo(odi4Label);
    }];
    
    [tLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(odi4Label.mas_bottom).with.offset(10);
        make.left.equalTo(odi4Label);
        make.right.equalTo(odi4Label);
        make.height.equalTo(odi4Label);
    }];
    
    [_tValueLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(tLabel.mas_top);
        make.left.equalTo(_odi4ValueLabel.mas_left);
        make.right.mas_equalTo(-4);
        make.height.equalTo(tLabel);
    }];
    
    [lsao2Label mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(tLabel.mas_bottom).with.offset(10);
        make.left.equalTo(odi4Label);
        make.right.equalTo(odi4Label);
        make.height.equalTo(odi4Label);
    }];
    
    [_lsao2ValueLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(lsao2Label.mas_top);
        make.left.equalTo(_odi4ValueLabel.mas_left);
        make.right.mas_equalTo(-4);
        make.height.equalTo(lsao2Label);
    }];
    
    [downloadReport mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(lsao2Label.mas_bottom).with.offset(20);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(258);
        make.height.mas_equalTo(24);
    }];
    // Do any additional setup after loading the view.
}

- (void)checkMyReportList{
    MyReportListViewController *reportList = [[MyReportListViewController alloc] init];
    [self.navigationController pushViewController:reportList animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    NSString *tempOdi4Value = @"500";
    NSString *tempOdi4Str = [NSString stringWithFormat:@"%@次/小时",tempOdi4Value];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:tempOdi4Str];
    [str setAttributes:@{NSForegroundColorAttributeName:RGBACOLOR(254, 172,175,1)} range:NSMakeRange(0, tempOdi4Value.length)];
    [self.odi4ValueLabel setAttributedText:str];
    [self.tValueLabel setText:@"50%"];
    [self.lsao2ValueLabel setText:@"10%"];
    [self.progressView setProgressValue:30];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

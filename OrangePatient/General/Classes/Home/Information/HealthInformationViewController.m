//
//  HealthInformationViewController.m
//  OrangePatient
//
//  Created by ZhangQing on 15/3/23.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "HealthInformationViewController.h"

#import "HealthInformationTableViewCell.h"
#import "HealthInfomationModel.h"
#import "ADBannerScrollView.h"
@interface HealthInformationViewController ()<ADBannerImageViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)ADBannerScrollView *adScrollView;
@property (nonatomic, strong)UITableView *healthInfoTable;
@end

@implementation HealthInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"健康资讯";
    
    _adScrollView = [[ADBannerScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH, SCREEN_WIDTH/2) placeholdImage:[UIImage imageNamed:@""] models:@[@"a",@"a",@"a",@"a",@"a"]];
    [self.view addSubview:_adScrollView];
    
    _healthInfoTable = [[UITableView alloc] init];
    _healthInfoTable.translatesAutoresizingMaskIntoConstraints = NO;
    _healthInfoTable.delegate = self;
    _healthInfoTable.dataSource = self;
    _healthInfoTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _healthInfoTable.backgroundColor = [UIColor redColor];
    [self.view addSubview:_healthInfoTable];
    
    NSDictionary *constraintsViews = NSDictionaryOfVariableBindings(_adScrollView,_healthInfoTable);
    //NSDictionary *constraintsViews = @{@"adScrollview":self.adScrollView,@"tableview":self.healthInfoTable};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_healthInfoTable]-0-|" options:0 metrics:nil views:constraintsViews]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_adScrollView]-0-[_healthInfoTable(>=200)]-0-|" options:0 metrics:nil views:constraintsViews]];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Tableview
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *infomationCellIden = @"InformationCellIden";
    HealthInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:infomationCellIden];
    if (!cell) {
        cell = [[HealthInformationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infomationCellIden];
    }
    HealthInfomationModel *testModel = [[HealthInfomationModel alloc] init];
    testModel.infoContent = @"testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest";
    testModel.infoTitle = @"testtesttesttest";
    [cell setContentByInfoModel:testModel];
    return cell;
}
#pragma mark - ADBannerScrollViewDelegate
- (void)itemTapped:(ADBannerModel *)model
{

}
@end

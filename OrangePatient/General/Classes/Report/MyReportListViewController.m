//
//  MyReportListViewController.m
//  OrangePatient
//
//  Created by ZhangQing on 15/4/19.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "MyReportListViewController.h"

#import "MyReportListTableViewCell.h"
#import "MyReportListModel.h"
@interface MyReportListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)NSArray *myReportList;
@end

@implementation MyReportListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"诊断报告";
    
    UITableView *reportListTable = [[UITableView alloc] init];
    reportListTable.delegate = self;
    reportListTable.dataSource = self;
    reportListTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    reportListTable.tableHeaderView = [self tableHeaderView];
    [self.view addSubview:reportListTable];
    
    [reportListTable mas_makeConstraints:^(MASConstraintMaker *make){
        make.edges.equalTo(self.view);
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)tableHeaderView{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH, 30)];
    headerView.backgroundColor = RGBACOLOR(240, 240, 240, 1);
    
    UILabel *typeTitleLabel = [[UILabel alloc] init];
    typeTitleLabel.font = [UIFont systemFontOfSize:16.f];
    typeTitleLabel.text = @"类型";
    [headerView addSubview:typeTitleLabel];
    
    UILabel *statusTitleLabel = [[UILabel alloc] init];
    statusTitleLabel.font = [UIFont systemFontOfSize:16.f];
    statusTitleLabel.text = @"状态";
    statusTitleLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:statusTitleLabel];
    
    UILabel *dateTitleLabel  = [[UILabel alloc] init];
    dateTitleLabel.font = [UIFont systemFontOfSize:16.f];
    dateTitleLabel.text = @"日期";
    dateTitleLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:dateTitleLabel];
    
    //typeTitleLabel.backgroundColor = statusTitleLabel.backgroundColor = dateTitleLabel.backgroundColor = [UIColor yellowColor];
    
    
    
    [typeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(56);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(100);
    }];
    
    [statusTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(typeTitleLabel.mas_top);
        make.left.equalTo(typeTitleLabel.mas_right).with.offset(10);
        make.height.equalTo(typeTitleLabel.mas_height);
        make.width.mas_equalTo(60);
    }];
    
    [dateTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(typeTitleLabel.mas_top);
        make.left.equalTo(statusTitleLabel.mas_right).with.offset(10);
        make.height.equalTo(typeTitleLabel.mas_height);
        make.right.mas_equalTo(-10);
    }];
    return headerView;
}

#pragma mark - Getter
- (NSArray *)myReportList{
    if (!_myReportList) {
        NSMutableArray *testArray = [[NSMutableArray alloc] initWithCapacity:10];
        for (int i = 0; i < 10; i++) {
            MyReportListModel *testModel = [[MyReportListModel alloc] init];
            testModel.reportType = @"动态血氧";
            testModel.reportStatus = 1;
            testModel.reportDate = @"2014-10-29";
            [testArray addObject:testModel];
        }
        _myReportList = [[NSArray alloc] initWithArray:testArray];
    }
    return _myReportList;
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.myReportList.count;
}
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH, 30)];
    
    UILabel *typeTitleLabel = [[UILabel alloc] init];
    typeTitleLabel.font = [UIFont systemFontOfSize:16.f];
    [sectionView addSubview:typeTitleLabel];
    
    UILabel *statusTitleLabel = [[UILabel alloc] init];
    statusTitleLabel.font = [UIFont systemFontOfSize:16.f];
    [sectionView addSubview:statusTitleLabel];
    
    UILabel *dateTitleLabel  = [[UILabel alloc] init];
    dateTitleLabel.font = [UIFont systemFontOfSize:16.f];
    [sectionView addSubview:dateTitleLabel];
    
    typeTitleLabel.backgroundColor = statusTitleLabel.backgroundColor = dateTitleLabel.backgroundColor = [UIColor yellowColor];
    

    
    [typeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(60);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(100);
    }];
    
    [statusTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(typeTitleLabel.mas_top);
        make.left.equalTo(typeTitleLabel.mas_right).with.offset(10);
        make.height.equalTo(typeTitleLabel.mas_height);
        make.width.mas_equalTo(70);
    }];
    
    [dateTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(typeTitleLabel.mas_top);
        make.left.equalTo(statusTitleLabel.mas_right).with.offset(10);
        make.height.equalTo(typeTitleLabel.mas_height);
        make.right.mas_equalTo(-10);
    }];
    return sectionView;
}
*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reportListCellIden = @"reportListCellIden";
    MyReportListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reportListCellIden];
    if (!cell) {
        cell = [[MyReportListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reportListCellIden];
    }
    [cell setContentData:self.myReportList[indexPath.row]];
    return cell;
}

@end

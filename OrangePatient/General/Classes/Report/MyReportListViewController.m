//
//  MyReportListViewController.m
//  OrangePatient
//
//  Created by ZhangQing on 15/4/19.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "MyReportListViewController.h"

#import "MyReportListTableViewCell.h"

@interface MyReportListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)NSArray *myReportList;
@end

@implementation MyReportListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *reportListTable = [[UITableView alloc] init];
    reportListTable.delegate = self;
    reportListTable.dataSource = self;
    reportListTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
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
@end

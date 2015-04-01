//
//  MyDoctorListViewController.m
//  OrangePatient
//
//  Created by ZhangQing on 15/3/30.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "MyDoctorListViewController.h"

#import "DoctorBaseTableViewCell.h"
#import "MyDoctorsModel.h"
@interface MyDoctorListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)NSArray *myDoctorList;
@property (nonatomic, strong)UITableView *doctorListTable;
@end

@implementation MyDoctorListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的医生";
    
    _doctorListTable = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _doctorListTable.delegate = self;
    _doctorListTable.dataSource = self;
    _doctorListTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _doctorListTable.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    [self.view addSubview:_doctorListTable];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setter&Getter
- (NSArray *)myDoctorList
{
    if (!_myDoctorList) {
        NSMutableArray *testArray = [[NSMutableArray alloc] initWithCapacity:10];
        for (int i = 0; i < 10; i++) {
            MyDoctorsModel *model = [[MyDoctorsModel alloc] init];
            model.doctorHostpital = [NSString stringWithFormat:@"中心医院%d",i];
            model.doctorTitle = [NSString stringWithFormat:@"主治医生%d",i];
            model.doctorUserName = [NSString stringWithFormat:@"用户名%d",i];
            [testArray addObject:model];
        }
        _myDoctorList = [[NSArray alloc] initWithArray:testArray];
    }
    return _myDoctorList;
}
#pragma mark - Tableview
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myDoctorList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *infomationCellIden = @"InformationCellIden";
    DoctorBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:infomationCellIden];
    if (!cell) {
        cell = [[DoctorBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infomationCellIden];
    }
    
    [cell setContentByInfoModel:self.myDoctorList[indexPath.row]];
    return cell;
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

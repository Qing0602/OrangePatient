//
//  ConsultViewController.m
//  OrangePatient
//
//  Created by ZhangQing on 15/3/23.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "ConsultViewController.h"

#import "ChatViewController.h"

#import "MyServiceModel.h"
#import "DoctorBaseTableViewCell.h"

#import "UIManagement.h"
@interface ConsultViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)NSArray *myServiceList;
@property (nonatomic, strong)UITableView *serviceListTable;
@end

@implementation ConsultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _serviceListTable = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _serviceListTable.delegate = self;
    _serviceListTable.dataSource = self;
    _serviceListTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _serviceListTable.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    [self.view addSubview:_serviceListTable];
    
    [RACObserve([UIManagement sharedInstance], myServiceResult) subscribeNext:^(NSDictionary *dic){
        if (dic) {
            if (![dic[ASI_REQUEST_HAS_ERROR] boolValue]) {
                [self closeProgress];
                NSMutableArray *dataArr = dic[ASI_REQUEST_DATA];
                [self setMyServiceList:dataArr];
            }else{
                [self showProgressWithText:dic[ASI_REQUEST_ERROR_MESSAGE] withDelayTime:2.f];
            }
        }
    }];
    
    [self showProgressWithText:@"正在获取"];
    [[UIManagement sharedInstance] getMyServiceList];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Setter&Getter
- (void)setMyServiceList:(NSMutableArray *)myServiceList{
    if (myServiceList.count) {
        NSMutableArray *tempDoctorsList = [[NSMutableArray alloc] initWithCapacity:10];
        for (NSDictionary *dic in myServiceList) {
            NSLog(@"%@",dic);
            if (dic && dic.allKeys.count>0) {
                [tempDoctorsList addObject:[MyServiceModel convertModelByDic:dic]];
            }
        }
        _myServiceList = [[NSArray alloc] initWithArray:tempDoctorsList];
        [self.serviceListTable reloadData];
    }
}

#pragma mark - Tableview
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myServiceList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *infomationCellIden = @"ServiceTableViewCellIden";
    DoctorBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:infomationCellIden];
    if (!cell) {
        cell = [[DoctorBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infomationCellIden];
    }
    
    [cell setContentByInfoModel:self.myServiceList[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatViewController *chatController = [[ChatViewController alloc] initWithChatter:@"test" isGroup:NO];
    [self.navigationController pushViewController:chatController animated:YES];
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

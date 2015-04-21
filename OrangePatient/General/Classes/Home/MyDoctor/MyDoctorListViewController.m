//
//  MyDoctorListViewController.m
//  OrangePatient
//
//  Created by ZhangQing on 15/3/30.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "MyDoctorListViewController.h"
#import "ChatViewController.h"

#import "SVPullToRefresh.h"
#import "DoctorBaseTableViewCell.h"

#import "MyDoctorsModel.h"
#import "UIManagement.h"
@interface MyDoctorListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic) DoctorListLoadStatus loadStatus;
@property (nonatomic, strong)NSMutableArray *myDoctorList;
@property (nonatomic, strong)UITableView *doctorListTable;
@end

@implementation MyDoctorListViewController
- (instancetype)initWithDoctors:(NSArray *)doctors{
    self = [super init];
    if (self) {
        [self setMyDoctorList:[[NSMutableArray alloc] initWithArray:doctors]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的医生";
    
    _doctorListTable = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _doctorListTable.delegate = self;
    _doctorListTable.dataSource = self;
    _doctorListTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _doctorListTable.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    [self.view addSubview:_doctorListTable];
    
    __weak MyDoctorListViewController *weakSelf = self;
    [_doctorListTable addPullToRefreshWithActionHandler:^{
        weakSelf.loadStatus = DoctorListLoadStatusRefresh;
        [[UIManagement sharedInstance] getMyAppointmentList:0 withLimit:20];
    }];
    
    [_doctorListTable addInfiniteScrollingWithActionHandler:^{
        weakSelf.loadStatus = DoctorListLoadStatusAppend;
        [[UIManagement sharedInstance] getMyAppointmentList:weakSelf.myDoctorList.count withLimit:20];
    }];
    
    [RACObserve([UIManagement sharedInstance], getMyAppointmentListResult) subscribeNext:^(NSDictionary *dic){
        if (dic) {
            if (![dic[ASI_REQUEST_HAS_ERROR] boolValue]) {
                [self closeProgress];
                NSMutableArray *dataArr = dic[ASI_REQUEST_DATA];
                [self setMyDoctorList:dataArr];
            }else{
                [self showProgressWithText:dic[ASI_REQUEST_ERROR_MESSAGE] withDelayTime:2.f];
            }
        }
    }];
    // Do any additional setup after loading the view.
}

- (void)closePullRefreshView{
    switch (self.loadStatus) {
        case DoctorListLoadStatusRefresh:
            [self.doctorListTable.pullToRefreshView stopAnimating];
            break;
        case DoctorListLoadStatusAppend:
            [self.doctorListTable.infiniteScrollingView stopAnimating];
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setter&Getter
- (void)setMyDoctorList:(NSMutableArray *)myDoctorList{
    if (myDoctorList.count) {
        NSMutableArray *tempDoctorsList = [[NSMutableArray alloc] initWithCapacity:10];
        for (NSDictionary *dic in myDoctorList) {
            NSLog(@"%@",dic);
            if (dic && dic.allKeys.count>0) {
                [tempDoctorsList addObject:[MyDoctorsModel convertModelByDic:dic]];
            }
        }
        
        switch (self.loadStatus) {
            case DoctorListLoadStatusRefresh:
                _myDoctorList = [[NSMutableArray alloc] initWithArray:tempDoctorsList];
                break;
            case DoctorListLoadStatusAppend:
                [_myDoctorList addObjectsFromArray:tempDoctorsList];
            default:
                break;
        }
        [self closePullRefreshView];
        [self.doctorListTable reloadData];
    }
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

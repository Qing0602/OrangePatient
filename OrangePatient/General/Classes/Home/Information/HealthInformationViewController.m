//
//  HealthInformationViewController.m
//  OrangePatient
//
//  Created by ZhangQing on 15/3/23.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "HealthInformationViewController.h"
#import "HealthInfoDetailViewController.h"

#import "HealthInformationTableViewCell.h"
#import "ADBannerScrollView.h"
#import "SVPullToRefresh.h"

#import "HealthInfomationModel.h"
#import "UIManagement.h"
@interface HealthInformationViewController ()<ADBannerImageViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic) InformationLoadStatus loadStatus;

@property (nonatomic, strong)ADBannerScrollView *adScrollView;
@property (nonatomic, strong)UITableView *healthInfoTable;

@property (nonatomic, strong)NSMutableArray *infomations;
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
    
    __weak HealthInformationViewController *weakSelf = self;
    [_healthInfoTable addPullToRefreshWithActionHandler:^{
        weakSelf.loadStatus = InformationLoadStatusRefresh;
        [[UIManagement sharedInstance] initGetRecent:0 withLimit:20];
    }];
    
    [_healthInfoTable addInfiniteScrollingWithActionHandler:^{
        weakSelf.loadStatus = InformationLoadStatusAppend;
        [[UIManagement sharedInstance] initGetRecent:weakSelf.infomations.count withLimit:20];
    }];
    
    NSDictionary *constraintsViews = NSDictionaryOfVariableBindings(_adScrollView,_healthInfoTable);
    //NSDictionary *constraintsViews = @{@"adScrollview":self.adScrollView,@"tableview":self.healthInfoTable};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_healthInfoTable]-0-|" options:0 metrics:nil views:constraintsViews]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_adScrollView]-0-[_healthInfoTable(>=200)]-0-|" options:0 metrics:nil views:constraintsViews]];
    
    
    [RACObserve([UIManagement sharedInstance], getRecentResult) subscribeNext:^(NSDictionary *dic){
        if (dic) {
            if (![dic[ASI_REQUEST_HAS_ERROR] boolValue]) {
                NSMutableArray *dataArr = dic[ASI_REQUEST_DATA];
                [self setInfomations:dataArr];
            }else{
                [self closePullRefreshView];
                [self showProgressWithText:dic[ASI_REQUEST_ERROR_MESSAGE] withDelayTime:2.f];
            }
        }
    }];
    
    [[UIManagement sharedInstance] initGetRecent:0 withLimit:20];
    // Do any additional setup after loading the view.
}

- (void)closePullRefreshView{
    switch (self.loadStatus) {
        case InformationLoadStatusRefresh:
            [self.healthInfoTable.pullToRefreshView stopAnimating];
            break;
        case InformationLoadStatusAppend:
            [self.healthInfoTable.infiniteScrollingView stopAnimating];
        default:
            break;
    }
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
#pragma mark - Setter&Getter
- (void)setInfomations:(NSMutableArray *)infomations{
    if (infomations) {
        NSMutableArray *tempArr = [[NSMutableArray alloc] initWithCapacity:infomations.count];
        for (NSDictionary *dic in infomations) {
            if (dic && dic.allKeys.count > 0) {
                [tempArr addObject:[HealthInfomationModel convertModelByDic:dic]];
            }
        }
        switch (self.loadStatus) {
            case InformationLoadStatusRefresh:
                _infomations = [[NSMutableArray alloc] initWithArray:tempArr];
                break;
            case InformationLoadStatusAppend:
                [_infomations addObjectsFromArray:tempArr];
            default:
                break;
        }
        [self closePullRefreshView];
        [_healthInfoTable reloadData];
    }
}
#pragma mark - Tableview
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.infomations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *infomationCellIden = @"InformationCellIden";
    HealthInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:infomationCellIden];
    if (!cell) {
        cell = [[HealthInformationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infomationCellIden];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    [cell setContentByInfoModel:self.infomations[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    HealthInfomationModel *model = self.infomations[indexPath.row];
    HealthInfoDetailViewController *detail = [[HealthInfoDetailViewController alloc] initWithInfoModel:model];
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma mark - ADBannerScrollViewDelegate
- (void)itemTapped:(ADBannerModel *)model
{

}
@end

//
//  TwoTablesViewController.m
//  OrangePatient
//
//  Created by ZhangQing on 15/4/1.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "TwoTablesViewController.h"

#import "SVPullToRefresh.h"
#import "TwoTablesCityCell.h"
#import "TwoTablesHospitalCell.h"

#import "UIManagement.h"
@interface TwoTablesViewController ()
{

}
@property(nonatomic) HospitalListLoadStatus loadStatus;
@property(nonatomic) NSInteger currentCityIndex;
@end

@implementation TwoTablesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentCityIndex = 0;
    
    _cityTable = [[UITableView alloc] init];
    _cityTable.delegate = self;
    _cityTable.dataSource = self;
    _cityTable.translatesAutoresizingMaskIntoConstraints = NO;
    _cityTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _cityTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_cityTable];
    
    _hospitalTable = [[UITableView alloc] init];
    _hospitalTable.translatesAutoresizingMaskIntoConstraints = NO;
    _hospitalTable.delegate = self;
    _hospitalTable.dataSource = self;
    _hospitalTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _hospitalTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_hospitalTable];

    
    //城市kvo
    [RACObserve([UIManagement sharedInstance], getAreaResult) subscribeNext:^(NSDictionary *dic){
        if (dic) {
            if (![dic[ASI_REQUEST_HAS_ERROR] boolValue]) {
                //[self closeProgress];
                NSMutableArray *dataArr = dic[ASI_REQUEST_DATA];
                [self setContentData:dataArr];
                if (dataArr.count) {
                    NSDictionary *firstCity = dataArr[0];
                    [[UIManagement sharedInstance] getHospital:20 withOffset:0 withCode:[firstCity[@"code"] integerValue]];
                }
            }else{
                [self showProgressWithText:dic[ASI_REQUEST_ERROR_MESSAGE] withDelayTime:2.f];
            }
        }
    }];
    //医院kvo
    [RACObserve([UIManagement sharedInstance], getHospitalResult) subscribeNext:^(NSDictionary *dic){
        if (dic) {
            if (![dic[ASI_REQUEST_HAS_ERROR] boolValue]) {
                [self closeProgress];
                NSArray *dataArr = dic[ASI_REQUEST_DATA];
                [self setHospitalInCurrentCitys:dataArr];
            }else{
                [self showProgressWithText:dic[ASI_REQUEST_ERROR_MESSAGE] withDelayTime:2.f];
            }
        }
    }];
    
    __weak TwoTablesViewController *weakSelf = self;
    [_hospitalTable addPullToRefreshWithActionHandler:^{
        weakSelf.loadStatus = HospitalListLoadStatusRefresh;
        MyDoctorCitysModel *cityModel = weakSelf.contentData[weakSelf.currentCityIndex];
        [[UIManagement sharedInstance] getHospital:0 withOffset:20 withCode:cityModel.cityCode];
    }];
    
    [_hospitalTable addInfiniteScrollingWithActionHandler:^{
        weakSelf.loadStatus = HospitalListLoadStatusAppend;
        MyDoctorCitysModel *cityModel = weakSelf.contentData[weakSelf.currentCityIndex];
        [[UIManagement sharedInstance] getHospital:cityModel.hospitals.count withOffset:20 withCode:cityModel.cityCode];
    }];
    
    [self showProgressWithText:@"正在获取"];
    [[UIManagement sharedInstance] getArea];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_cityTable,_hospitalTable);
    NSDictionary *metrics = @{@"cityWidth":@(SCREEN_WIDTH/3),@"hospitalWidht":@(SCREEN_WIDTH*2/3)};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_cityTable(cityWidth)]-0-[_hospitalTable(hospitalWidht)]-0-|" options:0 metrics:metrics views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_cityTable]-0-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_hospitalTable]-0-|" options:0 metrics:nil views:views]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MyDoctorCitysModel *)getCurrentCityModel{
    return self.contentData[self.currentCityIndex];
}

- (void)closePullRefreshView{
    switch (self.loadStatus) {
        case HospitalListLoadStatusRefresh:
            [self.hospitalTable.pullToRefreshView stopAnimating];
            break;
        case HospitalListLoadStatusAppend:
            [self.hospitalTable.infiniteScrollingView stopAnimating];
        default:
            break;
    }
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
- (void)setContentData:(NSArray *)contentData{
    if (contentData) {
        NSMutableArray *citys = [[NSMutableArray alloc] initWithCapacity:contentData.count];
        for (NSDictionary *dic in contentData) {
            if (dic && dic.allKeys.count) {
                [citys addObject:[MyDoctorCitysModel convertModelByDic:dic]];
            }
        }
        _contentData = [[NSMutableArray alloc] initWithArray:citys];
        [self.cityTable  reloadData];
    }
}

- (void)setHospitalInCurrentCitys:(NSArray *)hospitals{
    if (hospitals.count) {
        MyDoctorCitysModel *cityModel = [self getCurrentCityModel];
        NSInteger cityCode = cityModel.cityCode;
        
        NSMutableArray *tempHospitals = [[NSMutableArray alloc] initWithCapacity:hospitals.count];
        for (NSDictionary *hospital in hospitals) {
            if (hospitals && hospital.allKeys.count) {
                MyDoctorHospitalsModel *hospitalModel = [MyDoctorHospitalsModel convertModelByDic:hospital];
                hospitalModel.cityCode = cityCode;
                [tempHospitals addObject:hospitalModel];
            }
        }
        
        cityModel.hospitals = [[NSMutableArray alloc] initWithArray:tempHospitals];
        [self.hospitalTable reloadData];
    }
    


}


#pragma mark - Tableview
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.cityTable) {
        return self.contentData.count;
    }else
    {
        MyDoctorCitysModel *cityModel = self.contentData[self.currentCityIndex];
        return cityModel.hospitals.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cityTableViewCellIden = @"CityTableViewCellIden";
    static NSString *hospitalTableViewCellIden = @"HospitalTableViewCellIden";
    

    if (tableView == self.cityTable) {
       TwoTablesCityCell *cell = [tableView dequeueReusableCellWithIdentifier:cityTableViewCellIden];
        if (!cell) {
            cell = [[TwoTablesCityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cityTableViewCellIden];
            //cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
        
        if (indexPath.row == self.currentCityIndex) {
            [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
        [cell setContentByInfoModel:self.contentData[indexPath.row]];
        return cell;
    }else
    {
        TwoTablesHospitalCell *cell = [tableView dequeueReusableCellWithIdentifier:hospitalTableViewCellIden];
        if (!cell) {
            cell = [[TwoTablesHospitalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cityTableViewCellIden];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        MyDoctorCitysModel *cityModel = [self getCurrentCityModel];
        [cell setContentByInfoModel:cityModel.hospitals[indexPath.row]];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.cityTable) {
        self.currentCityIndex = indexPath.row;
        MyDoctorCitysModel *cityModel = [self getCurrentCityModel];
        
        if (cityModel.hospitals.count) [self.hospitalTable reloadData];
        else {
            [self showProgressWithText:@"正在获取"];
            [[UIManagement sharedInstance] getHospital:0 withOffset:20 withCode:cityModel.cityCode];
        }

    }
}
@end

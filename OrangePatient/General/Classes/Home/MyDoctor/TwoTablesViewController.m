//
//  TwoTablesViewController.m
//  OrangePatient
//
//  Created by ZhangQing on 15/4/1.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "TwoTablesViewController.h"



#import "TwoTablesCityCell.h"
#import "TwoTablesHospitalCell.h"
@interface TwoTablesViewController ()
{
    NSInteger currentCityIndex;
}
@end

@implementation TwoTablesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    currentCityIndex = 0;
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Setter&Getter
- (NSArray *)contentData
{
    if (!_contentData) {
        //TestData
        NSMutableArray *citys = [[NSMutableArray alloc] initWithCapacity:10];
        NSMutableArray *hospitals = [[NSMutableArray alloc] initWithCapacity:5];
        for (int i = 0; i< 10; i++) {
            [hospitals removeAllObjects];
            for (int j = 0; j<5; j++) {
                MyDoctorHospitalsModel *hospitalModel = [[MyDoctorHospitalsModel alloc] init];
                hospitalModel.hospitalName = [NSString stringWithFormat:@"城市%d,中日友好医院%d",i,j];
                hospitalModel.screeningCenterName = [NSString stringWithFormat:@"城市%d,水上社区医院筛查中心%d",i,j];
                [hospitals addObject:hospitalModel];
            }
            MyDoctorCitysModel *cityModel = [[MyDoctorCitysModel alloc] init];
            cityModel.cityName = [NSString stringWithFormat:@"城市%d",i];
            cityModel.hospitals = [[NSArray alloc] initWithArray:hospitals];
            [citys addObject:cityModel];
        }
        
        _contentData = [[NSArray alloc] initWithArray:citys];
    }
    
    return _contentData;
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
        MyDoctorCitysModel *cityModel = self.contentData[currentCityIndex];
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
        
        if (indexPath.row == currentCityIndex) {
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
        MyDoctorCitysModel *cityModel = self.contentData[currentCityIndex];
        [cell setContentByInfoModel:cityModel.hospitals[indexPath.row]];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.cityTable) {
        currentCityIndex = indexPath.row;
        [self.hospitalTable reloadData];
    }
}
@end

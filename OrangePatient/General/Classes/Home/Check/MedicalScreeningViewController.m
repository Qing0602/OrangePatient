//
//  MedicalScreeningViewController.m
//  OrangePatient
//
//  Created by ZhangQing on 15/3/23.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "MedicalScreeningViewController.h"
#import "ScreeningDatingDoctorViewController.h"

#import "MyDoctorCitysModel.h"
#import "MyDoctorHospitalsModel.h"
#import "UIManagement.h"
@interface MedicalScreeningViewController (){
    NSInteger _selectedIndex;
}

@end

@implementation MedicalScreeningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"就医筛查";
    
    //根据部门获取医生kvo
    [RACObserve([UIManagement sharedInstance], getDoctorsResult) subscribeNext:^(NSDictionary *dic){
        if (dic) {
            if (![dic[ASI_REQUEST_HAS_ERROR] boolValue]) {
                [self closeProgress];
                NSArray *dataArr = dic[ASI_REQUEST_DATA];
                if (dataArr.count) {
                    MyDoctorCitysModel *cityModel = [self getCurrentCityModel];
                    ScreeningDatingDoctorViewController *addDoctor = [[ScreeningDatingDoctorViewController alloc] initWithHospital:cityModel.hospitals[_selectedIndex] andDoctors:dataArr];
                    [self.navigationController pushViewController:addDoctor animated:YES];
                }else [self showProgressWithText:@"当前部门无医生" withDelayTime:2.f];
            }else{
                [self showProgressWithText:dic[ASI_REQUEST_ERROR_MESSAGE] withDelayTime:2.f];
            }
        }
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.hospitalTable) {
        MyDoctorCitysModel *cityModel = [self getCurrentCityModel];
        MyDoctorHospitalsModel *hospitalModel = cityModel.hospitals[indexPath.row];
        _selectedIndex = indexPath.row;
        [self showProgressWithText:@"正在获取..."];
        [[UIManagement sharedInstance] getDoctors:20 withOffset:0  withCode:[hospitalModel.departmentCode integerValue]];
    }else [super tableView:tableView didSelectRowAtIndexPath:indexPath];

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

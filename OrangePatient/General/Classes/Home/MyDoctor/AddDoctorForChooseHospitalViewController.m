//
//  AddDoctorViewController.m
//  OrangePatient
//
//  Created by ZhangQing on 15/3/26.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "AddDoctorForChooseHospitalViewController.h"
#import "AddDoctorForChooseDoctorViewController.h"
@interface AddDoctorForChooseHospitalViewController ()

@end

@implementation AddDoctorForChooseHospitalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择医院";
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.hospitalTable) {
        AddDoctorForChooseDoctorViewController *addDoctor = [[AddDoctorForChooseDoctorViewController alloc] init];
        [self.navigationController pushViewController:addDoctor animated:YES];
    }else [super tableView:tableView didSelectRowAtIndexPath:indexPath];

}

@end

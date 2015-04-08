//
//  MedicalScreeningViewController.m
//  OrangePatient
//
//  Created by ZhangQing on 15/3/23.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "MedicalScreeningViewController.h"
#import "ScreeningDatingDoctorViewController.h"
@interface MedicalScreeningViewController ()

@end

@implementation MedicalScreeningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"就医筛查";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    ScreeningDatingDoctorViewController *addDoctor = [[ScreeningDatingDoctorViewController alloc] init];
    [self.navigationController pushViewController:addDoctor animated:YES];
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

//
//  AddDoctorForChooseDoctorViewController.m
//  OrangePatient
//
//  Created by ZhangQing on 15/4/2.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "AddDoctorForChooseDoctorViewController.h"

#import "AddDoctorForChooseDoctorCell.h"
@interface AddDoctorForChooseDoctorViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITableView *chooseDoctorTableview;
@property (nonatomic, strong)NSArray *couldSelectedDoctorsList;
@end

@implementation AddDoctorForChooseDoctorViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _chooseDoctorTableview = [[UITableView alloc] init];
    _chooseDoctorTableview.dataSource = self;
    _chooseDoctorTableview.delegate = self;
    _chooseDoctorTableview.tableFooterView = [[UIView alloc] init];
    _chooseDoctorTableview.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_chooseDoctorTableview];
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
#pragma mark - Getter&Setter
- (NSArray *)couldSelectedDoctorsList
{
    if (!_couldSelectedDoctorsList) {
        
    }
    return _couldSelectedDoctorsList;
}
#pragma mark - UITableview
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *chooseDoctorCellIden = @"ChooseDoctorCellIden";
    AddDoctorForChooseDoctorCell *cell = [tableView dequeueReusableCellWithIdentifier:chooseDoctorCellIden];
    if (!cell) {
        cell = [[AddDoctorForChooseDoctorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:chooseDoctorCellIden];
    }
    
    return cell;
}
@end

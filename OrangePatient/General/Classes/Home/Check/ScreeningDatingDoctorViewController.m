//
//  ScreeningDatingDoctorViewController.m
//  OrangePatient
//
//  Created by ZhangQing on 15/4/7.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "ScreeningDatingDoctorViewController.h"
#import "SubmitDatingInfoViewController.h"

#import "ScreeingDatingDoctorTableViewCell.h"

@interface ScreeningDatingDoctorViewController()<UITableViewDataSource,UITableViewDelegate,ScreeingDatingDoctorTableViewCellDelegate>{

}
@property (nonatomic, strong)UITableView *datingDoctorTableview;
@property (nonatomic, strong)NSArray *couldDatingDoctorList;
@end

@implementation ScreeningDatingDoctorViewController

- (void)viewDidLoad{
    _datingDoctorTableview = [[UITableView alloc] init];
    _datingDoctorTableview.dataSource = self;
    _datingDoctorTableview.delegate = self;
    _datingDoctorTableview.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_datingDoctorTableview];
    
    [_datingDoctorTableview mas_makeConstraints:^(MASConstraintMaker *make){
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - Getter&Setter
- (NSArray *)couldDatingDoctorList{
    if (!_couldDatingDoctorList) {
        NSMutableArray *testArray = [[NSMutableArray alloc] initWithCapacity:10];
        for (int i = 0; i < 10; i++) {
            ScreeingDatingDoctorsModel *model = [[ScreeingDatingDoctorsModel alloc] init];
            model.doctorHostpital = [NSString stringWithFormat:@"中心医院%d",i];
            model.doctorTitle = [NSString stringWithFormat:@"主治医生%d",i];
            model.doctorUserName = [NSString stringWithFormat:@"用户名%d",i];
            model.doctorDetail = @"dadsadadadsadadadsadadadsadadadsadadadsadadadsadadadsadadadsadadadsadadadsadadadsadadadsada";
            model.doctorDatingStatus = i%3;
            [testArray addObject:model];
        }
        _couldDatingDoctorList = [[NSArray alloc] initWithArray:testArray];
    }
    return _couldDatingDoctorList;
}

#pragma mark - UITableview
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.couldDatingDoctorList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *datingDoctorCellIden = @"DatingDoctorCellIden";
    ScreeingDatingDoctorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:datingDoctorCellIden];
    if (!cell) {
        cell = [[ScreeingDatingDoctorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:datingDoctorCellIden];
        cell.delegate = self;
    }
    [cell setContentByInfoModel:self.couldDatingDoctorList[indexPath.row]];
    return cell;
}

#pragma mark - Delegate
- (void)willDatingDoctor:(ScreeingDatingDoctorsModel *)model
{
    SubmitDatingInfoViewController *submitDating = [[SubmitDatingInfoViewController alloc] init];
    [self.navigationController pushViewController:submitDating animated:YES];
}
@end

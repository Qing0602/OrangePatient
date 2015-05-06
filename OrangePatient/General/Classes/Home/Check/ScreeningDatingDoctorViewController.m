//
//  ScreeningDatingDoctorViewController.m
//  OrangePatient
//
//  Created by ZhangQing on 15/4/7.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "ScreeningDatingDoctorViewController.h"
#import "SubmitDatingInfoViewController.h"
#import "ScreeningCenterInfoVIewController.h"

#import "MyDoctorHospitalsModel.h"

#import "ScreeingDatingDoctorTableViewCell.h"
#import "DoctorBaseTableViewCell.h"
@interface ScreeningDatingDoctorViewController()<UITableViewDataSource,UITableViewDelegate,ScreeingDatingDoctorTableViewCellDelegate,EGOImageLoaderObserver>{

}
@property (nonatomic, strong)MyDoctorHospitalsModel *hospitalsModel;
@property (nonatomic, strong)UITableView *datingDoctorTableview;
@property (nonatomic, strong)NSArray *couldDatingDoctorList;
@end

@implementation ScreeningDatingDoctorViewController

- (instancetype)initWithHospital:(MyDoctorHospitalsModel *)model andDoctors:(NSArray *)doctors;{
    self = [super init];
    if (self) {
        self.hospitalsModel = model;
        [self setCouldDatingDoctorList:doctors];

    }
    return self;
}

- (void)viewDidLoad{
    self.title = @"就医筛查";
    
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
- (void)setCouldDatingDoctorList:(NSArray *)couldDatingDoctorList{
    NSMutableArray *tempCouldDatingDoctors = [[NSMutableArray alloc] initWithCapacity:couldDatingDoctorList.count];
    for (NSDictionary *doctorInfo in couldDatingDoctorList) {
        if (doctorInfo && doctorInfo.allKeys.count) {
            ScreeingDatingDoctorsModel *tempModel = [ScreeingDatingDoctorsModel convertModelByDic:doctorInfo];
            [tempCouldDatingDoctors addObject:tempModel];
        }
    }
    _couldDatingDoctorList = [[NSArray alloc] initWithArray:tempCouldDatingDoctors];
}


#pragma mark - UITableview
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.couldDatingDoctorList.count+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  indexPath.row == 0 ? 85:120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *datingDoctorCellIden = @"DatingDoctorCellIden";
    static NSString *hospitalCellIden = @"HospitalCellIden";
    if (indexPath.row == 0) {
        DoctorBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:hospitalCellIden];
        if (!cell) {
            cell = [[DoctorBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:hospitalCellIden];
            [cell.cellImageview setImageURL:[NSURL URLWithString:self.hospitalsModel.hospitalLogoUrl]];
            cell.cellTitle.text = self.hospitalsModel.hospitalName;
            cell.cellContent.text = self.hospitalsModel.hospitalContent;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
    }else{
        ScreeingDatingDoctorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:datingDoctorCellIden];
        if (!cell) {
            cell = [[ScreeingDatingDoctorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:datingDoctorCellIden];
            cell.delegate = self;
        }
        [cell setContentByInfoModel:self.couldDatingDoctorList[indexPath.row-1]];
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 0) {
        ScreeningCenterInfoVIewController *centerInfo = [[ScreeningCenterInfoVIewController alloc] initWithModel:nil];
        [self.navigationController pushViewController:centerInfo animated:YES];
    }

}

#pragma mark - Delegate
- (void)willDatingDoctor:(ScreeingDatingDoctorsModel *)model{
    SubmitDatingInfoViewController *submitDating = [[SubmitDatingInfoViewController alloc] initWithDoctorModel:model];
    [self.navigationController pushViewController:submitDating animated:YES];
}

#pragma mark EgoImageLoader
- (void)imageLoaderDidLoad:(NSNotification*)notification{
    NSLog(@"imageLoaderDidLoad----%@",[notification userInfo]);
}
@end

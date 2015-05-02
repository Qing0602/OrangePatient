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
        ScreeingDatingDoctorsModel *tempModel = (ScreeingDatingDoctorsModel *)[ScreeingDatingDoctorsModel convertModelByDic:doctorInfo];
        [tempCouldDatingDoctors addObject:tempModel];
    }
    _couldDatingDoctorList = [[NSArray alloc] initWithArray:tempCouldDatingDoctors];
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
    static NSString *hospitalCellIden = @"HospitalCellIden";
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:hospitalCellIden];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:hospitalCellIden];
            [[EGOImageLoader sharedImageLoader] loadImageForURL:[NSURL URLWithString:self.hospitalsModel.hospitalLogoUrl] observer:self];
            [cell.imageView setImage:[UIImage imageNamed:@"Information_Cell_DefaultImage"]];
            cell.textLabel.text = self.hospitalsModel.hospitalName;
            cell.detailTextLabel.text = @"testtesttest";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
    }else{
        ScreeingDatingDoctorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:datingDoctorCellIden];
        if (!cell) {
            cell = [[ScreeingDatingDoctorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:datingDoctorCellIden];
            cell.delegate = self;
        }
        [cell setContentByInfoModel:self.couldDatingDoctorList[indexPath.row]];
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ScreeningCenterInfoVIewController *centerInfo = [[ScreeningCenterInfoVIewController alloc] initWithModel:nil];
    [self.navigationController pushViewController:centerInfo animated:YES];
}

#pragma mark - Delegate
- (void)willDatingDoctor:(ScreeingDatingDoctorsModel *)model{
    SubmitDatingInfoViewController *submitDating = [[SubmitDatingInfoViewController alloc] init];
    [self.navigationController pushViewController:submitDating animated:YES];
}

#pragma mark EgoImageLoader
- (void)imageLoaderDidLoad:(NSNotification*)notification{
    NSLog(@"imageLoaderDidLoad----%@",[notification userInfo]);
}
@end

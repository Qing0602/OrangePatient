//
//  AddDoctorForChooseDoctorViewController.m
//  OrangePatient
//
//  Created by ZhangQing on 15/4/2.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "AddDoctorForChooseDoctorViewController.h"

#import "AddDoctorForChooseDoctorCell.h"
#import "ChooseDoctorModel.h"
@interface AddDoctorForChooseDoctorViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSString *_hospitalName;
}
@property (nonatomic, strong)UITableView *chooseDoctorTableview;
@property (nonatomic, strong)NSArray *couldSelectedDoctorsList;

@end

@implementation AddDoctorForChooseDoctorViewController
- (instancetype)initWithDoctorModel:(NSArray *)doctorModels andHospitalName:(NSString *)hospitalName{
    self = [super init];
    if (self) {
        self.couldSelectedDoctorsList = doctorModels;
        _hospitalName = hospitalName;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _hospitalName;
    
    _chooseDoctorTableview = [[UITableView alloc] init];
    _chooseDoctorTableview.dataSource = self;
    _chooseDoctorTableview.delegate = self;
    _chooseDoctorTableview.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_chooseDoctorTableview];
    
    [_chooseDoctorTableview mas_makeConstraints:^(MASConstraintMaker *make){
        make.edges.equalTo(self.view);
    }];
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
- (void)setCouldSelectedDoctorsList:(NSArray *)couldSelectedDoctorsList{
    NSMutableArray *tempCouldSelectedDoctorsList = [[NSMutableArray alloc] initWithCapacity:couldSelectedDoctorsList.count];
    for (NSDictionary *dic in couldSelectedDoctorsList) {
        if (dic && dic.allKeys.count) {
            [tempCouldSelectedDoctorsList addObject:[ChooseDoctorModel convertModelByDic:dic]];
        }
    }
    _couldSelectedDoctorsList = [[NSArray alloc] initWithArray:tempCouldSelectedDoctorsList];
}
#pragma mark - UITableview
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.couldSelectedDoctorsList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *chooseDoctorCellIden = @"ChooseDoctorCellIden";
    AddDoctorForChooseDoctorCell *cell = [tableView dequeueReusableCellWithIdentifier:chooseDoctorCellIden];
    if (!cell) {
        cell = [[AddDoctorForChooseDoctorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:chooseDoctorCellIden];
    }
    [cell setContentByInfoModel:self.couldSelectedDoctorsList[indexPath.row]];
    return cell;
    

}

@end

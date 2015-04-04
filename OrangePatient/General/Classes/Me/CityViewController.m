//
//  CityViewController.m
//  OrangePatient
//
//  Created by singlew on 15/4/3.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "CityViewController.h"
#import "UIManagement.h"

@interface CityViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSDictionary *area;
@property (nonatomic,strong) UITableView *cityTableView;
@property (nonatomic,strong) NSArray *cityArray;
@end

@implementation CityViewController

-(id) initCityViewController : (NSDictionary *) area{
    self = [self init];
    if (self != nil) {
        self.area = area;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cityTableView = [[UITableView alloc] init];
    self.cityTableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.cityTableView.delegate = self;
    self.cityTableView.dataSource = self;
    [self.view addSubview:self.cityTableView];
    
    NSDictionary *views = @{@"topLayoutGuide":self.topLayoutGuide,
                            @"cityTableView":self.cityTableView};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[cityTableView]-0-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[cityTableView]-0-|" options:0 metrics:nil views:views]];
    [[UIManagement sharedInstance] addObserver:self forKeyPath:@"getCityResult" options:0 context:nil];
    [[UIManagement sharedInstance] getCity:[self.area[@"code"] integerValue]];
    
}

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"getCityResult"]) {
        if (![[UIManagement sharedInstance].getCityResult[ASI_REQUEST_HAS_ERROR] boolValue]) {
            NSArray *data = [UIManagement sharedInstance].getCityResult[ASI_REQUEST_DATA];
            self.cityArray = [NSMutableArray arrayWithArray:data];
            [self.cityTableView reloadData];
        }
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.cityArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIden = @"settingTableViewCellIden";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
        cell.textLabel.font = [UIFont systemFontOfSize:16.f];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    NSDictionary *dic = self.cityArray[indexPath.row];
    cell.textLabel.text = dic[@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *data = @[self.area,self.cityArray[indexPath.row]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeArea" object:data];
    [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) dealloc{
    [[UIManagement sharedInstance] removeObserver:self forKeyPath:@"getCityResult"];
}

@end

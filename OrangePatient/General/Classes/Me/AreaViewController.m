//
//  AreaViewController.m
//  OrangePatient
//
//  Created by singlew on 15/4/3.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "AreaViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "UIManagement.h"
#import "CityViewController.h"

@interface AreaViewController ()<CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) CLLocationManager* locationManager;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *currentLocation;
@property (nonatomic,strong) UITableView *areaTableView;

@property (nonatomic,strong) NSMutableArray *areaArray;
@end

@implementation AreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.text = @"定位到的位置";
    [self.view addSubview:self.titleLabel];
    
    self.currentLocation = [[UILabel alloc] init];
    self.currentLocation.translatesAutoresizingMaskIntoConstraints = NO;
    self.currentLocation.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.currentLocation];
    
    self.areaTableView = [[UITableView alloc] init];
    self.areaTableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.areaTableView.delegate = self;
    self.areaTableView.dataSource = self;
    [self.view addSubview:self.areaTableView];
    
    NSDictionary *views = @{@"topLayoutGuide":self.topLayoutGuide,@"titleLabel":self.titleLabel,@"currentLocation":self.currentLocation,
                            @"areaTableView":self.areaTableView};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[titleLabel]-0-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[currentLocation]-0-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[areaTableView]-0-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide]-15-[titleLabel(20)]-10-[currentLocation(26)]-10-[areaTableView]-0-|" options:0 metrics:nil views:views]];
    
    [self startLocation];
    [[UIManagement sharedInstance] addObserver:self forKeyPath:@"getAreaResult" options:0 context:nil];
    [[UIManagement sharedInstance] getArea];
}

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"getAreaResult"]) {
        if (![[UIManagement sharedInstance].getAreaResult[ASI_REQUEST_HAS_ERROR] boolValue]) {
            NSArray *data = [UIManagement sharedInstance].getAreaResult[ASI_REQUEST_DATA];
            self.areaArray = [NSMutableArray arrayWithArray:data];
            [self.areaTableView reloadData];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//开始定位
-(void)startLocation{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 10.0f;
    [self.locationManager startUpdatingLocation];
}

//定位代理经纬度回调
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    [self.locationManager stopUpdatingLocation];
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks) {
            NSDictionary *test = [placemark addressDictionary];
            //  Country(国家)  State(城市)  SubLocality(区)
            self.currentLocation.text = [test objectForKey:@"State"];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.areaArray count];
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
    NSDictionary *dic = self.areaArray[indexPath.row];
    cell.textLabel.text = dic[@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CityViewController *city = [[CityViewController alloc] initCityViewController:self.areaArray[indexPath.row]];
    [self.navigationController pushViewController:city animated:YES];
}

-(void)dealloc{
    [[UIManagement sharedInstance] removeObserver:self forKeyPath:@"getAreaResult"];
}
@end

//
//  FeedBackChooseViewController.m
//  OrangePatient
//
//  Created by singlew on 15/5/6.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "FeedBackChooseViewController.h"

@interface FeedBackChooseViewController ()<UINavigationControllerDelegate>
@property (nonatomic,strong) UILabel *label1;
@property (nonatomic,strong) UILabel *label2;
@property (nonatomic,strong) UILabel *label3;

@property (nonatomic,strong) UIView *bg1;
@property (nonatomic,strong) UIView *bg2;
@property (nonatomic,strong) UIView *bg3;

@property (nonatomic,strong) UIImageView *choose1;
@property (nonatomic,strong) UIImageView *choose2;
@property (nonatomic,strong) UIImageView *choose3;

@property (nonatomic,strong) UILabel *line1;
@property (nonatomic,strong) UILabel *line2;
@property (nonatomic,strong) UILabel *line3;

@property (nonatomic) BOOL flag1;
@property (nonatomic) BOOL flag2;
@property (nonatomic) BOOL flag3;

@end

@implementation FeedBackChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bg1 = [[UIView alloc] init];
    self.bg1.backgroundColor = [UIColor whiteColor];
    self.bg1.translatesAutoresizingMaskIntoConstraints = NO;
    self.bg1.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1)];
    [self.bg1 addGestureRecognizer:tap1];
    [self.view addSubview:self.bg1];
    
    self.label1 = [[UILabel alloc] init];
    self.label1.backgroundColor = [UIColor clearColor];
    self.label1.translatesAutoresizingMaskIntoConstraints = NO;
    self.label1.text = @"用户体验不好";
    [self.bg1 addSubview:self.label1];
    
    self.choose1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MyUnChoosed"]];
    self.choose1.translatesAutoresizingMaskIntoConstraints = NO;
    [self.bg1 addSubview:self.choose1];
    
    self.line1 = [[UILabel alloc] init];
    self.line1.translatesAutoresizingMaskIntoConstraints = NO;
    self.line1.backgroundColor = [UIColor colorWithHexString:@"d6d6d9"];
    [self.view addSubview:self.line1];
    
    self.bg2 = [[UIView alloc] init];
    self.bg2.backgroundColor = [UIColor whiteColor];
    self.bg2.translatesAutoresizingMaskIntoConstraints = NO;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2)];
    [self.bg2 addGestureRecognizer:tap2];
    [self.view addSubview:self.bg2];
    
    self.label2 = [[UILabel alloc] init];
    self.label2.backgroundColor = [UIColor clearColor];
    self.label2.translatesAutoresizingMaskIntoConstraints = NO;
    self.label2.text = @"缺少必要的功能";
    [self.bg2 addSubview:self.label2];
    
    self.choose2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MyUnChoosed"]];
    self.choose2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.bg2 addSubview:self.choose2];
    
    self.line2 = [[UILabel alloc] init];
    self.line2.translatesAutoresizingMaskIntoConstraints = NO;
    self.line2.backgroundColor = [UIColor colorWithHexString:@"d6d6d9"];
    [self.view addSubview:self.line2];
    
    
    self.bg3 = [[UIView alloc] init];
    self.bg3.backgroundColor = [UIColor whiteColor];
    self.bg3.translatesAutoresizingMaskIntoConstraints = NO;
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap3)];
    [self.bg3 addGestureRecognizer:tap3];
    [self.view addSubview:self.bg3];
    
    self.label3 = [[UILabel alloc] init];
    self.label3.backgroundColor = [UIColor clearColor];
    self.label3.translatesAutoresizingMaskIntoConstraints = NO;
    self.label3.text = @"医患互动不及时";
    [self.bg3 addSubview:self.label3];
    
    self.choose3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MyUnChoosed"]];
    self.choose3.translatesAutoresizingMaskIntoConstraints = NO;
    [self.bg3 addSubview:self.choose3];
    
    self.line3 = [[UILabel alloc] init];
    self.line3.translatesAutoresizingMaskIntoConstraints = NO;
    self.line3.backgroundColor = [UIColor colorWithHexString:@"d6d6d9"];
    [self.view addSubview:self.line3];
    
    self.flag1 = NO;
    self.flag2 = NO;
    self.flag3 = NO;
    
    self.navigationController.delegate = self;
    
    NSDictionary *views = @{@"topLayoutGuide":self.topLayoutGuide,@"bg1":self.bg1,@"bg2":self.bg2,@"bg3" : self.bg3,
                            @"label1" : self.label1,@"label2":self.label2,@"label3":self.label3,
                            @"choose1" : self.choose1,@"choose2" : self.choose2,@"choose3" : self.choose3,
                            @"line1" : self.line1,@"line2" : self.line2,@"line3" : self.line3};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[bg1]-0-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[bg2]-0-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[bg3]-0-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[line1]-0-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[line2]-0-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[line3]-0-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide]-0-[bg1(55)]-0-[line1(1)]-0-[bg2(55)]-0-[line2(1)]-0-[bg3(55)]-0-[line3(1)]" options:0 metrics:nil views:views]];
    
    [self.bg1 addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[label1(150)]" options:0 metrics:nil views:views]];
    [self.bg1 addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[choose1(22)]-22-|" options:0 metrics:nil views:views]];
    [self.bg1 addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-21-[label1]" options:0 metrics:nil views:views]];
    [self.bg1 addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-21-[choose1]" options:0 metrics:nil views:views]];
    
    [self.bg2 addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[label2(150)]" options:0 metrics:nil views:views]];
    [self.bg2 addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[choose2(22)]-22-|" options:0 metrics:nil views:views]];
    [self.bg2 addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-21-[label2]" options:0 metrics:nil views:views]];
    [self.bg2 addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-21-[choose2]" options:0 metrics:nil views:views]];
    
    [self.bg3 addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[label3(150)]" options:0 metrics:nil views:views]];
    [self.bg3 addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[choose3(22)]-22-|" options:0 metrics:nil views:views]];
    [self.bg3 addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-21-[label3]" options:0 metrics:nil views:views]];
    [self.bg3 addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-21-[choose3]" options:0 metrics:nil views:views]];
}

-(void) tap1{
    if (!self.flag1) {
        self.choose1.image = [UIImage imageNamed:@"MyChoosed"];
    }else{
        self.choose1.image = [UIImage imageNamed:@"MyUnChoosed"];
    }
    self.flag1 = !self.flag1;
}

-(void) tap2{
    if (!self.flag2) {
        self.choose2.image = [UIImage imageNamed:@"MyChoosed"];
    }else{
        self.choose2.image = [UIImage imageNamed:@"MyUnChoosed"];
    }
    self.flag2 = !self.flag2;
}

-(void) tap3{
    if (!self.flag3) {
        self.choose3.image = [UIImage imageNamed:@"MyChoosed"];
    }else{
        self.choose3.image = [UIImage imageNamed:@"MyUnChoosed"];
    }
    self.flag3 = !self.flag3;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    if (self.flag1) {
        [array addObject:self.label1.text];
    }
    if (self.flag2){
        [array addObject:self.label2.text];
    }
    if (self.flag3){
        [array addObject:self.label3.text];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"choose" object:array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

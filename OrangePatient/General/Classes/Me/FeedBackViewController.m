//
//  FeedBackViewController.m
//  OrangePatient
//
//  Created by singlew on 15/4/5.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "FeedBackViewController.h"
#import "UIManagement.h"

@interface FeedBackViewController ()
@property (nonatomic,strong) UITextView *text;
-(void) submitFeedBack;
@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *title = [[UILabel alloc] init];
    title.translatesAutoresizingMaskIntoConstraints = NO;
    title.font = [UIFont systemFontOfSize:14.0f];
    title.text = @"您的意见";
    [self.view addSubview:title];
    
    self.text = [[UITextView alloc] init];
    self.text.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.text];
    
    UIButton *submit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    submit.translatesAutoresizingMaskIntoConstraints = NO;
    [submit setTitle:@"提交" forState:UIControlStateNormal];
    [submit.layer setMasksToBounds:YES];
    [submit.layer setCornerRadius:5.0];
    [submit.layer setBorderWidth:1.0];
    [submit.layer setBorderColor:[UIColor grayColor].CGColor];
    submit.backgroundColor = [UIColor whiteColor];
    [submit addTarget:self action:@selector(submitFeedBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submit];
    
    NSDictionary *views = @{@"topLayoutGuide":self.topLayoutGuide,@"titleLabel":title,@"_text":self.text,@"submit":submit};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[titleLabel]-10-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[_text]-10-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-100-[submit]-100-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide]-10-[titleLabel(20)]-10-[_text(100)]-30-[submit(26)]" options:0 metrics:nil views:views]];
    [[UIManagement sharedInstance] addObserver:self forKeyPath:@"feedBackResult" options:0 context:nil];
}

-(void) submitFeedBack{
    if (self.text.text == nil || [self.text.text isEqualToString:@""]) {
        [self showProgressWithText:@"建议不能为空" withDelayTime:2.0f];
        return;
    }
    [[UIManagement sharedInstance] feedBack:self.text.text];
}

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"feedBackResult"]) {
        if ([[UIManagement sharedInstance].feedBackResult[ASI_REQUEST_HAS_ERROR] boolValue] == YES) {
            [self showProgressWithText:[UIManagement sharedInstance].feedBackResult[ASI_REQUEST_ERROR_MESSAGE] withDelayTime:3.0f];
        }else{
            [self showProgressWithText:@"提交成功" withDelayTime:2.0f];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc{
    [[UIManagement sharedInstance] removeObserver:self forKeyPath:@"feedBackResult"];
}

@end

//
//  FeedBackViewController.m
//  OrangePatient
//
//  Created by singlew on 15/4/5.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "FeedBackViewController.h"
#import "UIManagement.h"
#import "FeedBackChooseViewController.h"

@interface FeedBackViewController ()<UITextViewDelegate>
@property (nonatomic,strong) UITextView *text;
@property (nonatomic,strong) UILabel *contentLabel;
-(void) submitFeedBack;
@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *titleType = [[UILabel alloc] init];
    titleType.translatesAutoresizingMaskIntoConstraints = NO;
    titleType.text = @"您的意见:";
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [titleType addGestureRecognizer:tap1];
    titleType.userInteractionEnabled = YES;
    titleType.font = [UIFont boldSystemFontOfSize:17.0f];
    [self.view addSubview:titleType];
    
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.contentLabel];
    
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.translatesAutoresizingMaskIntoConstraints = NO;
    descLabel.text = @"选择反馈意见类型 >";
    descLabel.font = [UIFont systemFontOfSize:15.0f];
    descLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [descLabel addGestureRecognizer:tap];
    descLabel.userInteractionEnabled = YES;
    [self.view addSubview:descLabel];
    
    UILabel *line = [[UILabel alloc] init];
    line.translatesAutoresizingMaskIntoConstraints = NO;
    line.backgroundColor = [UIColor colorWithHexString:@"#d0cfd3"];
    [self.view addSubview:line];
    
    UILabel *title = [[UILabel alloc] init];
    title.translatesAutoresizingMaskIntoConstraints = NO;
    title.font = [UIFont systemFontOfSize:17.0f];
    title.font = [UIFont boldSystemFontOfSize:17.0f];
    title.text = @"其他意见:";
    [self.view addSubview:title];
    
    self.text = [[UITextView alloc] init];
    self.text.translatesAutoresizingMaskIntoConstraints = NO;
    self.text.text = @"如用户体验不好，医患互动不及时等....";
    self.text.textColor = [UIColor colorWithHexString:@"#666666"];
    self.text.font = [UIFont systemFontOfSize:17.0f];
    self.text.delegate = self;
    [self.view addSubview:self.text];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submitFeedBack)];
    rightButton.tintColor = [UIColor colorWithHexString:@"#ef7f30"];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    NSDictionary *views = @{@"topLayoutGuide":self.topLayoutGuide,@"titleLabel":title,@"_text":self.text,@"titleType" : titleType,@"contentLabel" : self.contentLabel,@"descLabel":descLabel,@"line":line};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-21-[titleType(80@998)]-10-[contentLabel(>=60@997)]-10-[descLabel(140@999)]-18-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[line]-0-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-21-[titleLabel]-21-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-16-[_text]-16-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide]-20-[titleType(20)]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide]-20-[contentLabel(20)]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide]-20-[descLabel(20)]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[titleType]-16-[line(1)]" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[line]-16-[titleLabel(20)]-1-[_text(100)]" options:0 metrics:nil views:views]];
    [[UIManagement sharedInstance] addObserver:self forKeyPath:@"feedBackResult" options:0 context:nil];
    self.title = @"意见反馈";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(choose:) name:@"choose" object:nil];
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

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"如用户体验不好，医患互动不及时等...."]) {
        textView.text = @"";
    }
}

-(void) tap{
    FeedBackChooseViewController *choose = [[FeedBackChooseViewController alloc] init];
    [self.navigationController pushViewController:choose animated:YES];
}

-(void) choose : (NSNotification *) notification{
    NSMutableArray *array = notification.object;
    NSMutableString *text = [[NSMutableString alloc] init];
    for (NSInteger i = 0 ; i<[array count]; i++) {
        if (i == [array count] - 1) {
            [text appendString:array[i]];
        }else{
            [text appendString:array[i]];
            [text appendString:@","];
        }
    }
    self.contentLabel.text = text;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc{
    [[UIManagement sharedInstance] removeObserver:self forKeyPath:@"feedBackResult"];
}

@end

//
//  PalmViewController.m
//  teacher
//
//  Created by singlew on 14-3-8.
//  Copyright (c) 2014年 ws. All rights reserved.
//

#import "PalmViewController.h"

@interface PalmViewController ()<UINavigationControllerDelegate>
#pragma mark -
#pragma mark private MBProgressHUD Methods
-(void) showProgress;
-(void) autoCloseProgress;
-(void) showProgressAutoCloseInNetwork;
-(void) showProgressAutoWithText : (NSString *) context withDelayTime : (NSUInteger) sec;

#pragma mark -
#pragma mark Transfer Value Between MultiVC
-(void) receiveValue;
@end

@implementation PalmViewController
@synthesize screenTop = _screenTop;

- (id)init{
    self = [super init];
    if (self) {
        //初始化导航条
        [self initNavigationBar];
        if (isIPhone5) {
            self.screenHeight = 568.0f;
        }else{
            self.screenHeight = 480.0f;
        }
//        [[PalmUIManagement sharedInstance] addObserver:self forKeyPath:@"transferDic" options:0 context:nil];
    }
    return self;
}

#pragma mark ----导航栏设置
- (void)initNavigationBar{
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    self.navigationController.delegate = self;
}

- (void)dealloc{
//    [[PalmUIManagement sharedInstance] removeObserver:self forKeyPath:@"transferDic"];
}

#pragma mark -
#pragma 刷新userprofile KVO

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"transferDic"]){
        [self receiveValue];
    }
}

#pragma mark -
#pragma mark 页面传值接口

-(void) receiveValue{
   //id value = [[PalmUIManagement sharedInstance].transferDic objectForKey:TRANSFERVALUE];
//    Class fromClazz = [[PalmUIManagement sharedInstance].transferDic objectForKey:TRANSFERVCFROMCLASS];
//    NSString *toClassName = [[PalmUIManagement sharedInstance].transferDic objectForKey:TRANSFERVCTOCLASS];
//    [self callbackValue:value fromViewControllerClass:fromClazz toViewControllerClassName:toClassName];
}

-(void) transferValue : (id) value toViewControllerClassName : (NSString *) toClazzName{
//    if (nil != value && nil != toClazzName && ![toClazzName isEqualToString:@""]) {
//        Class fromClazz = [self class];
//        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:value,TRANSFERVALUE,
//                             fromClazz,TRANSFERVCFROMCLASS,toClazzName,TRANSFERVCTOCLASS,nil];
       // [PalmUIManagement sharedInstance].transferDic = dic;
//    }
}
-(void) callbackValue : (id) value fromViewControllerClass : (Class) fromClazz toViewControllerClassName : (NSString *) toClazzName{
    
}

- (void)viewDidLoad{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f0eb"];
    float currentVersion = 7.0;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= currentVersion) {
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
            self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    if ([self currentVersion] == kIOS7){
        _screenTop = 20.0f;
    }else{
        _screenTop = 0.0f;
    }
}

/*! @brief 初始化导航栏左侧按钮
 *  CustomNavigationBarLeftButton : 创建导航栏左侧按钮的类型
 *  返回创建好的导航栏左侧按钮
 */
-(UIBarButtonItem *) createNavLeftButton : (CustomNavigationBarLeftButton) type withSEL:(SEL)action{
    NSString *imageName = @"";
    NSString *imagePressName = @"";
    switch (type) {
        case kCustomNavLeftType1:
            imageName = @"NaviLeftType1";
            imagePressName = @"NaviLeftTypePress1";
            break;
        case kCustomNavLeftType2:
            imageName = @"NaviLeftType2";
            imagePressName = @"NaviLeftTypePress2";
            break;
        default:
            break;
    }
    
    NSInteger x = -15.0f;
    if (self.currentVersion == kIOS6) {
        x = -10.0f;
    }
    UIButton *leftbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    leftbutton.frame=CGRectMake(x, 0.0f, 64.0f, 44.0f);
    [leftbutton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [leftbutton setImage:[UIImage imageNamed:imagePressName] forState:UIControlStateHighlighted];
    leftbutton.backgroundColor = [UIColor clearColor];
    if ([self respondsToSelector:action]) {
        [leftbutton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(-5.0f, 0.0f, 64.0f, 44.0f)];
    [leftView addSubview:leftbutton];
    if (type == kCustomNavLeftType1) {

    }
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    return leftBar;
}

/*! @brief 初始化导航栏右侧按钮
 *  CustomNavigationBarRightButton : 创建导航栏右侧按钮的类型
 *  返回创建好的导航栏右侧按钮
 */
-(UIBarButtonItem *) createNavRightButton : (CustomNavigationBarRightButton) type withSEL:(SEL)action{
    NSString *imageName = @"";
    NSString *imagePressName = @"";
    NSInteger width = 64.0f;
    NSInteger x = 14.0f;
    if (self.currentVersion == kIOS6) {
        x = 7.0f;
    }
    switch (type) {
        case kCustomNavRightType1:
            imageName = @"NaviRightType1";
            imagePressName = @"NaviRightTypePress1";
            break;
        default:
            break;
    }
    
    if ([imageName isEqualToString:@""] || [imagePressName isEqualToString:@""]) {
        return nil;
    }
    
    UIButton *rightButtonT=[UIButton buttonWithType:UIButtonTypeCustom];
    rightButtonT.frame=CGRectMake(x, 0.0f, width, 44.0f);
    [rightButtonT setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [rightButtonT setImage:[UIImage imageNamed:imagePressName] forState:UIControlStateHighlighted];
    rightButtonT.backgroundColor = [UIColor clearColor];
    if ([self respondsToSelector:action]) {
        [rightButtonT addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    }
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, width, 44.0f)];
    [rightView addSubview:rightButtonT];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    return rightBar;
}

-(void) clickLeftBarButtonItem{
//    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_PopViewController object:nil];
}

-(IOSVersion) currentVersion{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f && [[[UIDevice currentDevice] systemVersion] floatValue] < 8.0f) {
        return kIOS7;
    }else if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f && [[[UIDevice currentDevice] systemVersion] floatValue]>= 6.0f){
        return kIOS6;
    }else{
        return kIOS5;
    }
}

#pragma mark -
#pragma mark MBProgressHUD Methods

-(void) showProgress{
    if (nil != self.navigationController.view) {
        self.progressHUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        self.progressHUD.delegate = self;
        self.progressHUD.detailsLabelFont = [UIFont boldSystemFontOfSize:14.0f];
        isAutoCloseProgress = NO;
    }
}

-(void) showProgressWithText : (NSString *) context withDelayTime : (NSUInteger) sec{
    
    if (nil == context || [context isEqualToString:@""]) {
        return;
    }
    
    if (nil == self.progressHUD) {
        [self showProgress];
    }
    
    if (sec <= 1) {
        sec = 2;
    }
    self.progressHUD.mode = MBProgressHUDModeText;
    self.progressHUD.detailsLabelText = context;
    [self.progressHUD hide:YES afterDelay:sec];
}

-(void) showProgressWithText:(NSString *)text{
    [self showProgress];
    self.progressHUD.detailsLabelText = text;
}

-(void) showProgressWithText:(NSString *)text dimBackground:(BOOL)isBackground{
    [self showProgressWithText:text];
    self.progressHUD.dimBackground = isBackground;
}

-(void) showProgressAutoCloseInNetwork{
    [self showProgress];
    isAutoCloseProgress = YES;
}

-(void) showProgressAutoCloseInNetwork:(NSString *)text{
    [self showProgressAutoCloseInNetwork];
    self.progressHUD.detailsLabelText = text;
}

-(void) showProgressAutoCloseInNetwork : (NSString *) text dimBackground : (BOOL) isBackground{
    [self showProgressAutoCloseInNetwork:text];
    self.progressHUD.dimBackground = isBackground;
}

-(void) autoCloseProgress{
    if (isAutoCloseProgress && nil != self.progressHUD) {
        [self.progressHUD hide:YES];
    }
}

-(void) showProgressAutoWithText : (NSString *) context withDelayTime : (NSUInteger) sec{
    [self showProgressWithText:context withDelayTime:sec];
}

-(void) closeProgress{
    if (nil != self.progressHUD) {
        [self.progressHUD hide:YES];
    }
}

-(void) showWhileExecuting : (SEL) sel withText : (NSString *) text withDetailText : (NSString *) detailText{
    if (nil != self.progressHUD) {
        return;
    }
    self.progressHUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:self.progressHUD];
    self.progressHUD.delegate = self;
    
    if ([self stringIsNilOrEmpty:text]) {
        self.progressHUD.labelText = text;
    }
    
    if ([self stringIsNilOrEmpty:detailText]) {
        self.progressHUD.detailsLabelText = detailText;
    }
    
	[self.progressHUD showWhileExecuting:sel onTarget:self withObject:nil animated:YES];
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
	[self.progressHUD removeFromSuperview];
	self.progressHUD = nil;
}

#pragma mark -
#pragma mark Other methods
-(BOOL) stringIsNilOrEmpty : (NSString *) str{
    if (nil != str && ![str isEqualToString:@""]) {
        return NO;
    }else{
        return YES;
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    [[PalmUIManagement sharedInstance] canelUIHttpRequestFrom:self];
//    [self clearUINetWorkStatus];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  PalmViewController.h
//  teacher
//
//  Created by singlew on 14-3-8.
//  Copyright (c) 2014年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PalmVCBaseProtocol.h"
#import "MBProgressHUD.h"

#define HUDDelay 2
#define isIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)
#define IOS6 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0 ? YES : NO)
typedef enum{
    kIOS5,
    kIOS6,
    kIOS7,
    kIOS8,
}IOSVersion;

typedef enum{
    /*! @brief 返回箭头
     *
     */
    kCustomNavLeftType1,
    /*! @brief X子
     *
     */
    kCustomNavLeftType2,
}CustomNavigationBarLeftButton;

typedef enum{
    /*! @brief 我的资料页编辑
     *
     */
    kCustomNavRightType1,
}CustomNavigationBarRightButton;

@interface PalmViewController : UIViewController<MBProgressHUDDelegate,PalmVCBaseProtocol>{
    BOOL isAutoCloseProgress;
}
/*! @brief 获取当前设备的屏幕高度
 *
 */
@property CGFloat screenHeight;
@property (nonatomic,strong) MBProgressHUD *progressHUD;
@property (nonatomic,strong) NSString *willShowViewControllerClassName;
@property (nonatomic,readonly,getter = getScreenTop) float screenTop;

/*! @brief 获取当前IOS版本
 *
 */
-(IOSVersion) currentVersion;

/*! @brief 初始化导航栏左侧按钮
 *  CustomNavigationBarLeftButton : 创建导航栏左侧按钮的类型
 *  action 事件
 *  返回创建好的导航栏左侧按钮
 */
-(UIBarButtonItem *) createNavLeftButton : (CustomNavigationBarLeftButton) type withSEL : (SEL) action;

/*! @brief 初始化导航栏右侧按钮
 *  CustomNavigationBarRightButton : 创建导航栏右侧按钮的类型
 *  action 事件
 *  返回创建好的导航栏右侧按钮
 */
-(UIBarButtonItem *) createNavRightButton : (CustomNavigationBarRightButton) type withSEL : (SEL) action;
/*! @brief 点击导航栏左侧按钮
 *
 */
-(void) clickLeftBarButtonItem;

/*! @brief 判断字符串是否是nil或者是@“”
 *
 */
-(BOOL) stringIsNilOrEmpty : (NSString *) str;

#pragma mark -
#pragma mark MBProgressHUD Methods
-(void) showProgressWithText : (NSString *) context;
-(void) showProgressWithText : (NSString *) context dimBackground : (BOOL) isBackground;
/*
 AutoCloseInNetwork方法在网络层调用正确时，自动关闭浮层，UI层如果需要显示完成信息的话使用[showProgressWithText:context withDelayTime:sec] 方法
 当网络访问出错时，错误浮层自动更换，UI层无需实现，如不须显示错误信息，UI层重写[showProgressWithText:context withDelayTime:sec]方法
 */
-(void) showProgressAutoCloseInNetwork : (NSString *) context;
-(void) showProgressAutoCloseInNetwork : (NSString *) context dimBackground : (BOOL) isBackground;
-(void) showProgressWithText : (NSString *) context withDelayTime : (NSUInteger) sec;
// 针对于大数据处理、视频处理、及一些及其消耗时间的本地处理等情况
-(void) showWhileExecuting : (SEL) sel withText : (NSString *) text withDetailText : (NSString *) detailText;
-(void) closeProgress;
@end

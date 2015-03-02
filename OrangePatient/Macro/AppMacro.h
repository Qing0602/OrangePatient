//
//  AppMacro.h
//  iCatering
//*****************************************
//APP相关宏定义
//*****************************************
//  Created by ZhangQing on 14-3-3.
//  Copyright (c) 2014年 ZhangQing. All rights reserved.
//

#ifndef iCatering_AppMacro_h
#define iCatering_AppMacro_h

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kSuperViewHeight (iPhone5 ? 548 - 44 : 460 - 44)
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)



/*************************/
#define K_MSGGROUPID @"msgroupID"
//消息未读数通知Key
//#define K_UnreadedMessage_Noti @"UnreadedMessageNoti"
//#define CachedUnreadNumber @"cachedUnreadNumber"

//版本更新
#define CurrentAppVersion @"currentAppVersion"



/**********************************************************************
 ***************AppGuidViewController****************************
 ***********************************************************************/
#pragma mark AppGuidViewController
//确认按钮
#define FLOAT_CONFIRMBUTTON_WIDTH 120.f
#define FLOAT_CONFIRMBUTTON_HEIGHT 40.f
#define STRING_CONFIRMBUTTON_TITLE @"确认"
//店名输入框
#define FLOAT_TEXTFIELD_SHOPNAME_WIDTH 160.f
#define FLOAT_TEXTFIELD_SHOPNAME_HEIGHT 40.f
//有帐号登陆按钮
#define STRING_BTNTURNTOLOGINPAGE_TITLE @"已有店铺，去登陆"
/**********************************************************************
 ***************LeftMenuViewController****************************
 ***********************************************************************/
#pragma mark LeftMenuViewController
//左侧菜单打开的宽度
#define FLOAT_DYNAMICSCONTROLLER_OPENSTATEREVAL_WIDTH 300.f
//Tableview
#define FLOAT_TABLEVIEW_HEADVIEW_HEIGHT 40.f
#define FLOAT_TABLEVIEW_WIDECELL_HEIGHT 40.f
#define FLOAT_TABLEVIEW_THINCELL_HEIGHT 40.f
/**********************************************************************
 ***************TabbarController****************************
 ***********************************************************************/
#define BtnWidth 50.f
#define BtnHeight 50.f
#define BtnNumPerLine 4
#define LeftPadding 15.f
#define TopPadding 20.f
#define BtnWidthInterval (320-LeftPadding*2-BtnWidth*BtnNumPerLine)/(BtnNumPerLine-1)
#define ItemHeightInterval 10.f
#define ItemHeight BtnHeight+26.f
/**********************************************************************
 ***************物业模块****************************
 ***********************************************************************/
#define HOMEPAGE_BG_COLOR [UIColor colorWithHexString:@"#EEEEEE"];
#endif

//
//  AppMacro.h
//*****************************************
//APP相关宏定义
//*****************************************
//  Created by ZhangQing on 15-3-3.
//  Copyright (c) 2014年 ZhangQing. All rights reserved.
//

#ifndef iCatering_AppMacro_h
#define iCatering_AppMacro_h

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define KNOTIFICATION_LOGINCHANGE @"loginStateChange"

#define CHATVIEWBACKGROUNDCOLOR [UIColor colorWithRed:0.936 green:0.932 blue:0.907 alpha:1]
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kSuperViewHeight (iPhone5 ? 548 - 44 : 460 - 44)
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define KeyBoardHeight 216.f

//UIManagement
#define SerializeUserAccountModelName @"SerializeUserAccountModel.cac"

//ADBanner
#define Banner_AutoScroll_Timeiterval 3.f

//Login
#define Login_TextField_Widht 240.f
#define Login_TextField_Height 30.f

//Register
#define Register_TableviewCell_Height 52.f

#endif

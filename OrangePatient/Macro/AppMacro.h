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

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kSuperViewHeight (iPhone5 ? 548 - 44 : 460 - 44)
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)




#endif

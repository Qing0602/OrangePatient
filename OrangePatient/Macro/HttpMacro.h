//
//  HttpMacro.h
//
//  Created by ZhangQing on 15-3-3.
//  Copyright (c) 2014年 ZhangQing. All rights reserved.
//

#ifndef PropertyManagementSystem_HttpMacro_h
#define PropertyManagementSystem_HttpMacro_h



/**********************************************************************
 ************************************HTTP****************************
 ***********************************************************************/
#define K_NAME_RESULT         @"HasError"
#define K_NAME_ERROR          @"Error"
#define K_NAME_DATA             @"Entity"
//使用外网时就注释掉
#define INNER_TEST

#ifdef INNER_TEST

#define K_HOST_OF_PASSPORT_SERVER           @"http://115.28.81.165/"
#define SystemDomin @"115.28.81.165"
#else
#define K_HOST_OF_PASSPORT_SERVER           @"http://115.29.178.164/"
#define SystemDomin @"115.29.178.164"

#endif

#define SystemResource @"/resource"
#define K_HOST_OF_JID_DOMIN @"localhost"



#endif

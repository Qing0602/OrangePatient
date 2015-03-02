//
//  PalmVCBaseProtocol.h
//  teacher
//
//  Created by singlew on 14-3-8.
//  Copyright (c) 2014年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PalmVCBaseProtocol <NSObject>
// 开始页面间传值
// value 为需要传递的model
-(void) transferValue : (id) value toViewControllerClassName : (NSString *) toClazzName;

// 页面间传值接口
// value 接收到的model
// clazz 为传递该model的viewcontroller的class

/*! @brief 接收页面间传值的接口
 *
 */
-(void) callbackValue : (id) value fromViewControllerClass : (Class) fromClazz toViewControllerClassName : (NSString *) toClazzName;
@end

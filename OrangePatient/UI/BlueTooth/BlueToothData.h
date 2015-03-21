//
//  BlueToothData.h
//  OrangePatient
//
//  Created by singlew on 15/3/12.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIModelCoding.h"
//@interface BlueToothDateInfo : NSObject
//// 血氧
//@property (nonatomic) NSInteger spo2;
//// 脉率
//@property (nonatomic) NSInteger pr;
//// 血压
//@property (nonatomic) NSInteger bp;
//// 卡路里
//@property (nonatomic) NSInteger cal;
//@end

@interface BlueToothData : UIModelCoding
@property (nonatomic,strong) NSMutableArray *data;
@end

//
//  BlueToothModel2.h
//  OrangePatient
//
//  Created by singlew on 15/4/27.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "UIModelCoding.h"

@interface BlueToothModel2 : UIModelCoding
// 血氧数据
@property (nonatomic,strong) NSMutableArray *spo2Array;
// 卡路里数据
@property (nonatomic,strong) NSMutableArray *caloriesArray;
// 脉搏波数据
@property (nonatomic,strong) NSMutableArray *bpArray;
@end

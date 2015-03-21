//
//  BlueToothTimeData.h
//  OrangePatient
//
//  Created by singlew on 15/3/12.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIModelCoding.h"

@interface BlueToothTimeData : UIModelCoding
@property (nonatomic) NSInteger hours;
@property (nonatomic) NSInteger mins;
@property (nonatomic) NSInteger sec;
@end

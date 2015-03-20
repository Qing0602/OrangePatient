//
//  BlueToothDateData.h
//  OrangePatient
//
//  Created by singlew on 15/3/11.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIModelCoding.h"

@interface BlueToothDateData : UIModelCoding
@property (nonatomic) NSInteger years;
@property (nonatomic) NSInteger month;
@property (nonatomic) NSInteger days;
@end

//
//  BlueToothModel.h
//  OrangePatient
//
//  Created by singlew on 15/4/17.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "UIModelCoding.h"

@interface BlueToothModel : UIModelCoding
@property (nonatomic,strong) NSString *uuid;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *sn;
@property (nonatomic,strong) NSString *logoUrl;
@property (nonatomic,strong) NSString *text;
@property (nonatomic) BOOL isAdd;
-(BOOL) converJson : (NSDictionary *) json;
@end

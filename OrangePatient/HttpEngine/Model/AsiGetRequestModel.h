//
//  AsiGetRequestModel.h
//  teacher
//
//  Created by singlew on 14-3-7.
//  Copyright (c) 2014年 ws. All rights reserved.
//

#import "UIModelCoding.h"

@interface AsiGetRequestModel : UIModelCoding
@property NSUInteger offset;
@property NSUInteger limit;
@property (nonatomic,strong) id object;
@end

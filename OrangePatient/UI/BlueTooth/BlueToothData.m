//
//  BlueToothData.m
//  OrangePatient
//
//  Created by singlew on 15/3/12.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "BlueToothData.h"

@implementation BlueToothData
-(id) init{
    self = [super init];
    if (self != nil) {
        self.data = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.data forKey:@"data"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (nil != self) {
        self.data=[aDecoder decodeObjectForKey:@"data"];
    }
    return self;
}

@end

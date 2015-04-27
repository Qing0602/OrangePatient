//
//  BlueToothModel2.m
//  OrangePatient
//
//  Created by singlew on 15/4/27.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "BlueToothModel2.h"

@implementation BlueToothModel2
-(id) init{
    self = [super init];
    if (self != nil) {
        self.spo2Array = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.spo2Array forKey:@"spo2Array"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (nil != self) {
        self.spo2Array=[aDecoder decodeObjectForKey:@"spo2Array"];
    }
    return self;
}

@end

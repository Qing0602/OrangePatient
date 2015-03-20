//
//  BlueToothTimeData.m
//  OrangePatient
//
//  Created by singlew on 15/3/12.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "BlueToothTimeData.h"

@implementation BlueToothTimeData
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [super encodeWithCoder:aCoder];
    [aCoder encodeInteger:self.hours forKey:@"hours"];
    [aCoder encodeInteger:self.mins forKey:@"mins"];
    [aCoder encodeInteger:self.sec forKey:@"sec"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (nil != self) {
        self.hours=[aDecoder decodeIntegerForKey:@"hours"];
        self.mins=[aDecoder decodeIntegerForKey:@"mins"];
        self.sec=[aDecoder decodeIntegerForKey:@"sec"];
    }
    return self;
}
@end

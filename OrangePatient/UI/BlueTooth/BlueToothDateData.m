//
//  BlueToothDateData.m
//  OrangePatient
//
//  Created by singlew on 15/3/11.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "BlueToothDateData.h"

@implementation BlueToothDateData
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [super encodeWithCoder:aCoder];
    [aCoder encodeInteger:self.years forKey:@"years"];
    [aCoder encodeInteger:self.month forKey:@"month"];
    [aCoder encodeInteger:self.days forKey:@"days"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (nil != self) {
        self.years=[aDecoder decodeIntegerForKey:@"years"];
        self.month=[aDecoder decodeIntegerForKey:@"month"];
        self.days=[aDecoder decodeIntegerForKey:@"days"];
    }
    return self;
}
@end

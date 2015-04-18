//
//  BlueToothModel.m
//  OrangePatient
//
//  Created by singlew on 15/4/17.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "BlueToothModel.h"

/*
 @property (nonatomic,strong) NSString *uuid;
 @property (nonatomic,strong) NSString *name;
 @property (nonatomic,strong) NSString *sn;
 @property (nonatomic,strong) NSString *logoUrl;
 */

@implementation BlueToothModel
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.uuid forKey:@"uuid"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.sn forKey:@"sn"];
    [aCoder encodeObject:self.logoUrl forKey:@"logoUrl"];
    [aCoder encodeObject:self.text forKey:@"text"];
    [aCoder encodeBool:self.isAdd forKey:@"isAdd"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (nil != self) {
        self.uuid=[aDecoder decodeObjectForKey:@"uuid"];
        self.name=[aDecoder decodeObjectForKey:@"name"];
        self.sn=[aDecoder decodeObjectForKey:@"sn"];
        self.logoUrl=[aDecoder decodeObjectForKey:@"logoUrl"];
        self.text = [aDecoder decodeObjectForKey:@"text"];
        self.isAdd = [aDecoder decodeBoolForKey:@"isAdd"];
    }
    return self;
}


/*
 "data": [
 {
 "did": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
 "name": "血氧仪",
 "sn": "12345656565",
 "brand": {
 "id": 0,
 "name": "橙意",
 "logoUrl": "string"
 },
 "type": {
 "id": 0,
 "name": "康泰1代",
 "logoUrl": "string"
 },
 "register_time": 146578934,
 "state": {
 "id": 0,
 "name": "未激活"
 }
 }
 ],
 */
-(BOOL) converJson : (NSDictionary *) json{
    if (json == nil) {
        return NO;
    }
    if (json[@"did"] == nil || json[@"did"] == [NSNull null]) {
        return NO;
    }
    self.uuid = json[@"did"];
    
    if (json[@"name"] == nil || json[@"name"] == [NSNull null]) {
        return NO;
    }
    self.name = json[@"name"];
    
    if (json[@"sn"] == nil || json[@"sn"] == [NSNull null]) {
        return NO;
    }
    self.sn = json[@"sn"];
    
    if (json[@"type"][@"logoUrl"] == nil || json[@"type"][@"logoUrl"] == [NSNull null]) {
        return NO;
    }
    self.logoUrl = json[@"type"][@"logoUrl"];
    self.isAdd = YES;
    self.text = @"";
    return YES;
}
@end

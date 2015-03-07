//
//  PalmUIModelCoding.m
//  teacher
//
//  Created by singlew on 14-3-7.
//  Copyright (c) 2014年 ws. All rights reserved.
//

#import "UIModelCoding.h"
#import "UIManagement.h"

@implementation UIModelCoding
-(id) initWithCache:(BOOL)isCache{
    self = [super init];
    if (nil != self) {
        self.isCache = isCache;
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeBool:self.isCache forKey:@"isCache"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (nil != self) {
        self.isCache=[aDecoder decodeBoolForKey:@"isCache"];
    }
    return self;
}

-(BOOL) isEmptyOrNil:(id)obj{
    if (obj == nil || obj == [NSNull null]) {
        return YES;
    }
    return NO;
}


+(BOOL) serializeModel : (id) data withFileName:(NSString *)fileName{

//    int userID = [UIManagement sharedInstance].userAccount.UserID;
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    
//    if (![[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@%@",documentsDirectory,[NSString stringWithFormat:CachePath,userID]]]) {
//        NSString *myDirectory = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:CachePath,userID]];
//        NSError *error;
//        [[NSFileManager defaultManager] createDirectoryAtPath:myDirectory withIntermediateDirectories:NO attributes:nil error:&error];
//    }
//    
//    NSData *cacheData = [NSKeyedArchiver archivedDataWithRootObject:data];
//    NSString *filePath = [NSString stringWithFormat:@"%@%@%@",documentsDirectory,[NSString stringWithFormat:CachePath,userID],fileName];
//    return [cacheData writeToFile:filePath atomically:YES];
    return YES;
}

+(id) deserializeModel : (NSString *)fileName{
//    int userID = [[[NSUserDefaults standardUserDefaults] objectForKey:@"UserID"] integerValue];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSData *cacheData = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@%@%@",documentsDirectory,[NSString stringWithFormat:CachePath,userID],fileName]];
//	id data = [NSKeyedUnarchiver unarchiveObjectWithData:cacheData];
//    return data;
    return nil;
}

+(id) deserializeModelForResource : (NSString *)filePath{
    NSData *cacheData = [NSData dataWithContentsOfFile:filePath];
	id data = [NSKeyedUnarchiver unarchiveObjectWithData:cacheData];
    return data;
}

+(void) clearCache : (NSString *) fileName{
//    int userID = [NaNaUIManagement sharedInstance].userAccount.UserID;
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    if (![[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@%@",documentsDirectory,[NSString stringWithFormat:CachePath,userID]]]) {
//        NSString *myDirectory = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:CachePath,userID]];
//        [[NSFileManager defaultManager] createDirectoryAtPath:myDirectory withIntermediateDirectories:NO attributes:nil error:nil];
//        return;
//    }
//    if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@%@%@",documentsDirectory,[NSString stringWithFormat:CachePath,userID],fileName]]) {
//        [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@%@%@",documentsDirectory,[NSString stringWithFormat:CachePath,userID],fileName] error:nil];
//    }
}

+(NSString *) CachePathDir{
//    int userID = [NaNaUIManagement sharedInstance].userAccount.UserID;
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    if (![[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@%@",documentsDirectory,[NSString stringWithFormat:CachePath,userID]]]) {
//        NSString *myDirectory = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:CachePath,userID]];
//        [[NSFileManager defaultManager] createDirectoryAtPath:myDirectory withIntermediateDirectories:NO attributes:nil error:nil];
//    }
//    return [NSString stringWithFormat:@"%@%@",documentsDirectory,[NSString stringWithFormat:CachePath,userID]];
    return @"";
}

-(NSString *) calculateDate:(NSTimeInterval)time{
    NSTimeInterval currentTimeInterval = [[NSDate date] timeIntervalSince1970];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT+8"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    
    NSString *messageYMD = [dateFormatter stringFromDate:[[NSDate alloc] initWithTimeIntervalSince1970:time]];
    NSString *currentYMD = [dateFormatter stringFromDate:[NSDate date]];
    NSString *yestodayYMD = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:(currentTimeInterval - (24*60*60))]];
    
    if ([messageYMD isEqualToString:currentYMD]) {
        return @"今天";
    }else if ([messageYMD isEqualToString: yestodayYMD]) {
        return @"昨天";
    }else {
        return [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[[NSDate alloc] initWithTimeIntervalSince1970:time]]];
    }
}

-(NSString *) calculateTime:(NSTimeInterval)time{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT+8"]];
    [dateFormatter setDateFormat:@"HH:mm"];
    
    return [dateFormatter stringFromDate:[[NSDate alloc] initWithTimeIntervalSince1970:time]];
}

// 格式化当前时间为MM-DD
-(NSString *) formatNowToMMDD{
    NSTimeInterval currentTimeInterval = [[NSDate date] timeIntervalSince1970];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT+8"]];
    [dateFormatter setDateFormat:@"MM-dd"];
    
    return [dateFormatter stringFromDate:[[NSDate alloc] initWithTimeIntervalSince1970:currentTimeInterval]];
}

+(NSString *) formatStringToMMDDHHMM : (NSTimeInterval) time{
    static NSDateFormatter *dateFormatter = nil;
    if (nil == dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT+8"]];
        [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    }
    return [dateFormatter stringFromDate:[[NSDate alloc] initWithTimeIntervalSince1970:time]];
}

// 计算当前日期为星期几
-(NSString *) calculateWeekName{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;
    NSDate *now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
    NSString *result = @"";
    switch ([comps weekday]) {
        case 1:
            result = @"星期日";
            break;
        case 2:
            result = @"星期一";
            break;
        case 3:
            result = @"星期二";
            break;
        case 4:
            result = @"星期三";
            break;
        case 5:
            result = @"星期四";
            break;
        case 6:
            result = @"星期五";
            break;
        case 7:
            result = @"星期六";
            break;
        default:
            break;
    }
    return result;
}
@end

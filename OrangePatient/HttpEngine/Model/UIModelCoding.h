//
//  PalmUIModelCoding.h
//  teacher
//
//  Created by singlew on 14-3-7.
//  Copyright (c) 2014年 ws. All rights reserved.
//

typedef enum{
    MALE = 1,
    FEMALE = 2
}SEX;

#define CachePath @"/%@/"
#import <Foundation/Foundation.h>

@interface UIModelCoding : NSObject<NSCoding>
@property BOOL isCache;

-(id) initWithCache : (BOOL) isCache;
-(BOOL) isEmptyOrNil : (id) obj;
+(BOOL) serializeModel : (id) data withFileName : (NSString *)fileName;
+(id) deserializeModel : (NSString *)fileName;
+(id) deserializeModelForResource : (NSString *)filePath;
+(NSString *) CachePathDir;

// 其他通用方法
// 转换传入的时间是否为今天或昨天，如果不是今天或昨天则返回yyyy-mm-dd
-(NSString *) calculateDate : (NSTimeInterval) time;
// 转换转入的时间为HH:MM
-(NSString *) calculateTime : (NSTimeInterval) time;
// 格式化当前时间为MM-DD
-(NSString *) formatNowToMMDD;
// 计算当前日期为星期几
-(NSString *) calculateWeekName;
+(void) clearCache : (NSString *) fileName;
// 格式化时间为MM-DD HH:MM
+(NSString *) formatStringToMMDDHHMM : (NSTimeInterval) time;
@end

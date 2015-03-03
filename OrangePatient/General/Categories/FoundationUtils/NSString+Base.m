//
//

#import "NSString+Base.h"
#import <CommonCrypto/CommonDigest.h>
#import "RegexKitLite.h"
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@implementation NSString (md5)

-(NSString *)md5{
    
    if(self == nil || [self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}
@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@implementation NSString (uuid)

+(NSString *)uuid{
    
    CFUUIDRef	uuidObj = CFUUIDCreate(nil);
	NSString	*uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(nil, uuidObj);
	CFRelease(uuidObj);
	return uuidString;
}

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@implementation NSString (url)
- (NSString*) urlEncodedString {
    
    CFStringRef encodedCFString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                          (__bridge CFStringRef) self,
                                                                          nil,
                                                                          CFSTR("?!@#$^&%*+,:;='\"`<>()[]{}/\\| "),
                                                                          kCFStringEncodingUTF8);
    
    NSString *encodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString*) encodedCFString];
    
    if(!encodedString)
        encodedString = @"";
        
        return encodedString;
}

- (NSString*) urlDecodedString {
    
    CFStringRef decodedCFString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                          (__bridge CFStringRef) self,
                                                                                          CFSTR(""),
                                                                                          kCFStringEncodingUTF8);
    
    // We need to replace "+" with " " because the CF method above doesn't do it
    NSString *decodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString*) decodedCFString];
    return (!decodedString) ? @"" : [decodedString stringByReplacingOccurrencesOfString:@"+" withString:@" "];
}
@end
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
@implementation NSString (length)

//return Yes = null
+(BOOL)isNull : (NSString *)targetStr
{
    if (!targetStr || [@"" isEqualToString:targetStr] || [targetStr isEqual:[NSNull null]])
    {
        return YES;
    }
    return NO;
}
//return Yes 不小于某个数
-(BOOL)isLongerThanLength:(NSUInteger )strLength
{
    if ([NSString isNull :self]) return NO;
    
    if (self.length >= strLength) {
        return YES;
    }
    return NO;
}
//return YES 不大于某个数
-(BOOL)isLessForLength:(NSUInteger)strLength
{
    if ([NSString isNull : self]) return NO;
    
    if (self.length <= strLength) {
        return YES;
    }
    return NO;
}
//return YES 在一个区域之间
-(BOOL)isMidForLength:(NSUInteger)strLengthOne : (NSUInteger)strLengthTwo
{
    if (strLengthOne < strLengthTwo) {
        if ([self isLongerThanLength:strLengthOne] && [self isLessForLength:strLengthTwo]) return YES;
    }else if (strLengthOne > strLengthTwo){
        if ([self isLongerThanLength:strLengthTwo] && [self isLessForLength:strLengthOne]) return YES;
    }
    return NO;
}


@end


@implementation NSString (type)
+(BOOL)isTelNumber:(NSString *)telStr{
    NSString * regex_string = @"^[0-9]{11}$";
    BOOL result_bool = [telStr isMatchedByRegex:regex_string];
    return result_bool;
}

+ (BOOL)validateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest  evaluateWithObject:email];
}
+(BOOL)isNumber:(NSString *)string {
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    int val;
    
    return [scan scanInt:&val] && [scan isAtEnd];
    
}
@end
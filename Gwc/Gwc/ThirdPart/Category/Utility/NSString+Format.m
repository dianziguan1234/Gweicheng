//
//  NSString+Format.m
//  NBCategory
//
//  Created by 刘彬 on 16/3/19.
//  Copyright © 2016年 NewBee. All rights reserved.
//

#import "NSString+Format.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Format)

- (NSString *)nb_trimWhitespace {
    if(nil == self){
        return nil;
    }
    NSMutableString *str = [NSMutableString stringWithString:self];
    CFStringTrimWhitespace((CFMutableStringRef)str);
    return str;
}

- (NSString *)nb_trimAllWhitespace {
    if(nil == self){
        return nil;
    }
    NSString *copy = [self copy];
    
    NSMutableString *str = [NSMutableString string];
    for (NSUInteger index = 0; index < [copy length]; index++) {
        unichar c = [copy characterAtIndex:index];
        if (c != ' ' && c != '\t' && c != '\r' && c != '\n') {
            [str appendFormat:@"%C",c];
        }
    }
    return str;
}

- (NSString *)nb_md5 {
    const char *concat_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(concat_str, (CC_LONG)strlen(concat_str), result);
    NSMutableString *hash = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    return [hash lowercaseString];
}

+ (NSString *)nb_UDID {
    CFUUIDRef udid = CFUUIDCreate(nil);
    NSString *strUDID = (__bridge_transfer NSString *)CFUUIDCreateString(nil, udid);
    CFRelease(udid);
    return strUDID;
}

- (NSString *)nb_urlEncode {
    NSString *resultString = self;
    NSString *temString = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                    kCFAllocatorDefault, (CFStringRef)self, NULL, (CFStringRef) @"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
    if ([temString length])
    {
        resultString = [NSString stringWithString:temString];
    }
    
    return temString;
}

- (NSString *)nb_urlDecode
{
    NSString *resultString = self;
    NSString *temString = CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(
                                                                                                    kCFAllocatorDefault, (CFStringRef)self, CFSTR(""), kCFStringEncodingUTF8));
    
    if ([temString length])
    {
        resultString = [NSString stringWithString:temString];
    }
    
    return temString;
}

- (NSString *)nb_mobile344Format {
    return [self nb_mobile344FormatSeparatedByCharacter:' '];
}

- (NSString *)nb_mobile344FormatSeparatedByCharacter:(unichar)character {
    unichar sep = character;
    if (sep == 0) {
        sep = ' ';
    }
    NSUInteger len = [self length];
    
    @autoreleasepool {
        NSMutableString *format = [NSMutableString string];
        NSUInteger mask = 0;
        for (NSUInteger idx = 0; idx < len; idx++) {
            unichar c = [self characterAtIndex:idx];
            if (c < '0' || c > '9') {
                continue ;
            }
            
            mask++;
            [format appendFormat:@"%C",c];
            
            if (mask % 4 == 3 && idx + 1 < len) {//非最后一个时
                [format appendFormat:@"%C",sep];
            }
        }
        
        return format;
    }
}

- (NSString *)nb_substringMeetCharacterSet:(NSCharacterSet *)set {
    if (!set) {
        return [self copy];
    }
    @autoreleasepool {
        NSMutableString *sub = [NSMutableString string];
        NSString *text = [self copy];
        for (NSUInteger index = 0; index < [text length];index++) {
            unichar c = [text characterAtIndex:index];
            if ([set characterIsMember:c]) {
                [sub appendFormat:@"%C",c];
            }
        }
        return [sub copy];
    }
}

- (NSArray *)nb_getMatchesForRegex:(NSString *)regex {
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:1];
    
    NSError * error;
    NSRegularExpression * expression = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray * matches                = [expression matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    for (NSUInteger i = 0; i < matches.count; i++) {
        NSTextCheckingResult * result = [matches objectAtIndex:i];
        
        for (NSUInteger j = 0; j < result.numberOfRanges; j++) {
            NSRange range = [result rangeAtIndex:j];
            if (range.location == NSNotFound) {
                continue;
            }
            NSString * string = [self substringWithRange:range];
            [array addObject:string];
        }
    }
    
    return array;
}

- (NSString *)nb_stringByReplaceRegex:(NSString *)regex withString:(NSString *)replace{
    NSError * error;
    NSRegularExpression * expression = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSString * string                = [expression stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, self.length) withTemplate:replace];
    
    return  string;
}

- (NSString *)nb_amountFormat {
    if ([NSString nb_isEmpty:self]) {
        return self;
    }
    return [NSString stringWithFormat:@"¥%@",self];
}

- (NSString *)nb_getURLPath {
    NSRange range1  = [self rangeOfString:@"?"];
    NSRange range2  = [self rangeOfString:@"#"];
    NSRange range   ;
    if (range1.location != NSNotFound) {
        range = NSMakeRange(range1.location, range1.length);
    }else if (range2.location != NSNotFound){
        range = NSMakeRange(range2.location, range2.length);
    }else{
        range = NSMakeRange(-1, 0);
    }
    
    if (range.location < self.length) {
        return [self substringToIndex:range.location];
    } else {
        return self;
    }
}

- (NSDictionary *)nb_getURLParams{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    NSRange range1  = [self rangeOfString:@"?"];
    NSRange range2  = [self rangeOfString:@"#!"];
    NSRange range3  = [self rangeOfString:@"#"];
    NSRange range   ;
    if (range1.location != NSNotFound) {
        range = NSMakeRange(range1.location, range1.length);
    } else if (range2.location != NSNotFound){
        range = NSMakeRange(range2.location, range2.length);
    } else if (range3.location != NSNotFound){
        range = NSMakeRange(range3.location, range3.length);
    }else{
        range = NSMakeRange(-1, 1);
    }
    
    if (range.location != NSNotFound && range.location+ range.length < self.length) {
        NSString * paramString = [self substringFromIndex:range.location+ range.length];
        NSArray * paramCouples = [paramString componentsSeparatedByString:@"&"];
        for (NSUInteger i = 0; i < [paramCouples count]; i++) {
            NSArray * param = [[paramCouples objectAtIndex:i] componentsSeparatedByString:@"="];
            if ([param count] == 2) {
                
                [dic setValue:[[param objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:[[param objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            }
        }
        return dic;
    }
    return nil;
}

+ (NSString *)nb_stringByAddingURLParams:(NSDictionary *)params {
    if (params.allKeys.count > 0)
    {
        @try {
            NSMutableString *str = [[NSMutableString alloc] init];
            for (NSString *key in params.allKeys)
            {
                if (![NSString nb_isEmpty:str]) {
                    [str appendString:@"&"];
                }
                [str appendString:key];
                [str appendString:@"="];
                NSObject *obj = params[key];
                NSString *value = [obj isKindOfClass:[NSNumber class]] ? [(NSNumber *)obj stringValue] : (NSString *)obj;
                [str appendString:value];
            }
            return str;
        }
        @catch (NSException *exception){
            return @"";
        }
    }
    return @"";
}

+ (NSString *)nb_stringWithDate:(NSDate *)date formatter:(NSString *)dateFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if ([dateFormat length]) {
        formatter.dateFormat = dateFormat;
    }
    return [formatter stringFromDate:date];
}

+ (NSString *)nb_stringWithTimeIntervals:(long long)time formatter:(NSString *)dateFormat {
    NSString *timeString = [NSString stringWithFormat:@"%lld",time];
    if (timeString.length == 10){
        timeString = [NSString stringWithFormat:@"%@000",timeString];
    }
    long long secFrom1970 = [timeString longLongValue]/1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:secFrom1970];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)nb_componentsStringWithArray:(NSArray *)array
                           appendingString:(NSString *)append
                              joinedString:(NSString *)joined{
    @autoreleasepool
    {
        NSMutableArray *temAry = [NSMutableArray arrayWithCapacity:1];
        for (NSString *str in array)
        {
            NSString *s = [str stringByAppendingString:append];
            [temAry addObject:s];
        }
        return [temAry componentsJoinedByString:joined];
    }
}

@end

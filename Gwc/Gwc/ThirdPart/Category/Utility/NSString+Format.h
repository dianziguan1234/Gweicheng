//
//  NSString+Format.h
//  NBCategory
//
//  Created by 刘彬 on 16/3/19.
//  Copyright © 2016年 NewBee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Format)

- (NSString *)nb_trimWhitespace;
- (NSString *)nb_trimAllWhitespace;
- (NSString *)nb_md5;
+ (NSString *)nb_UDID;
- (NSString *)nb_urlEncode;
- (NSString *)nb_urlDecode;
- (NSString *)nb_mobile344Format;
- (NSString *)nb_mobile344FormatSeparatedByCharacter:(unichar)character;
- (NSString *)nb_substringMeetCharacterSet:(NSCharacterSet *)set;
- (NSArray  *)nb_getMatchesForRegex:(NSString *)regex;
- (NSString *)nb_stringByReplaceRegex:(NSString *)regex withString:(NSString *)replace;
- (NSString *)nb_amountFormat;
- (NSString *)nb_getURLPath;
- (NSDictionary *)nb_getURLParams;
+ (NSString *)nb_stringByAddingURLParams:(NSDictionary *)params;
+ (NSString *)nb_stringWithDate:(NSDate *)date formatter:(NSString *)dateFormat;
+ (NSString *)nb_stringWithTimeIntervals:(long long)time formatter:(NSString *)dateFormat;
+ (NSString *)nb_componentsStringWithArray:(NSArray *)array
                           appendingString:(NSString *)append
                              joinedString:(NSString *)joined;

@end

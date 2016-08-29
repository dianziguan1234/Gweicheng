//
//  NSString+HXAddtions.h
//  DayangHealth
//
//  Created by apple on 16/4/25.
//  Copyright © 2016年 com.dayangdata.gwc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HXAddtions)

+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dictionary;

+ (NSString *)jsonStringWithArray:(NSArray *)array;

+ (NSString *)jsonStringWithString:(NSString *)string;

+ (NSString *)jsonStringWithObject:(id)object;
/**
 *  根据宽度就算高度
 *
 *  @param width width description
 *  @param font  font description
 *
 *  @return return value description
 */
-(CGFloat)heightWithWidth:(CGFloat)width font:(CGFloat)font;

//通过时间戳计算时间差（几小时前、几天前）
+ (NSString *) compareCurrentTime:(NSTimeInterval) compareDate;

//通过时间戳得出显示时间
+ (NSString *) getDateStringWithTimestamp:(NSTimeInterval)timestamp;

//通过时间戳和格式显示时间
+ (NSString *) getStringWithTimestamp:(NSTimeInterval)timestamp formatter:(NSString*)formatter;
@end

//
//  LMUtility.m
//  LawMonkey
//
//  Created by 刘彬 on 16/5/7.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "LMUtility.h"

@implementation LMUtility

/*!
 *  @brief  根据格式将时间戳转换成字符串
 *
 *  @param iTimestamp 接口返回的时间戳字符串 /Date(1365661065760)/
 *  @param iFormatStr 时间格式
 *
 *  @return 字符串形式的时间
 */
+ (NSString *)timestampToDateString:(NSString*)iTimestamp formatterString:(NSString*)iFormatStr{
    if([NSString nb_isEmpty:iTimestamp]){
        return @"";
    }
    //截取时间戳
    NSRange range = NSMakeRange(6, [iTimestamp length] - 8);
    iTimestamp = [iTimestamp substringWithRange:range];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[iTimestamp doubleValue]/1000];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:iFormatStr];
    return [formatter stringFromDate:date];
}

/*!
 *  @brief  返回时间戳
 *
 *  @param iTimestamp 接口返回的时间戳字符串 /Date(1365661065760)/
 *
 *  @return return value description
 */
+ (NSTimeInterval)getTimestampWithCSharpFormat:(NSString *)iTimestamp {
    if([NSString nb_isEmpty:iTimestamp]){
        return 0;
    }
    NSRange range = NSMakeRange(6, [iTimestamp length] - 8);
    iTimestamp = [iTimestamp substringWithRange:range];
    return [iTimestamp longLongValue]/1000;
}

/*!
 *  @brief  返回日期
 *
 *  @param iTimestamp 接口返回的时间戳字符串 /Date(1365661065760)/
 *
 *  @return return value description
 */
+ (NSDate *)getDateWithCSharpFormat:(NSString *)iTimestamp {
    if([NSString nb_isEmpty:iTimestamp]){
        return nil;
    }
    NSRange range = NSMakeRange(6, [iTimestamp length] - 8);
    iTimestamp = [iTimestamp substringWithRange:range];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[iTimestamp longLongValue]/1000];
    return date;
}

/**
 *  将0时区的时间转成0时区的时间戳
 */
+ (NSString *)transformToTimestampWithDate:(NSDate *)date {
    NSTimeInterval inter = [date timeIntervalSince1970];
    return [NSString stringWithFormat:@"%ld", (long)inter];
}

/**
 *  将0时区的时间戳转成0时区的时间
 */
+ (NSDate *)transformToDateWithTimestamp:(NSString *)timestamp {
    NSTimeInterval inter = [timestamp doubleValue];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:inter];
    return date;
}

@end

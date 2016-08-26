//
//  LMUtility.h
//  LawMonkey
//
//  Created by 刘彬 on 16/5/7.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMUtility : NSObject

/*!
 *  @brief  根据格式将时间戳转换成字符串
 *
 *  @param iTimestamp 接口返回的时间戳字符串 /Date(1365661065760)/
 *  @param iFormatStr 时间格式
 *
 *  @return 字符串形式的时间
 */
+ (NSString *)timestampToDateString:(NSString*)iTimestamp formatterString:(NSString*)iFormatStr;

/*!
 *  @brief  返回时间戳
 *
 *  @param iTimestamp 接口返回的时间戳字符串 /Date(1365661065760)/
 *
 *  @return 时间戳格式的时间
 */
+ (NSTimeInterval)getTimestampWithCSharpFormat:(NSString *)iTimestamp;

/*!
 *  @brief  返回日期
 *
 *  @param iTimestamp 接口返回的时间戳字符串 /Date(1365661065760)/
 *
 *  @return 日期格式的时间
 */
+ (NSDate *)getDateWithCSharpFormat:(NSString *)iTimestamp;

@end

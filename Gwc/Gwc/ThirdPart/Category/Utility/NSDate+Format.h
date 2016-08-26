//
//  NSDate+Format.h
//  NBCategory
//
//  Created by 刘彬 on 16/3/19.
//  Copyright © 2016年 NewBee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Format)

@property (nonatomic, assign, readonly) NSInteger nb_year;
@property (nonatomic, assign, readonly) NSInteger nb_month;
@property (nonatomic, assign, readonly) NSInteger nb_day;
@property (nonatomic, assign, readonly) NSInteger nb_hour;
@property (nonatomic, assign, readonly) NSInteger nb_minute;
@property (nonatomic, assign, readonly) NSInteger nb_second;

+ (NSDate *)nb_dateWithString:(NSString *)timeStr format:(NSString *)format;
+ (NSString *)nb_currentTimeWithFormat:(NSString *)format;
+ (NSString *)nb_currentTimeInterval;


- (NSDate *)nb_dateByAppendingYears:(NSInteger)years;
- (NSDate *)nb_dateByAppendingMonths:(NSInteger)months;
- (NSDate *)nb_dateByAppendingDays:(NSInteger)days;
- (NSDate *)nb_dateByAppendingHours:(NSInteger)hours;
- (NSDate *)nb_dateByAppendingMinutes:(NSInteger)minutes;
- (NSDate *)nb_dateByAppendingSeconds:(NSInteger)seconds;

- (NSString *)nb_briefString;
+ (NSString *)nb_briefStringWithTimeInterval:(long long)time;

+ (void)nb_getUnitTimeBySeconds:(long long)seconds
                            day:(long long *)day
                           hour:(long long *)hour
                         minute:(long long *)minute
                         second:(long long *)second;

/**
 * @method
 *
 * @brief 获取两个日期之间的天数
 * @param fromDate       起始日期
 * @param toDate         终止日期
 * @return    总天数
 */
+ (NSInteger)nb_numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;
@end

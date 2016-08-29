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
 *  @param width <#width description#>
 *  @param font  <#font description#>
 *
 *  @return <#return value description#>
 */
-(CGFloat)heightWithWidth:(CGFloat)width font:(CGFloat)font;
@end

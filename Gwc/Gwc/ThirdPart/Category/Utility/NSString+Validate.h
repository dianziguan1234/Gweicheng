//
//  NSString+Validate.h
//  NBCategory
//
//  Created by 刘彬 on 16/3/19.
//  Copyright © 2016年 NewBee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Validate)

+ (BOOL)nb_isEmpty:(NSString *)string;
- (BOOL)nb_isEqualsIgnoreCase:(NSString *)str;
- (BOOL)nb_isContainsString:(NSString *)str;
- (BOOL)nb_isNumberString;
- (BOOL)nb_isLetters;
- (BOOL)nb_isValidInteger;
- (BOOL)nb_isValidFloat;
- (BOOL)nb_isContainsEmoji;
- (BOOL)nb_isContainsChinese;
- (BOOL)nb_isValidMobileNumber;
- (BOOL)nb_isValidEmail;
- (BOOL)nb_isValidIDCardNumber;
- (BOOL)nb_isReallyIDCardNumber;
- (NSComparisonResult)nb_compareAppVersion:(NSString *)version;
@end

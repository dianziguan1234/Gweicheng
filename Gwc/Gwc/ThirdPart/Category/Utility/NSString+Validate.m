//
//  NSString+Validate.m
//  NBCategory
//
//  Created by 刘彬 on 16/3/19.
//  Copyright © 2016年 NewBee. All rights reserved.
//

#import "NSString+Validate.h"
#import "NSString+Format.h"
#import "NSDate+Format.h"

@implementation NSString (Validate)

+ (BOOL)nb_isEmpty:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
        
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    return NO;
}

- (BOOL)nb_isEqualsIgnoreCase:(NSString *)str {
    if (nil == str) {
        return NO;
    }
    
    return [self compare:str options:NSCaseInsensitiveSearch] == NSOrderedSame;
}

- (BOOL)nb_isContainsString:(NSString *)str {
    if (nil == str || [str length] == 0) {
        return NO;
    }
    return [self rangeOfString:str].length > 0;
}

- (BOOL)nb_isNumberString{
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSString *resultString = [self stringByTrimmingCharactersInSet:set];
    if ([resultString length] == 0) {
        return YES;
    }else {
        return NO;
    }
}

- (BOOL)nb_isLetters {
    NSString *regPattern = @"[a-zA-Z]+";
    NSPredicate *testResult = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regPattern];
    return [testResult evaluateWithObject:self];
}

- (BOOL)nb_isValidInteger {
    if ([NSString nb_isEmpty:self]) {
        return NO;
    }
    NSScanner* scan = [NSScanner scannerWithString:self];
    NSInteger val;
    return [scan scanInteger:&val] && [scan isAtEnd];
}

-(BOOL)nb_isValidFloat{
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

- (BOOL)nb_isContainsEmoji {
    if ([NSString nb_isEmpty:self]) {
        return NO;
    }
    __block BOOL isEomji = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     isEomji = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 isEomji = YES;
             }
         } else {
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 isEomji = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 isEomji = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 isEomji = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 isEomji = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                 isEomji = YES;
             }
         }
     }];
    return isEomji;
}

- (BOOL)nb_isContainsChinese {
    if ([self length] == 0) {
        return NO;
    }
    NSString *match=@"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

- (BOOL)nb_isValidMobileNumber {
    NSString *txt = [self nb_trimWhitespace];
    if ([txt length] != 11) {
        return NO;
    }
    NSString *pattern = @"^1[0-9]{10}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [regextestmobile evaluateWithObject:txt];
}

- (BOOL)nb_isValidEmail {
    NSString *txt = [self nb_trimWhitespace];
    if ([NSString nb_isEmpty:self]) {
        return NO;
    }
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]+";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:txt];
}


- (BOOL)nb_isValidIDCardNumber {
    NSString *txt = [self nb_trimWhitespace];
    if ([NSString nb_isEmpty:txt]) {
        return NO;
    }
    NSString *regex = @"^(\\d{17}x|\\d{18})$";
    return [[self nb_getMatchesForRegex:regex] count] != 0;
}

- (BOOL)nb_isReallyIDCardNumber{
    if (![self nb_isValidIDCardNumber]) {
        return NO;
    }
    
    //出生年(7-10位)
    NSString *year  = [self substringWithRange:NSMakeRange(6, 4)];
    //出生月（11-12位）
    NSString *month = [self substringWithRange:NSMakeRange(10, 2)];
    //出生日（13-14位）
    NSString *day = [self substringWithRange:NSMakeRange(12, 2)];
    //三位数字顺序码（15-17位，同一地区同年、同月、同日出生人的编号，奇数是男性，偶数是女性）
//    NSString *orderCode = [self substringWithRange:NSMakeRange(14, 3)];
    
    //一位数字校验码（18位，如果是0-9则用0-9表示，如果是10则用X（罗马数字10）表示）
    //    NSString *verifyCode = [self substringWithRange:NSMakeRange(17, 1)];
    
    NSMutableString *dateString = [NSMutableString string];
    [dateString appendFormat:@"%@-",year];
    [dateString appendFormat:@"%@-",month];
    [dateString appendFormat:@"%@",day];
    [dateString appendString:@" 00:00:01"];
    //验证日期
    NSDate *date = [NSDate nb_dateWithString:dateString format:@"yyyy-MM-dd HH:mm:ss"];
    if (date.nb_year != [year integerValue] || date.nb_month != [month integerValue] || date.nb_day != [day integerValue]) {
        return NO;
    }
    
    //加权因子
    NSArray *weightArr = @[@7, @9, @10, @5, @8, @4, @2, @1, @6, @3, @7, @9, @10, @5, @8, @4, @2, @1];
    //校验位。10代表x
    NSArray *verifyArr = @[@1, @0, @10, @9, @8, @7, @6, @5, @4, @3, @2];
    
    unichar cardNumArr[20];
    memset(cardNumArr, 0, sizeof(cardNumArr));
    [self getCharacters:cardNumArr];
    
    //验证校验位
    
    //声明加权求和变量
    NSInteger sum = 0;
    //将最后位为x的验证码替换为10方便后续操作
    if (cardNumArr[self.length-1] == 'X' || cardNumArr[self.length-1] == 'x') {
        cardNumArr[self.length-1] = (10 + '0');
    }
    //加权求和
    for (int i = 0; i < (self.length - 1); i++) {
        sum += (cardNumArr[i] - '0') * [[weightArr objectAtIndex:i] integerValue];
    }
    //计算校验码索引
    NSInteger verifyIndex = sum % 11;
    //验证校验码
    if ((cardNumArr[self.length-1] - '0') != [[verifyArr objectAtIndex:verifyIndex] integerValue]) {
        return NO;
    }
    return YES;
}


//比较应用程序版本大小如：1.0.0 和 1.2.0
- (NSComparisonResult)nb_compareAppVersion:(NSString *)version {
    NSArray *selfComps = [self componentsSeparatedByString:@"."];
    NSArray *targComps = [version componentsSeparatedByString:@"."];
    
    NSUInteger self_count = [selfComps count];
    NSUInteger targ_count = [targComps count];
    
    if (self_count > 0 && targ_count > 0) {
        __block NSComparisonResult rt = NSOrderedSame;
        [selfComps enumerateObjectsUsingBlock:^(NSString *v, NSUInteger idx, BOOL *stop) {
            if (idx >= targ_count) {
                rt = NSOrderedDescending;
                *stop = YES;
                return ;
            }
            
            NSString *tv = [targComps objectAtIndex:idx];
            
            rt = [v compare:tv];
            if (rt != NSOrderedSame) {
                *stop = YES;
                return ;
            }
        }];
        
        return rt;
    }
    else if (self_count > 0) {
        return NSOrderedDescending;
    }
    else if (targ_count > 0) {
        return NSOrderedAscending;
    }
    
    return NSOrderedSame;
}

@end

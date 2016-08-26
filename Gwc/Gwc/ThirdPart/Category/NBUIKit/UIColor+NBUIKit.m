//
//  UIColor+NBUIKit.m
//  NBCategory
//
//  Created by 刘彬 on 16/3/15.
//  Copyright © 2016年 NewBee. All rights reserved.
//

#import "UIColor+NBUIKit.h"

@implementation UIColor (NBUIKit)

/*!
 *  @brief  十六进制颜色->UIColor
 *
 *  @param value 十六进制数
 *
 *  @return 对应的颜色
 */
+ (UIColor *)nb_colorWithHex:(NSUInteger)value {
    return [self nb_colorWithHex:value alpha:1.0];
}

/*!
 *  @brief  十六进制颜色->UIColor
 *
 *  @param value 十六进制数
 *  @param alpha 透明度 0~1.0f
 *
 *  @return 对应的颜色
 */
+ (UIColor *)nb_colorWithHex:(NSUInteger)value alpha:(CGFloat)alpha {
    CGFloat r = ((value & 0x00FF0000) >> 16) / 255.0f;
    CGFloat g = ((value & 0x0000FF00) >> 8) / 255.0f;
    CGFloat b = (value & 0x000000FF) / 255.0f;
    return [self colorWithRed:r green:g blue:b alpha:alpha];
}

@end

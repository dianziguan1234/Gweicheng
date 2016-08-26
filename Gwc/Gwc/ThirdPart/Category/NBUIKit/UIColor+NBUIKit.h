//
//  UIColor+NBUIKit.h
//  NBCategory
//
//  Created by 刘彬 on 16/3/15.
//  Copyright © 2016年 NewBee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (NBUIKit)

/*!
 *  @brief  十六进制颜色->UIColor
 *
 *  @param value 十六进制数
 *
 *  @return 对应的颜色
 */
+ (UIColor *)nb_colorWithHex:(NSUInteger)value;

/*!
 *  @brief  十六进制颜色->UIColor
 *
 *  @param value 十六进制数
 *  @param alpha 透明度 0~1.0f
 *
 *  @return 对应的颜色
 */
+ (UIColor *)nb_colorWithHex:(NSUInteger)value alpha:(CGFloat)alpha;

@end

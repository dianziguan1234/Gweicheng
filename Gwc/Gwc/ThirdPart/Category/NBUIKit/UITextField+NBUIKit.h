//
//  UITextField+NBUIKit.h
//  LawMonkey
//
//  Created by 刘彬 on 16/3/20.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (NBUIKit)

/**
 *  输入框定义
 *
 *  @param size       尺寸，默认CGSize(180,40)
 *  @param font       字体大小，默认值为14
 *  @param color      字体颜色，默认值为黑色
 *  @param placeholder 提示字符
 *  @param adjustFont 默认值NO
 *  @param minFont    默认值11
 *
 *  @return textField
 */
+ (instancetype)nb_inputWithSize:(CGSize)size
                            font:(UIFont *)font
                           color:(UIColor *)color
                     placeholder:(NSString *)placeholder
                      adjustFont:(BOOL)adjustFont
                         minFont:(CGFloat)minFont;

/**
 *  输入框定义
 *
 *  @param size       尺寸，默认CGSize(180,40)
 *  @param font       字体大小，默认值为14
 *  @param color      字体颜色，默认值为黑色
 *  @param placeholder 提示字符
 *  @param adjustFont 默认值NO
 *  @param minFont    默认值11
 *  @param maxLength  最大长度
 *  @param characterLimit  字符限制
 *
 *  @return textField
 */
+ (instancetype)nb_inputWithSize:(CGSize)size
                            font:(UIFont *)font
                           color:(UIColor *)color
                     placeholder:(NSString *)placeholder
                      adjustFont:(BOOL)adjustFont
                         minFont:(CGFloat)minFont
                       maxLength:(NSUInteger)maxLength
                  characterLimit:(NSCharacterSet *)characterLimit;




/*!
 *  @brief  清除View
 */
- (void)clearLeftView;
- (void)clearRightView;


/*!
 *  @brief  左右View范围
 */
@property (nonatomic, assign) CGFloat leftWidth;
@property (nonatomic, assign) CGFloat rightWidth;

/*!
 *  @brief  设置左边View (添加前一定要设置范围)
 *
 *  @param imageName 按钮图片
 *  @param text      按钮文字
 *  @param color     按钮文字颜色
 */
- (void)setLeftWithImageName:(NSString *)imageName imageOffx:(CGFloat)offX;
- (void)setLeftWithText:(NSString *)text textColor:(UIColor *)color textFont:(UIFont*)font textOffx:(CGFloat)offX;

/*!
 *  @brief  设置右边View (添加前一定要设置范围)
 *
 *  @param imageName 按钮图片
 *  @param text      按钮文字
 *  @param color     按钮文字颜色
 */
- (void)setRightWithImageName:(NSString *)imageName imageOffx:(CGFloat)offX;
- (void)setRightWithText:(NSString *)text textColor:(UIColor *)color textFont:(UIFont*)font textOffx:(CGFloat)offX;

/**
 *  输入的最大宽度
 */
@property (nonatomic, assign) NSUInteger nb_maxLength;

/**
 *  字符限定
 */
@property (nonatomic, copy) NSCharacterSet *nb_characterLimit;

/**
 *  输入格式限定，如344，335
 */
@property (nonatomic, copy) NSString *(^nb_format)(NSString *originText);

@end

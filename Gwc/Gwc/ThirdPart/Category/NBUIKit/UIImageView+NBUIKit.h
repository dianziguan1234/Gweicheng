//
//  UIImageView+NBUIKit.h
//  NBCategory
//
//  Created by 刘彬 on 16/3/15.
//  Copyright © 2016年 NewBee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (NBUIKit)

/**
 *  一个高宽都为width的imageView
 *
 *  @param width 边框，默认值40
 *
 *  @return imageView
 */
+ (instancetype)nb_imageViewWithWidth:(CGFloat)width;

/**
 *  一个图片
 *
 *  @param size 高宽，默认值CGSize(40,40)
 *
 *  @return imageView
 */
+ (instancetype)nb_imageViewWithSize:(CGSize)size;

/**
 *  一个图片
 *
 *  @param image 设置的image，大小取image大小
 *
 *  @return imageView
 */
+ (instancetype)nb_imageViewWithImage:(UIImage *)image;

/**
 *  一个一像素高度的线，内部根据当前分辨率扩充其透明线
 *
 *  @param width        边框，默认值40
 *  @param color        线的颜色，不能为空
 *  @param orientation  线的方向
 *
 *  @return 一个线的view
 */
+ (instancetype)nb_lineWithWidth:(CGFloat)width color:(UIColor *)color orientation:(UIInterfaceOrientation)orientation;

/*!
 *  @brief  圆形图像的头像
 *
 *  @param width        头像宽
 *  @param borderWidth  边线
 *  @param borderColor  边线色
 *  @param defaultImage 默认图
 *
 *  @return 头像imageview
 */
+ (instancetype)nb_avatarWithWidth:(CGFloat)width borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor defaultImage:(UIImage *)defaultImage;

/*!
 *  @brief  设置图片
 *
 *  @param url 图片链接
 */
- (void)nb_setURL:(NSString *)url;

/*!
 *  @brief 设置图片
 *
 *  @param url   图片链接
 *  @param image 占位图片
 */
- (void)nb_setURL:(NSString *)url placeholderImage:(UIImage *)image;

@end

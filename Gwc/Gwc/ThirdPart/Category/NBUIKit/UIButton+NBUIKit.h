//
//  UIButton+NBUIKit.h
//  NBCategory
//
//  Created by 刘彬 on 16/3/15.
//  Copyright © 2016年 NewBee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (NBUIKit)

/**
 *  生产一个固定大小的button，可配置的主题
 *
 *  @param size              大小，默认值CGSize(60,40)
 *  @param font              字体大小，默认值为14
 *  @param color             字体颜色，默认值为黑色
 *  @param selectedColor     字体选中颜色（兼高亮），默认nil
 *  @param disabledColor     不可用颜色，默认nil
 *  @param backgroud         背景图，默认纯白
 *  @param selectedBackgroud 选中背景图，默认nil
 *  @param disabledBackgroud 不可用背景图，默认nil
 *
 *  @return button
 */
+ (instancetype)nb_buttonWithSize:(CGSize)size
                              font:(UIFont *)font
                             color:(UIColor *)color
                          selected:(UIColor *)selectedColor
                          disabled:(UIColor *)disabledColor
                         backgroud:(UIImage *)backgroud
                          selected:(UIImage *)selectedBackgroud
                          disabled:(UIImage *)disabledBackgroud;

/**
 *  生产一个可变大小的button，可配置的主题
 *
 *  @param min               最小宽度，默认值为0，若min大于max将被忽略
 *  @param max               最大宽度，默认值为300
 *  @param edge              边距宽度，默认值为10
 *  @param height            高度，默认值40
 *  @param font              字体大小，默认值为14
 *  @param color             字体颜色，默认值为黑色
 *  @param selectedColor     字体选中颜色（兼高亮），默认nil
 *  @param disabledColor     不可用颜色，默认nil
 *  @param backgroud         背景图，默认纯白
 *  @param selectedBackgroud 选中背景图，默认nil
 *  @param disabledBackgroud 不可用背景图，默认nil
 *
 *  @return button
 */
+ (instancetype)nb_buttonWithWidthMin:(CGFloat)min
                                   max:(CGFloat)max
                                  edge:(CGFloat)edge
                                height:(CGFloat)height
                                  font:(UIFont *)font
                                 color:(UIColor *)color
                              selected:(UIColor *)selectedColor
                              disabled:(UIColor *)disabledColor
                             backgroud:(UIImage *)backgroud
                              selected:(UIImage *)selectedBackgroud
                              disabled:(UIImage *)disabledBackgroud;


/**
 *  重新改变尺寸
 */
- (void)nb_sizeToFit;

/**
 *  添加点击事件
 */
- (void)nb_addTarget:(id)target touchAction:(SEL)selector;

/**
 *  扩大按钮的点击范围（outsets表示自己frame向外延生部分，superview要足够大）
 */
@property (nonatomic, assign) UIEdgeInsets          nb_hitEdgeOutsets;

/**
 *  normal下的title,titleColor，image，backgroud image
 */
@property (nonatomic, copy  ) NSString              *nb_normalTitle;

@property (nonatomic, strong) UIColor               *nb_normalTitleColor;

@property (nonatomic, strong) UIImage               *nb_normalImage;

@property (nonatomic, strong) UIImage               *nb_normalBackgroundImage;

/**
 *  highlighted/selected下的title,titleColor，image，backgroud image
 */
@property (nonatomic, copy  ) NSString              *nb_selectedTitle;

@property (nonatomic, strong) UIColor               *nb_selectedTitleColor;

@property (nonatomic, strong) UIImage               *nb_selectedImage;

@property (nonatomic, strong) UIImage               *nb_selectedBackgroundImage;

/**
 *  设置disabled下的title,titleColor，image，backgroud image
 */
@property (nonatomic, copy  ) NSString              *nb_disabledTitle;

@property (nonatomic, strong) UIColor               *nb_disabledTitleColor;

@property (nonatomic, strong) UIImage               *nb_disabledImage;

@property (nonatomic, strong) UIImage               *nb_disabledBackgroundImage;

// size是否可以自动缩放(只在max~min之间变化)
@property (nonatomic, assign, readonly) BOOL                  nb_width_scalable;
// 最大宽度
@property (nonatomic, assign, readonly) CGFloat               nb_max_width;
// 最小宽度
@property (nonatomic, assign, readonly) CGFloat               nb_min_width;
// title的内间距
@property (nonatomic, assign, readonly) CGFloat               nb_edge_width;

@end

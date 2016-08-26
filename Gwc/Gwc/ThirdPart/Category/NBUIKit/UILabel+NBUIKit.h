//
//  UILabel+NBUIKit.h
//  NBCategory
//
//  Created by 刘彬 on 16/3/15.
//  Copyright © 2016年 NewBee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (NBUIKit)

/**
 *  返回一个宽度为width的label，
 *
 *  @param width     宽度，默认300
 *  @param font      默认值为14
 *  @param color     默认值为黑色
 *  @param backgroud 默认值为白色
 *  @param alignment 默认值为NSTextAlignmentLeft
 *  @param multiLine 默认值为NO，为yes时高度随内容调整
 *
 *  @return label
 */
+ (instancetype)nb_labelWithWidth:(CGFloat)width
                             font:(UIFont *)font
                             color:(UIColor *)color
                        backgroud:(UIColor *)backgroud
                        alignment:(NSTextAlignment)alignment
                        multiLine:(BOOL)multiLine;

/**
 *  返回一个可变长度的label，根据内容调整宽度
 *
 *  @param min       默认值为0，若min大于max将被忽略
 *  @param max       默认值为300
 *  @param font      默认值为14
 *  @param color     默认值为黑色
 *  @param backgroud 默认值为白色
 *  @param alignment 默认值为NSTextAlignmentLeft
 *  @param multiLine 默认值为NO，为yes时高度随内容调整
 *
 *  @return label
 */
+ (instancetype)nb_labelWithWidthMin:(CGFloat)min
                                 max:(CGFloat)max
                                font:(UIFont *)font
                               color:(UIColor *)color
                           backgroud:(UIColor *)backgroud
                           alignment:(NSTextAlignment)alignment
                           multiLine:(BOOL)multiLine;


/**
 *  重新改变尺寸
 */
- (void)nb_sizeToFit;

// size是否可以自动缩放(只在max~min之间变化)
@property (nonatomic, assign, readonly) BOOL    nb_width_scalable;
// 最大宽度
@property (nonatomic, assign, readonly) CGFloat nb_max_width;
// 最小宽度
@property (nonatomic, assign, readonly) CGFloat nb_min_width;
//是否要显示多行
@property (nonatomic, assign, readonly) BOOL    nb_multi_line;

@end

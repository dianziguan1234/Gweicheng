//
//  UIView+NBUIKit.h
//  NBCategory
//
//  Created by 刘彬 on 16/3/15.
//  Copyright © 2016年 NewBee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (NBUIKit)

@property (nonatomic, assign) CGSize  nb_size;        // view大小，改变时不改变原点位置
@property (nonatomic, assign) CGPoint nb_origin;      // 起始点坐标
@property (nonatomic, assign) CGFloat nb_width;       // 宽
@property (nonatomic, assign) CGFloat nb_height;      // 高
@property (nonatomic, assign) CGFloat nb_x;           // 起始点x
@property (nonatomic, assign) CGFloat nb_y;           // 起始点y
@property (nonatomic, assign) CGFloat nb_left;        // 左边x
@property (nonatomic, assign) CGFloat nb_right;       // 右边x
@property (nonatomic, assign) CGFloat nb_top;         // 上边y
@property (nonatomic, assign) CGFloat nb_bottom;      // 底部y
@property (nonatomic, assign) CGPoint nb_center;      // 中心点坐标
@property (nonatomic, assign) CGFloat nb_centerX;     // 中线点X
@property (nonatomic, assign) CGFloat nb_centerY;     // 中心点Y
@property (nonatomic, assign) CGPoint nb_topLeft;     // 左上角坐标
@property (nonatomic, assign) CGPoint nb_topRight;    // 右上角坐标
@property (nonatomic, assign) CGPoint nb_bottomRight; // 右下角坐标
@property (nonatomic, assign) CGPoint nb_bottomLeft;  // 左下角坐标

/*!
 *  @brief  构造方法
 *
 *  @return UIView
 */
+ (UIView *)nb_view;
+ (UIView *)nb_viewWithFrame:(CGRect)frame;
+ (UIView *)nb_clearView;
+ (UIView *)nb_clearViewWithFrame:(CGRect)frame;
+ (UIView *)nb_viewWithColor:(UIColor *)color frame:(CGRect)frame;
+ (UIView *)nb_viewWithColor:(UIColor *)color;

/*!
 *  @brief  1像素宽或者高的线
 */
+ (UIView *)nb_lineWithHeight:(CGFloat)height color:(UIColor *)color;
+ (UIView *)nb_lineWithWidth:(CGFloat)width color:(UIColor *)color;

/*!
 *  @brief  添加手势
 */
- (UITapGestureRecognizer *)nb_addTapGestureWithTarget:(id)target action:(SEL)action;
- (UIPanGestureRecognizer *)nb_addPanGestureWithTarget:(id)target action:(SEL)action;
- (UISwipeGestureRecognizer *)nb_addSwipeGestureWithTarget:(id)target action:(SEL)action;

/*!
 *  @brief  添加渐隐渐出基础动画
 */
- (void)nb_fadeShowAnimation;
- (void)nb_fadeShowAnimationComplete:(void(^)(void))complete;
- (void)nb_fadeShowAnimationDuration:(NSTimeInterval)duration complete:(void(^)(void))complete;
- (void)nb_fadeHideAnimation;
- (void)nb_fadeHideAnimationComplete:(void(^)(void))complete;
- (void)nb_fadeHideAnimationDuration:(NSTimeInterval)duration complete:(void(^)(void))complete;

/**
 ** lineLength:	 虚线的宽度
 ** lineSpacing:	虚线的间距
 ** lineColor:	  虚线的颜色
 **/
- (void)drawDashLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;
@end

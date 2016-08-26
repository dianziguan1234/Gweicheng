//
//  UIView+NBUIKit.m
//  NBCategory
//
//  Created by 刘彬 on 16/3/15.
//  Copyright © 2016年 NewBee. All rights reserved.
//

#import "UIView+NBUIKit.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (NBUIKit)

+ (UIView *)nb_view {
    return [[UIView alloc] init];
}

+ (UIView *)nb_viewWithFrame:(CGRect)frame {
    return [[UIView alloc] initWithFrame:frame];
}

+ (UIView *)nb_clearView {
    UIView *view = [UIView nb_view];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

+ (UIView *)nb_clearViewWithFrame:(CGRect)frame {
    UIView *view = [UIView nb_viewWithFrame:frame];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

+ (UIView *)nb_viewWithColor:(UIColor *)color {
    UIView *view = [UIView nb_view];
    view.backgroundColor = color;
    return view;
}

+ (UIView *)nb_viewWithColor:(UIColor *)color frame:(CGRect)frame {
    UIView *view = [UIView nb_viewWithColor:color];
    view.frame = frame;
    return view;
}

+ (UIView *)nb_lineWithWidth:(CGFloat)width color:(UIColor *)color {
    UIView *view = [UIView nb_viewWithColor:color frame:CGRectMake(0, 0, width, 1)];
    return view;
}

+ (UIView *)nb_lineWithHeight:(CGFloat)height color:(UIColor *)color {
    UIView *view = [UIView nb_viewWithColor:color frame:CGRectMake(0, 0, 1, height)];
    return view;
}


#pragma mark - 添加手势
- (UITapGestureRecognizer *)nb_addTapGestureWithTarget:(id)target action:(SEL)action {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:tap];
    return tap;
}

- (UIPanGestureRecognizer *)nb_addPanGestureWithTarget:(id)target action:(SEL)action {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:pan];
    return pan;
}

- (UISwipeGestureRecognizer *)nb_addSwipeGestureWithTarget:(id)target action:(SEL)action {
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:swipe];
    return swipe;
}

#pragma mark - 添加动画
- (void)nb_fadeShowAnimation {
    [self nb_fadeShowAnimationComplete:nil];
}

- (void)nb_fadeShowAnimationComplete:(void(^)(void))complete {
    [self nb_fadeShowAnimationDuration:0.3f complete:complete];
}

- (void)nb_fadeShowAnimationDuration:(NSTimeInterval)duration complete:(void (^)(void))complete {
    self.hidden = NO;
    self.alpha = 0;
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished){
        if (complete) complete();
    }];
}

- (void)nb_fadeHideAnimation {
    [self nb_fadeHideAnimationComplete:nil];
}

- (void)nb_fadeHideAnimationComplete:(void(^)(void))complete {
    [self nb_fadeHideAnimationDuration:0.3f complete:complete];
}

- (void)nb_fadeHideAnimationDuration:(NSTimeInterval)duration complete:(void (^)(void))complete {
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished){
        self.hidden = YES;
        self.alpha = 1;
        if (complete) complete();
    }];
}

#pragma mark frame getter & setter

- (CGSize)nb_size {
    return self.frame.size;
}
- (void)setNb_size:(CGSize)nb_size {
    CGRect frame = self.frame;
    frame.size = nb_size;
    self.frame = frame;
}

- (CGPoint)nb_origin {
    return self.frame.origin;
}
- (void)setNb_origin:(CGPoint)nb_origin {
    CGRect frame = self.frame;
    frame.origin = nb_origin;
    self.frame = frame;
}

- (CGFloat)nb_height {
    return self.frame.size.height;
}
- (void)setNb_height:(CGFloat)nb_height {
    CGRect frame = self.frame;
    frame.size.height = nb_height;
    self.frame = frame;
}

- (CGFloat)nb_width {
    return self.frame.size.width;
}
- (void)setNb_width:(CGFloat)nb_width {
    CGRect frame = self.frame;
    frame.size.width = nb_width;
    self.frame = frame;
}


- (CGFloat)nb_x {
    return self.frame.origin.x;
}
- (void)setNb_x:(CGFloat)nb_x {
    CGRect frame = self.frame;
    frame.origin.x = nb_x;
    self.frame = frame;
}

- (CGFloat)nb_y {
    return self.frame.origin.y;
}
- (void)setNb_y:(CGFloat)nb_y {
    CGRect frame = self.frame;
    frame.origin.y = nb_y;
    self.frame = frame;
}

- (CGFloat)nb_left {
    return self.frame.origin.x;
}
- (void)setNb_left:(CGFloat)nb_left {
    CGRect frame = self.frame;
    frame.origin.x = nb_left;
    self.frame = frame;
}

- (CGFloat)nb_right {
    return self.frame.origin.x + self.frame.size.width;
}
- (void)setNb_right:(CGFloat)nb_right {
    CGRect frame = self.frame;
    frame.origin.x = nb_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)nb_top {
    return self.frame.origin.y;
}
- (void)setNb_top:(CGFloat)nb_top {
    CGRect frame = self.frame;
    frame.origin.y = nb_top;
    self.frame = frame;
}

- (CGFloat)nb_bottom {
    return self.frame.origin.y + self.frame.size.height;
}
- (void)setNb_bottom:(CGFloat)nb_bottom {
    CGRect frame = self.frame;
    frame.origin.y = nb_bottom - frame.size.height;
    self.frame = frame;
}

- (CGPoint)nb_center {
    return self.center;
}
- (void)setNb_center:(CGPoint)nb_center {
    self.center = nb_center;
}

- (CGFloat)nb_centerX {
    return self.center.x;
}
- (void)setNb_centerX:(CGFloat)nb_centerX {
    CGPoint center = self.center;
    center.x = nb_centerX;
    self.center = center;
}

- (CGFloat)nb_centerY {
    return self.center.y;
}
- (void)setNb_centerY:(CGFloat)nb_centerY {
    CGPoint center = self.center;
    center.y = nb_centerY;
    self.center = center;
}

- (CGPoint)nb_topLeft {
    return self.frame.origin;
}
- (void)setNb_topLeft:(CGPoint)nb_topLeft {
    CGRect frame = self.frame;
    frame.origin = nb_topLeft;
    self.frame = frame;
}

- (CGPoint)nb_topRight {
    CGRect frame = self.frame;
    frame.origin.x += frame.size.width;
    return frame.origin;
}
- (void)setNb_topRight:(CGPoint)nb_topRight {
    CGRect frame = self.frame;
    frame.origin.x = nb_topRight.x - frame.size.width;
    frame.origin.y = nb_topRight.y;
    self.frame = frame;
}

- (CGPoint)nb_bottomLeft {
    CGRect frame = self.frame;
    frame.origin.y += frame.size.height;
    return frame.origin;
}
- (void)setNb_bottomLeft:(CGPoint)nb_bottomLeft {
    CGRect frame = self.frame;
    frame.origin.x = nb_bottomLeft.x;
    frame.origin.y = nb_bottomLeft.y - frame.size.height;
    self.frame = frame;
}

- (CGPoint)nb_bottomRight {
    CGRect frame = self.frame;
    frame.origin.x += frame.size.width;
    frame.origin.y += frame.size.height;
    return frame.origin;
}
- (void)setNb_bottomRight:(CGPoint)nb_bottomRight {
    CGRect frame = self.frame;
    frame.origin.x = nb_bottomRight.x - frame.size.width;
    frame.origin.y = nb_bottomRight.y - frame.size.height;
    self.frame = frame;
}

/**
 ** lineLength:	 虚线的宽度
 ** lineSpacing:	虚线的间距
 ** lineColor:	  虚线的颜色
 **/
- (void)drawDashLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(self.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(self.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [self.layer addSublayer:shapeLayer];
}

@end

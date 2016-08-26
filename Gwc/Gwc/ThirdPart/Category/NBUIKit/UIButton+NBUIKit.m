//
//  UIButton+NBUIKit.m
//  NBCategory
//
//  Created by 刘彬 on 16/3/15.
//  Copyright © 2016年 NewBee. All rights reserved.
//

#import "UIButton+NBUIKit.h"
#import "UIImage+NBUIKit.h"
#import "NSObject+AssociatedObjects.h"
#import "NSString+NBUIKit.h"

@implementation UIButton (NBUIKit)

#pragma mark - create
+ (instancetype)nb_buttonWithWidthMin:(CGFloat)min
                                   max:(CGFloat)max
                                  edge:(CGFloat)edge
                         widthScalable:(BOOL)widthScalable
                                height:(CGFloat)height
                                  font:(UIFont *)font
                                 color:(UIColor *)color
                              selected:(UIColor *)selectedColor
                              disabled:(UIColor *)disabledColor
                             backgroud:(UIImage *)backgroud
                              selected:(UIImage *)selectedBackgroud
                              disabled:(UIImage *)disabledBackgroud {
    
    
    // 设置frame
    CGRect frame           = CGRectZero;
    CGFloat aMax           = ceil( max < 0.0f ? 300.0f : max );
    frame.size.width       = ceil( max < 0.0f ? 300.0f : max );
    frame.size.height      = ceil( height < 0.0f ? 40.0f : height );

    UIButton *button       = [[UIButton alloc] init];
    button.exclusiveTouch  = YES;
    button.titleLabel.font = (nil == font ? Normal_Font : font);
    button.frame           = frame;

    // 设置TitleColor
    if (color) {
        [button setTitleColor:color forState:UIControlStateNormal];
    }
    if (selectedColor) {
        [button setTitleColor:selectedColor forState:UIControlStateHighlighted];
        [button setTitleColor:selectedColor forState:UIControlStateSelected];
        [button setTitleColor:selectedColor forState:UIControlStateHighlighted|UIControlStateSelected];
    }
    if (disabledColor) {
        [button setTitleColor:disabledColor forState:UIControlStateDisabled];
    }
    
    // 设置BackgroundImage
    if (backgroud) {
        [button setBackgroundImage:[backgroud nb_centerStretchImage] forState:UIControlStateNormal];
    }
    if (selectedBackgroud) {
        [button setBackgroundImage:[selectedBackgroud nb_centerStretchImage] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[selectedBackgroud nb_centerStretchImage] forState:UIControlStateSelected];
        [button setBackgroundImage:[selectedBackgroud nb_centerStretchImage] forState:UIControlStateHighlighted|UIControlStateSelected];
    }
    if (disabledBackgroud) {
        [button setBackgroundImage:[disabledBackgroud nb_centerStretchImage] forState:UIControlStateDisabled];
    }
    
    button.nb_width_scalable = widthScalable;
    button.nb_max_width = ceil(max);
    button.nb_min_width = ceil(min > aMax ? aMax : min);
    if (widthScalable) {
        button.nb_edge_width = ceil(edge < 0.0f ? 10.0f : edge);
    }
    
    return button;
}

+ (instancetype)nb_buttonWithSize:(CGSize)size
                             font:(UIFont *)font
                            color:(UIColor *)color
                         selected:(UIColor *)selectedColor
                         disabled:(UIColor *)disabledColor
                        backgroud:(UIImage *)backgroud
                         selected:(UIImage *)selectedBackgroud
                         disabled:(UIImage *)disabledBackgroud {
    return [self nb_buttonWithWidthMin:size.width
                                   max:size.width
                                  edge:0.0f
                         widthScalable:NO
                                height:size.height
                                  font:font color:color
                              selected:selectedColor
                              disabled:disabledColor
                             backgroud:backgroud
                              selected:selectedBackgroud
                              disabled:disabledBackgroud];
}

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
                             disabled:(UIImage *)disabledBackgroud {
    return [self nb_buttonWithWidthMin:min
                                   max:max
                                  edge:edge
                         widthScalable:YES
                                height:height
                                  font:font
                                 color:color
                              selected:selectedColor
                              disabled:disabledColor
                             backgroud:backgroud
                              selected:selectedBackgroud
                              disabled:disabledBackgroud];
}

/**
 *  重新改变尺寸
 */
- (void)nb_sizeToFit {
    // 不允许缩放
    if (!self.nb_width_scalable) {
        [self sizeToFit];
        return ;
    }
    
    NSString *text = self.currentTitle;
    if (!text) {
        text = @"";
    }
    
    CGRect frame = self.frame;
    
    CGFloat maxWidth = [self nb_max_width];
    CGFloat minWidth = [self nb_min_width];
    
    CGSize size = [text nb_sizeWithFont:self.titleLabel.font maxWidth:maxWidth];
    
    // 根据内间距调整一下宽度
    CGFloat edge = [self nb_edge_width];
    if (size.width + 2*edge < minWidth) { // 小于最小宽度适配最小宽度
        frame.size.width = minWidth;
    }
    else if (size.width + 2*edge > maxWidth){ // 大于最大宽度适配最大宽度
        frame.size.width = maxWidth;
    }
    else {
        frame.size.width = size.width + 2*edge;
    }

    self.frame = frame;
}

- (void)nb_addTarget:(id)target touchAction:(SEL)selector {
    if (target) {
        [self removeTarget:target action:NULL forControlEvents:UIControlEventTouchUpInside];
    }
    [self addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if (UIEdgeInsetsEqualToEdgeInsets(self.nb_hitEdgeOutsets, UIEdgeInsetsZero) || !self.enabled || self.hidden) {
        return [super pointInside:point withEvent:event];
    }
    UIEdgeInsets edge = self.nb_hitEdgeOutsets;
    edge.top          = -edge.top;
    edge.bottom       = -edge.bottom;
    edge.left         = -edge.left;
    edge.right        = -edge.right;
    CGRect hitFrame   = UIEdgeInsetsInsetRect(self.bounds, edge);
    return CGRectContainsPoint(hitFrame, point);
}

#pragma mark - private getter & setter
- (BOOL)nb_width_scalable {
    return [[self associatedObjectForKey:@"nb_width_scalable"] boolValue];
}
- (void)setNb_width_scalable:(BOOL)nb_width_scalable {
    NSNumber *number = [NSNumber numberWithBool:nb_width_scalable];
    [self associateStrongNonatomicObject:number withKey:@"nb_width_scalable"];
}

- (CGFloat)nb_max_width {
    return [[self associatedObjectForKey:@"nb_max_width"] floatValue];
}
- (void)setNb_max_width:(CGFloat)nb_max_width {
    NSNumber *number = [NSNumber numberWithFloat:nb_max_width];
    [self associateStrongNonatomicObject:number withKey:@"nb_max_width"];
}

- (CGFloat)nb_min_width {
    return [[self associatedObjectForKey:@"nb_min_width"] floatValue];
}
- (void)setNb_min_width:(CGFloat)nb_min_width {
    NSNumber *number = [NSNumber numberWithFloat:nb_min_width];
    [self associateStrongNonatomicObject:number withKey:@"nb_min_width"];
}

- (CGFloat)nb_edge_width {
    return [[self associatedObjectForKey:@"nb_min_width"] floatValue];
}
- (void)setNb_edge_width:(CGFloat)nb_edge_width {
    NSNumber *number = [NSNumber numberWithFloat:nb_edge_width];
    [self associateStrongNonatomicObject:number withKey:@"nb_edge_width"];
}

#pragma mark - public getter & setter
- (UIEdgeInsets)nb_hitEdgeOutsets {
    NSValue * value = [self associatedObjectForKey:@"nb_hitEdgeOutsets"];
    if(value) {
        return [value UIEdgeInsetsValue];
    }
    return UIEdgeInsetsZero;
}

- (void)setNb_hitEdgeOutsets:(UIEdgeInsets)hitEdgeOutsets {
    NSValue *value = [NSValue valueWithUIEdgeInsets:hitEdgeOutsets];
    [self associateStrongNonatomicObject:value withKey:@"nb_hitEdgeOutsets"];
}

- (NSString *)nb_normalTitle {
    return [self titleForState:UIControlStateNormal];
}
- (void)setNb_normalTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
}

- (UIColor *)nb_normalTitleColor {
    return [self titleColorForState:UIControlStateNormal];
}
- (void)setNb_normalTitleColor:(UIColor *)color {
    [self setTitleColor:color forState:UIControlStateNormal];
}

- (UIImage *)nb_normalImage {
    return [self imageForState:UIControlStateNormal];
}
- (void)setNb_normalImage:(UIImage *)image {
    [self setImage:image forState:UIControlStateNormal];
}

- (UIImage *)nb_normalBackgroundImage {
    return [self backgroundImageForState:UIControlStateNormal];
}
- (void)setNb_normalBackgroundImage:(UIImage *)image {
    [self setBackgroundImage:image forState:UIControlStateNormal];
}

- (NSString *)nb_selectedTitle {
    return [self titleForState:UIControlStateHighlighted];
}
- (void)setNb_selectedTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateHighlighted];
    [self setTitle:title forState:UIControlStateSelected];
    [self setTitle:title forState:UIControlStateHighlighted|UIControlStateSelected];
}

- (UIColor *)nb_selectedTitleColor {
    return [self titleColorForState:UIControlStateHighlighted];
}
- (void)setNb_selectedTitleColor:(UIColor *)color {
    [self setTitleColor:color forState:UIControlStateHighlighted];
    [self setTitleColor:color forState:UIControlStateSelected];
    [self setTitleColor:color forState:UIControlStateHighlighted|UIControlStateSelected];
}

- (UIImage *)nb_selectedImage {
    return [self imageForState:UIControlStateHighlighted];
}
- (void)setNb_selectedImage:(UIImage *)image {
    [self setImage:image forState:UIControlStateHighlighted];
    [self setImage:image forState:UIControlStateSelected];
    [self setImage:image forState:UIControlStateHighlighted|UIControlStateSelected];
}

- (UIImage *)nb_selectedBackgroundImage {
    return [self backgroundImageForState:UIControlStateHighlighted];
}
- (void)setNb_selectedBackgroundImage:(UIImage *)image {
    [self setBackgroundImage:image forState:UIControlStateHighlighted];
    [self setBackgroundImage:image forState:UIControlStateSelected];
    [self setBackgroundImage:image forState:UIControlStateHighlighted|UIControlStateSelected];
}

- (NSString *)nb_disabledTitle {
    return [self titleForState:UIControlStateDisabled];
}
- (void)setNb_disabledTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateDisabled];
}

- (UIColor *)nb_disabledTitleColor {
    return [self titleColorForState:UIControlStateDisabled];
}
- (void)setNb_disabledTitleColor:(UIColor *)color {
    [self setTitleColor:color forState:UIControlStateDisabled];
}

- (UIImage *)nb_disabledImage {
    return [self imageForState:UIControlStateDisabled];
}
- (void)setNb_disabledImage:(UIImage *)image {
    [self setImage:image forState:UIControlStateDisabled];
}

- (UIImage *)nb_disabledBackgroundImage {
    return [self backgroundImageForState:UIControlStateDisabled];
}
- (void)setNb_disabledBackgroundImage:(UIImage *)image {
    [self setBackgroundImage:image forState:UIControlStateDisabled];
}



@end

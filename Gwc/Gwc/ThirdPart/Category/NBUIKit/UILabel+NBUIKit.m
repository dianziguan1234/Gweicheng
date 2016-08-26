//
//  UILabel+NBUIKit.m
//  NBCategory
//
//  Created by 刘彬 on 16/3/15.
//  Copyright © 2016年 NewBee. All rights reserved.
//

#import "UILabel+NBUIKit.h"
#import "NSObject+AssociatedObjects.h"
#import "NSString+NBUIKit.h"
#import "NSAttributedString+NBUIKit.h"
#import <objc/runtime.h>

@implementation UILabel (NBUIKit)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 替换一下setText方法
        swizzleMethod([self class], @selector(setText:), @selector(swizzle_setText:));
    });
}

#pragma mark - Method Swizzling

/*!
 *  @brief  过滤掉(null)
 *
 *  @param text 原始字符串
 */
- (void)swizzle_setText:(NSString *)text{
    text = [text stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    [self swizzle_setText:text];
}

+ (instancetype)nb_labelWithWidthMin:(CGFloat)min
                                 max:(CGFloat)max
                       widthScalable:(BOOL)widthScalable
                                font:(UIFont *)font
                               color:(UIColor *)color
                           backgroud:(UIColor *)backgroud
                           alignment:(NSTextAlignment)alignment
                           multiLine:(BOOL)multiLine {
    
    //主题读取
    UIFont *aFont           = (nil == font ? [UIFont systemFontOfSize:14.0f] : font);
    UIColor *aColor         = (nil == color ? [UIColor blackColor] : color);
    UIColor *aBackgroud     = (nil == backgroud ? [UIColor whiteColor] : backgroud);

    CGRect frame            = CGRectZero;

    CGFloat aMax            = ceil( max < 0.0f ? 300.0f : max );
    frame.size.width        = aMax;
    frame.size.height       = ceil(aFont.lineHeight);

    UILabel *label          = [[[self class] alloc] initWithFrame:frame];
    label.font              = aFont;
    label.textColor         = aColor;
    label.backgroundColor   = aBackgroud;
    label.textAlignment     = alignment;

    label.nb_width_scalable = widthScalable;
    label.nb_multi_line     = multiLine;
    if (multiLine) {
    label.numberOfLines     = 0;
    }
    label.nb_min_width      = ceil(min > aMax ? aMax : min);
    label.nb_max_width      = ceil(max);
    
    return label;
}

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
                        multiLine:(BOOL)multiLine {
    return [self nb_labelWithWidthMin:width
                                  max:width
                        widthScalable:NO
                                 font:font
                                color:color
                            backgroud:backgroud
                            alignment:alignment
                            multiLine:multiLine];
}

/**
 *  返回一个可变长度的label，根据内容调整宽度，调用
 *
 *  @param min       默认值为0
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
                           multiLine:(BOOL)multiLine {
    return [self nb_labelWithWidthMin:min
                                  max:max
                        widthScalable:YES
                                 font:font
                                color:color
                            backgroud:backgroud
                            alignment:alignment
                            multiLine:multiLine];
}

/**
 *  重新改变尺寸
 */
- (void)nb_sizeToFit {
    
    BOOL multiLine = [self nb_multi_line];
    BOOL widthScalable = [self nb_width_scalable];
    if (!multiLine && !widthScalable) {
        [self sizeToFit];
        return ;
    }
    CGRect frame = self.frame;
    
    CGFloat maxWidth = [self nb_max_width];
    CGFloat minWidth = [self nb_min_width];
    
    //可变字体和不可变字体都应该计算后取最大的
    CGSize size1 = CGSizeZero;
    if (self.attributedText) {
        size1 = [self.attributedText nb_sizeWithMaxWidth:maxWidth];
    }
    
    NSString *text = self.text;
    if (!text) {
        text = @"";
    }
    CGSize size2 = [text nb_sizeWithFont:self.font maxWidth:maxWidth];
    
    CGSize size = size1;
    if (size2.height > size.height) {
        size = size2;
    }
    
    if (widthScalable) {//宽度需要调整
        if (size.width < minWidth) {
            frame.size.width = minWidth;
        }
        else if (size.width > maxWidth){
            frame.size.width = maxWidth;
        }
        else {
            frame.size.width = size.width;
        }
    }
    
    //多行处理
    if (multiLine) {
        
        CGFloat line_height = ceil(self.font.lineHeight);
        
        //兼容行间距问题
        if (size.height > line_height && 2*line_height > size.height) {
            frame.size.height = line_height;
            
            @autoreleasepool {
                NSAttributedString *attrtext = self.attributedText;
                NSMutableAttributedString *attr = [attrtext mutableCopy];
                NSRange range = NSMakeRange(0, [attr length]);
                
                //去掉段落行距
                [attrtext enumerateAttribute:NSParagraphStyleAttributeName inRange:range options:0 usingBlock:^(id value, NSRange range, BOOL *stop) {
                    
                    if ([value isKindOfClass:[NSParagraphStyle class]]) {
                        NSMutableParagraphStyle *style = [value mutableCopy];
                        style.lineSpacing = 0.0f;
                        [attr addAttribute:NSParagraphStyleAttributeName value:style range:range];
                    }
                    
                }];
                
                self.attributedText = attr;
            }
            
        }
        else {
            frame.size.height = size.height;
        }
        
        self.numberOfLines = 0;
    }
    
    self.frame = frame;
}

#pragma mark 
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

- (BOOL)nb_multi_line {
    return [[self associatedObjectForKey:@"nb_multi_line"] boolValue];
}
- (void)setNb_multi_line:(BOOL)nb_multi_line {
    NSNumber *number = [NSNumber numberWithBool:nb_multi_line];
    [self associateStrongNonatomicObject:number withKey:@"nb_multi_line"];
}

@end

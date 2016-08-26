//
//  UITextField+NBUIKit.m
//  LawMonkey
//
//  Created by 刘彬 on 16/3/20.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "UITextField+NBUIKit.h"

@implementation UITextField (NBUIKit)

/**
 *  输入框定义
 *
 *  @param size       尺寸
 *  @param font       字体大小，默认值为14
 *  @param color      字体颜色，默认值为黑色
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
                         minFont:(CGFloat)minFont {
    return [self nb_inputWithSize:size
                             font:font
                            color:color
                      placeholder:(NSString *)placeholder
                       adjustFont:adjustFont
                          minFont:minFont
                        maxLength:0
                   characterLimit:nil];
}

/**
 *  输入框定义
 *
 *  @param size       尺寸，默认CGSize(180,40)
 *  @param font       字体大小，默认值为14
 *  @param color      字体颜色，默认值为黑色
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
                  characterLimit:(NSCharacterSet *)characterLimit {
    //主题读取
    UIFont *aFont = (nil == font ? Normal_Font : font);
    UIColor *aColor = (nil == color ? [UIColor blackColor] : color);
    
    CGRect frame = CGRectZero;
    frame.size.width = (size.width <= 0.0f ? 180.0f : size.width);
    frame.size.height = (size.height <= 0.0f ? 40.0f : size.height);
    
    CGFloat aMinFont = (minFont < 0.0f ? 11.0f : minFont);
    
    UITextField *input              = [[[self class] alloc] initWithFrame:frame];
    input.font                      = aFont;
    input.textColor                 = aColor;
    input.placeholder               = placeholder;
    input.adjustsFontSizeToFitWidth = adjustFont;
    input.backgroundColor           = [UIColor clearColor];
    input.minimumFontSize           = aMinFont;
    input.clearButtonMode           = UITextFieldViewModeWhileEditing;
    
    if (maxLength > 0) {
        input.nb_maxLength = maxLength;
    }
    
    if (characterLimit) {
        input.nb_characterLimit = characterLimit;
    }
    
    [input addTarget:input action:@selector(sf_input_did_change_action:) forControlEvents:UIControlEventEditingChanged];
    
    return input;
}

- (void)sf_input_did_change_action:(id)sender {
    @autoreleasepool {
        //解决ios7中文键盘崩溃问题
        if (self.markedTextRange != nil) {
            return;
        }
        
        NSString *text = self.text;
        if ([text length] == 0) {
            return ;
        }
        
        //字符长度限制
        NSUInteger max_length = self.nb_maxLength;
        if (max_length > 0 && [text length] > max_length) {
            text = [text substringToIndex:max_length];
        }
        
        //先判断非法字符
        NSCharacterSet *set = self.nb_characterLimit;
        if (set) {//非法字符判断
            NSString *result = [text stringByTrimmingCharactersInSet:set];
            
            if ([result length]) {//需要过滤
                text = [text nb_substringMeetCharacterSet:set];
            }
        }
        
        //格式限定
        NSString *(^nb_format)(NSString *originText) = self.nb_format;
        if (nb_format) {
            NSString *atext = nb_format(text);
            if ([atext length]) {
                text = atext;
            }
        }
        
        //最后结果
        if (text != self.text && ![text isEqualToString:self.text]) {
            self.text = text;
        }
    }
}


#pragma getter & setter
- (NSUInteger)nb_maxLength {
    return [[self associatedObjectForKey:@"nb_maxLength"] unsignedIntegerValue];
}
- (void)setNb_maxLength:(NSUInteger)nb_maxLength {
    if (nb_maxLength > 0 && [self.text length] > nb_maxLength) {
        self.text = [self.text substringToIndex:nb_maxLength];
    }
    [self associateStrongNonatomicObject:@(nb_maxLength) withKey:@"nb_maxLength"];
}

- (NSCharacterSet *)nb_characterLimit {
    return [self associatedObjectForKey:@"nb_characterLimit"];
}
- (void)setNb_characterLimit:(NSCharacterSet *)nb_characterLimit {
    NSCharacterSet *set = self.nb_characterLimit;
    if ((set == nil && nb_characterLimit == nil) || [set isEqual:nb_characterLimit]) {
        return ;
    }
    if (nb_characterLimit && (!set || ![nb_characterLimit isSupersetOfSet:set])) {
        self.text = [self.text nb_substringMeetCharacterSet:nb_characterLimit];
    }
    [self associateStrongNonatomicObject:nb_characterLimit withKey:@"nb_characterLimit"];
}

/**
 *  输入格式限定，如344，335
 */
- (NSString *(^)(NSString *originText))nb_format {
    return [self associatedObjectForKey:@"nb_format"];
}
- (void)setNb_format:(NSString *(^)(NSString *))nb_format {
    if (nb_format) {
        @autoreleasepool {
            NSString *text = nb_format(self.text);
            if ([text length] && ![text isEqualToString:self.text]) {
                self.text = text;
            }
        }
    }
    [self associateStrongNonatomicObject:nb_format withKey:@"nb_format"];
}

/*!
 *  @brief  左View范围
 */
- (CGFloat)leftWidth{
    return [[self associatedObjectForKey:@"leftWidth"] floatValue];
}

- (void)setLeftWidth:(CGFloat)leftWidth{
    NSNumber *number = [NSNumber numberWithFloat:leftWidth];
    [self associateWeakObject:number withKey:@"leftWidth"];
}

/*!
 *  @brief  右View范围
 */
- (CGFloat)rightWidth{
    return [[self associatedObjectForKey:@"rightWidth"] floatValue];
}

- (void)setRightWidth:(CGFloat)rightWidth{
    NSNumber *number = [NSNumber numberWithFloat:rightWidth];
    [self associateWeakObject:number withKey:@"rightWidth"];
}


- (void)setLeftViewImage:(NSString*)leftImage leftWidth:(float)leftWidth
{
    if(leftWidth <= 0)
    {
        return;
    }
    self.leftViewMode = UITextFieldViewModeAlways;
    if([NSString nb_isEmpty:leftImage])
    {
//        UIImage *img = [UIImage imageNamed:leftImage];
    }
    else
    {
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 45, 50)];
        lbl.backgroundColor = [UIColor clearColor];
        lbl.textColor = [UIColor lightGrayColor];
        lbl.text = @"Start:";
        self.leftView = lbl;
    }
}


- (void)clearLeftView{
    self.leftViewMode = UITextFieldViewModeNever;
    self.leftView = nil;
}
- (void)clearRightView{
    self.rightViewMode = UITextFieldViewModeNever;
    self.rightView = nil;
}

/*!
 *  @brief  设置左边View (添加前一定要设置范围)
 *
 *  @param imageName 按钮图片
 *  @param text      按钮文字
 *  @param color     按钮文字颜色
 */
- (void)setLeftWithImageName:(NSString *)imageName imageOffx:(CGFloat)offX
{
    if(self.leftWidth <= 0){
        return;
    }
    UIButton *leftButton = [self getButtonStyle:1];
    leftButton.userInteractionEnabled = NO;
    [leftButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
    [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0.0f, offX, 0.0f, 0.0f)];
    self.leftView = leftButton;
}

- (void)setLeftWithText:(NSString *)text textColor:(UIColor *)color textFont:(UIFont*)font textOffx:(CGFloat)offX
{
    if([NSString nb_isEmpty:text] ||self.leftWidth <= 0){
        return;
    }
    UIButton *leftButton = [self getButtonStyle:1];
    leftButton.userInteractionEnabled = NO;
    leftButton.nb_normalTitle = text;
    leftButton.nb_normalTitleColor = color;
    leftButton.titleLabel.font = font;
    [leftButton setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, offX, 0.0f, 0.0f)];
    self.leftView = leftButton;
}


- (void)setRightWithImageName:(NSString *)imageName imageOffx:(CGFloat)offX
{
    if(self.rightWidth <= 0){
        return;
    }
    UIButton *rightButton = [self getButtonStyle:0];
    [rightButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
    [rightButton setImageEdgeInsets:UIEdgeInsetsMake(0.0f, 0.f, 0.0f, offX)];
    self.rightView = rightButton;
}

- (void)setRightWithText:(NSString *)text textColor:(UIColor *)color textFont:(UIFont*)font textOffx:(CGFloat)offX
{
    if([NSString nb_isEmpty:text] ||self.rightWidth <= 0){
        return;
    }
    UIButton *rightButton = [self getButtonStyle:0];
    rightButton.nb_normalTitle = text;
    rightButton.nb_normalTitleColor = color;
    rightButton.titleLabel.font = font;
    [rightButton setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, offX)];
    self.rightView = rightButton;
}

- (UIButton*)getButtonStyle:(int)type
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0.0f, 0.0f, type ? self.leftWidth : self.rightWidth, self.frame.size.height);
    if(type)
    {
        self.leftViewMode = UITextFieldViewModeAlways;
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    else
    {
        self.rightViewMode = UITextFieldViewModeAlways;
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return btn;
}
@end

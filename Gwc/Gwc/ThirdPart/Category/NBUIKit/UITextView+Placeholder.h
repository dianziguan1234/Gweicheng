//
//  UITextView+Placeholder.h
//  LawMonkey
//
//  Created by jason on 16/8/20.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Placeholder)
/**
 * 占位提示语
 */
@property (nonatomic, copy)  NSString * nb_placeholder;

/**
 * 占位提示语的字体颜色
 */
@property (nonatomic, strong) UIColor *nb_placeholderColor;

/**
 * 占位提示语的字体
 */
@property (nonatomic, strong) UIFont  *nb_placeholderFont;

/**
 * 占位提示语标签
 */
@property (nonatomic, strong, readonly) UILabel *nb_placeholderLabel;

@end

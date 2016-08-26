//
//  UIViewController+NavigationBar.h
//  LawMonkey
//
//  Created by 刘彬 on 16/3/20.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NavigationBar)

/*!
 *  @brief  设置title
 */
- (void)setNavTitle:(NSString *)title;
- (void)setNavTitle:(NSString *)title color:(UIColor *)color;
- (void)setNavTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font;
- (void)setNavTitleWithView:(UIView *)view;
- (void)setNavTitleWithImage:(NSString *)imageName;

/*!
 *  @brief  清除button
 */
- (void)clearLeftButton;
- (void)clearRightButton;

/*!
 *  @brief  设置返回按钮
 */
- (void)setNavBackButton;
- (void)back;

/*!
 *  @brief  设置左边按钮
 *
 *  @param imageName 按钮图片
 *  @param text      按钮文字
 *  @param color     按钮文字颜色
 *  @param action    按钮响应SEL
 *
 *  @return 按钮
 */
- (UIButton *)setNavLeftButtonWithImageName:(NSString *)imageName action:(SEL)action;
- (UIButton *)setNavLeftButtonWithText:(NSString *)text action:(SEL)action;
- (UIButton *)setNavLeftButtonWithText:(NSString *)text textColor:(UIColor *)color action:(SEL)action;

/*!
 *  @brief  设置右边按钮
 *
 *  @param imageName 按钮图片
 *  @param text      按钮文字
 *  @param color     按钮文字颜色
 *  @param action    按钮响应SEL
 *
 *  @return 按钮
 */
- (UIButton *)setNavRightButtonWithImageName:(NSString *)imageName action:(SEL)action;
- (UIButton *)setNavRightButtonWithText:(NSString *)text action:(SEL)action;
- (UIButton *)setNavRightButtonWithText:(NSString *)text textColor:(UIColor *)color action:(SEL)action;

/*!
 *  @brief  设置图片选择vc风格和app风格保持一致
 *
 *  @param picker <#picker description#>
 */
- (void)setImagePickerNavigationBarStyle:(UIImagePickerController*)picker;
@end

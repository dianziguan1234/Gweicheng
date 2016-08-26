//
//  UIViewController+Toast.h
//  LawMonkey
//
//  Created by 刘彬 on 16/3/20.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IndicatorView;

/*!
 *  @brief  加载等待动画，提示信息
 */
@interface UIViewController (Toast)

@property (nonatomic, strong) UIView *placeholderView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIButton *actionBtn;

/*!
 *  @brief  显示等待icon
 */
- (void)showIndicatorView;
- (void)showIndicatorViewWithMessage:(NSString *)message;

/*!
 *  @brief  隐藏等待icon
 */
- (void)hideIndicatorView;
- (void)hideIndicatorViewAfterDelay:(NSTimeInterval)delay;

/*!
 *  @brief  显示一个普通信息提示框
 *`
 *  @param message 提示信息
 */
- (void)toast:(NSString *)message;

/*!
 *  @brief  显示一个错误提示框
 *
 *  @param error 错误信息
 */
- (void)toastWithError:(NSError *)error;
- (void)toastWithErrorMessage:(NSString *)message;

/*!
 *  @brief 显示一个成功提示框
 *
 *  @param message 提示信息
 */
- (void)toastWithSuccess:(NSString *)message;

/*!
 *  @brief  显示空数据界面
 */
- (void)showEmptyPlaceholder;

/*!
 *  @brief 显示空数据界面
 *
 *  @param icon    icon
 *  @param message 提示信息
 */
- (void)showEmptyPlaceholderWithIcon:(UIImage *)icon message:(NSString *)message;

/*!
 *  @brief  显示异常界面
 *
 *  @param error 错误信息
 */
- (void)showErrorPlaceholderWithError:(NSError *)error;

/*!
 *  @brief  view点击事件，可重载
 */
- (void)placeholderViewHandler;

/*!
 *  @brief  按钮点击事件，可重载
 */
- (void)placeholderButtonAction;

/*!
 *  @brief  移除提示界面
 */
- (void)removePlaceholder;

@end

/*!
 *  @brief  带gif的等待view
 */
@interface GifLoadingView : UIView

@end

/*!
 *  @brief  等待view
 */
@interface IndicatorView : UIView

- (void)startAnimating;
- (void)stopAnimating;
- (BOOL)isAnimating;

@end

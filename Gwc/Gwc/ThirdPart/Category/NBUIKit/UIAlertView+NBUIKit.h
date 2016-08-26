//
//  UIAlertView+NBUIKit.h
//  LawMonkey
//
//  Created by 刘彬 on 16/4/3.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIAlertViewHandler)(UIAlertView *alertView, NSInteger buttonIndex);

@interface UIAlertView (NBUIKit)

/**
 * Shows the receiver alert with the given handler.
 *
 * @param handler The handler that will be invoked in user interaction.
 */
- (void)showWithHandler:(UIAlertViewHandler)handler;

/**
 * Utility selector to show an alert with a title, a message and a button to dimiss.
 *
 * @param title The title of the alert.
 * @param message The message to show in the alert.
 * @param handler The handler that will be invoked in user interaction.
 */
+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
              handler:(UIAlertViewHandler)handler;

/**
 * Utility selector to show an alert with an "Error" title, a message and a button to dimiss.
 *
 * @param message The message to show in the alert.
 * @param handler The handler that will be invoked in user interaction.
 */
+ (void)showErrorWithMessage:(NSString *)message
                     handler:(UIAlertViewHandler)handler;

/**
 * Utility selector to show an alert with a "Warning" title, a message and a button to dimiss.
 *
 * @param message The message to show in the alert.
 * @param handler The handler that will be invoked in user interaction.
 */
+ (void)showWarningWithMessage:(NSString *)message
                       handler:(UIAlertViewHandler)handler;

/**
 * Utility selector to show a confirmation dialog with a title, a message and two buttons to accept or cancel.
 *
 * @param title The title of the alert.
 * @param message The message to show in the alert.
 * @param handler The handler that will be invoked in user interaction.
 */
+ (void)showConfirmationDialogWithTitle:(NSString *)title
                                message:(NSString *)message
                                handler:(UIAlertViewHandler)handler;

+ (void)showConfirmationDialogWithTitle:(NSString *)title
                                message:(NSString *)message
                                 cancel:(NSString *)cancel
                                confirm:(NSString *)confirm
                                handler:(UIAlertViewHandler)handler;

@end

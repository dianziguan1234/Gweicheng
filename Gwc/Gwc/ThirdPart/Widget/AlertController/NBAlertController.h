//
//  NBAlertController.h
//  LawMonkey
//
//  Created by 刘彬 on 16/4/23.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// alter style
typedef NS_ENUM(NSUInteger, NBAlertControllerStyle) {
    NBAlertControllerStyleActionSheet,
    NBAlertControllerStyleAlter,
};

// action style
typedef NS_ENUM(NSInteger, NBAlertActionStyle) {
    NBAlertActionStyleDefault = 0,
    NBAlertActionStyleCancel,
    NBAlertActionStyleDestructive
};


@interface NBAlertAction : NSObject
/*!
 *  @brief NBAlertAction构造方法
 *
 *  @param title   title
 *  @param style   NBAlertActionStyle
 *  @param handler handle
 *
 */
+(instancetype)actionWithTitle:(NSString *)title
                         style:(NBAlertActionStyle)style
                       handler:(void (^ _Nullable)(NBAlertAction * _Nonnull action))handler;
@end

@interface NBAlertController : NSObject

/*!
 *  @brief 默认初始化方法
 *
 *  @param title          title
 *  @param message        message
 *  @param preferredStyle NBAlertControllerStyle
 */
+ (instancetype)alertControllerWithTitle:(nullable NSString *)title
                                 message:(nullable NSString *)message
                          preferredStyle:(NBAlertControllerStyle)preferredStyle;

/*!
 *  @brief 显示一个actionSheet
 *
 *  @param title title
 *
 */
+ (instancetype)actionSheetWithTitle:(nullable NSString *)title;

/*!
 *  @brief 显示一个alter
 *
 *  @param title   title
 *  @param message message
 *
 */
+ (instancetype)alertWithTitle:(nullable NSString *)title message:(nullable NSString *)message;

- (instancetype)init NS_UNAVAILABLE;

/*!
 *  @brief 增加action
 *
 *  @param action NBAlertAction
 */
- (void)addAction: (NBAlertAction *)action;

/*!
 *  @brief 支持UITextField操作
 *
 *  @param configurationHandler block
 */
- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField *textField))configurationHandler;

/*!
 *  @brief 显示alterController
 *
 *  @param viewController viewController
 *  @param flag           flag
 *  @param completion     block
 */
-(void)nb_presentViewWithController:(nullable UIViewController *)viewController
                           animated:(BOOL)flag
                         completion:(void (^ __nullable)(void))completion;

/*!
 *  @brief 显示alterController,默认参数
 *
 */
-(void)nb_presentViewWithController:(nullable UIViewController *)viewController;

/*!
 *  @brief 当前的action
 */
@property (nullable, nonatomic, copy, readonly) NSArray<NBAlertAction *> *actions;

/*!
 *  @brief textFields
 */
@property (nullable, nonatomic, readonly) NSArray<UITextField *> *textFields;

/*!
 *  @brief title
 */
@property (nullable, nonatomic, copy) NSString *title;

/*!
 *  @brief message
 */
@property (nullable, nonatomic, copy) NSString *message;

/*!
 *  @brief textField的相关操作block
 */
@property (nullable, nonatomic, copy, readonly) NSArray< void (^)(UITextField *textField)> *textFieldHandlers;

/*!
 *  @brief 展示的style
 */
@property (nonatomic, readonly) NBAlertControllerStyle preferredStyle;

/*!
 *  @brief 当前显示的alter (UIAlertController, UIActionSheet, UIAlterView)
 */
@property (nonnull,nonatomic,strong,readonly) id adaptiveAlert;

@end

NS_ASSUME_NONNULL_END

//
//  NBBaseViewController.h
//  LawMonkey
//
//  Created by 刘彬 on 16/3/20.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,LoginOrRegistType){
    LoginOrRegistType_Login = 0,
    LoginOrRegistType_Regist = 1,
    LoginOrRegistType_FindPassWord = 2,
    LoginOrRegistType_BindPhone = 3,
    LoginOrRegistType_EditPassWord = 4,
};

@interface NBBaseViewController : UIViewController

@property (nonatomic, assign) BOOL hideTabBar;
/**
 *  添加返回按钮
 */
- (void) addBackNavigationBarItem;
/**
 *  添加导航栏标题
 *
 *  @param image 标题
 */
- (void) addNavigationTitle:(NSString *)title;
/**
 *  添加导航栏右侧按钮
 *
 *  @param title 按钮标题
 */
- (void) addRightNavigationItemWithTitle:(NSString *)title;
/**
 *  添加导航栏左侧按钮
 *
 *  @param title 按钮标题
 */
- (void) addLeftNavigationItemWithTitle:(NSString *)title;
@end

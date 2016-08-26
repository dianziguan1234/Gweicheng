//
//  DeviceMacro.h
//  Gwc
//
//  Created by apple on 8/26/16.
//  Copyright © 2016 com.dayangdata.gwc. All rights reserved.
//

#ifndef DeviceMacro_h
#define DeviceMacro_h

#pragma mark - device info
//是否为retina屏幕
#define IS_RETINA             (([[UIScreen mainScreen]scale]>1)?YES:NO)
//判断是否是iOS7.0及以上
#define IS_IOS_7_OR_ABOVE     (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)? (YES):(NO))
//判断是否是iOS8.0及以上
#define IS_IOS_8_OR_ABOVE     (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)? (YES):(NO))
//当前系统版本
#define kCurrentSystemVersion ([[[UIDevice currentDevice] systemVersion] floatValue])
//当前语言
#define kCurrentLanguage      ([[NSLocale preferredLanguages] objectAtIndex:0])
//判断设备类型
#define IS_IPHONE6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPHONE6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPHONE4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#pragma mark - device frame
// 设备屏幕frame
#define kMainScreenFrameRect                           [[UIScreen mainScreen] bounds]
// 状态栏高度
#define kStatusBarHeight                               [[UIApplication sharedApplication] statusBarFrame].size.height
//底部工具栏高度
#define kTabBarHeight                                  (49)
//导航栏高度
#define kNavBarHeight                                  (44)
// 屏幕高
#define kMainScreenHeight                              MAX(kMainScreenFrameRect.size.width, kMainScreenFrameRect.size.height)
// 屏幕宽
#define kMainScreenWidth                               MIN(kMainScreenFrameRect.size.width, kMainScreenFrameRect.size.height)
//减去状态栏和导航栏的高度
#define kScreenHeightNoStatusAndNoNaviBarHeight        (kMainScreenHeight-kStatusBarHeight-kNavBarHeight)
//减去状态栏和底部菜单栏高度
#define kScreenHeightNoStatusAndNoTabBarHeight         (kMainScreenHeight-kStatusBarHeight-kTabBarHeight)
//减去状态栏和底部菜单栏以及导航栏高度
#define kScreenHeightNoStatusAndNoTabBarNoNavBarHeight (kMainScreenHeight-kStatusBarHeight-kTabBarHeight-kNavBarHeight)


#endif /* DeviceMacro_h */

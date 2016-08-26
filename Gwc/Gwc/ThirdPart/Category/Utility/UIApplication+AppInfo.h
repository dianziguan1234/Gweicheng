//
//  UIApplication+AppInfo.h
//  DaSheng
//
//  Created by 刘彬 on 16/3/19.
//  Copyright © 2016年 DaSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (AppInfo)

/**
 *  获取当前app名字
 *
 *  @return app名字
 */
+ (NSString *)appName;

/**
 *  获取当前app名字
 *
 *  @return app名字
 */
+ (NSString *)appLocalizedName;

/**
 *  返回app版本，如：1.0.0
 *
 *  @return app版本
 */
+ (NSString *)appVersion;

/**
 *  返回app辅助版本号，流水号
 *
 *  @return app的流水版本号
 */
+ (NSString *)appBuildNumber;

/**
 *  完整版本号 appVersion (appBuildNumber)
 *
 *  @return 完整版本号
 */
+ (NSString *)appFullVersion;

/**
 *  app的BundleId
 *
 *  @return app的BundleId
 */
+ (NSString *)appBundleId;

/**
 *  设备版本号
 *
 *  @return 设备版本号
 */
+ (NSString *)device;


@end

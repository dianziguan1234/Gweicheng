//
//  LMAppGuideManager.h
//  LawMonkey
//
//  Created by 刘彬 on 16/8/22.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  @brief app引导功能管理器
 */
@interface LMAppGuideManager : NSObject

/*!
 *  @brief  执行app引导功能
 *
 *  @param key              功能kay
 *  @param ignoreVersion    是否忽略版本号
 *  @param shouldGuideBlock 将要执行的引导块
 *  @param didBlock         不需要执行引导块的时候执行的引导块
 */
+ (void)guideWithKey:(NSString *)key ignoreAppVersion:(BOOL)ignoreVersion shouldGuideBlock:(void (^)(void))shouldGuideBlock dontGuideBlock:(void (^)(void))dontGuideBlock;

+ (void)resetWithKey:(NSString *)key;


@end

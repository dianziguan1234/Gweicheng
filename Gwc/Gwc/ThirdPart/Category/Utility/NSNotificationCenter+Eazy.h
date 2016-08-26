//
//  NSNotificationCenter+Eazy.h
//  LawMonkey
//
//  Created by 刘彬 on 16/3/20.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (Eazy)

/**
 *  只注册一次，如果已经注册，则删除后再注册
 *
 *  @param observer  监听者
 *  @param aSelector 回调方法
 *  @param aName     通知名
 *  @param anObject  通知发送者
 */
- (void)nb_addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject;

/**
 *  在defaultCenter注册，如果已经注册，则删除后再注册
 *
 *  @param observer  监听者
 *  @param aSelector 回调方法
 *  @param aName     通知名
 *  @param anObject  通知发送者
 */
+ (void)nb_defaultCenterAddObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject;

/**
 *  在defaultCenter 发送通知
 */
+ (void)nb_defaultCenterPostNotification:(NSNotification *)notification;
+ (void)nb_defaultCenterPostNotificationName:(NSString *)aName object:(id)anObject;
+ (void)nb_defaultCenterPostNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo;

/**
 *  在defaultCenter 移除订阅
 */
+ (void)nb_defaultCenterRemoveObserver:(id)observer;
+ (void)nb_defaultCenterRemoveObserver:(id)observer name:(NSString *)aName object:(id)anObject;


@end

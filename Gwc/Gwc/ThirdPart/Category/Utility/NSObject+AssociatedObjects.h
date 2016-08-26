//
//  NSObject+AssociatedObjects.h
//  NBCategory
//
//  Created by 刘彬 on 16/3/15.
//  Copyright © 2016年 NewBee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

/*!
 *  @brief  给self添加关联对象（可用来扩展属性）
 */
@interface NSObject (AssociatedObjects)

void swizzleMethod(Class className, SEL originalSelector, SEL swizzledSelector);

/*!
 *  @brief  关联策略：strong, nonatomic
 *
 *  @param object 被关联对象
 *  @param key   key
 */
- (void)associateStrongNonatomicObject:(id)object withKey:(const void *)key;
+ (void)associateStrongNonatomicObject:(id)object withKey:(const void *)key;

/*!
 *  @brief  关联策略：strong, atomic
 *
 *  @param object 被关联对象
 *  @param key   key
 */
- (void)associateStrongAtomicObject:(id)object withKey:(const void *)key;
+ (void)associateStrongAtomicObject:(id)object withKey:(const void *)key;

/*!
 *  @brief  关联策略：copy, nonatomic
 *
 *  @param object 被关联对象
 *  @param key   key
 */
- (void)associateCopyNonatomicObject:(id)object withKey:(const void *)key;
+ (void)associateCopyNonatomicObject:(id)object withKey:(const void *)key;

/*!
 *  @brief  关联策略：copy, atomic
 *
 *  @param object 被关联对象
 *  @param key   key
 */
- (void)associateCopyAtomicObject:(id)object withKey:(const void *)key;
+ (void)associateCopyAtomicObject:(id)object withKey:(const void *)key;

/*!
 *  @brief  关联策略：weak
 *
 *  @param object 被关联对象
 *  @param key   key
 */
- (void)associateWeakObject:(id)object withKey:(const void *)key;
+ (void)associateWeakObject:(id)object withKey:(const void *)key;

/*!
 *  @brief  获取关联对象
 *
 *  @param key keu
 *
 *  @return 被关联对象的value
 */
- (id)associatedObjectForKey:(const void *)key;
+ (id)associatedObjectForKey:(const void *)key;

/*!
 *  @brief  移除所有关联对象
 */
- (void)removeAllAssociatedObjects;
+ (void)removeAllAssociatedObjects;

@end

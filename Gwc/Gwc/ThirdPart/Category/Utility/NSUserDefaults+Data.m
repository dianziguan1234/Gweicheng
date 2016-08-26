//
//  NSUserDefaults+Data.m
//  LawMonkey
//
//  Created by jason on 16/4/4.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "NSUserDefaults+Data.h"

@implementation NSUserDefaults (Data)

/**
 * 功能描述: 保存数据
 * 输入参数: object 数据 key 键
 * 返 回 值: N/A
 */
+ (void)saveObject:(id)object forKey:(NSString *)key
{
    NSUserDefaults *defaults = [self standardUserDefaults];
    [defaults setObject:object forKey:key];
    [defaults synchronize];
}

/**
 * 功能描述: 获取数据
 * 输入参数: key 键
 * 返 回 值: value
 */
+ (id)getObjectForKey:(NSString *)key
{
    return [[self standardUserDefaults] objectForKey:key];
}

/**
 * 功能描述: 删除数据
 * 输入参数: key 键
 * 返 回 值: N/A
 */
+ (void)deleteObjectForKey:(NSString *)key
{
    NSUserDefaults *defaults = [self standardUserDefaults];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
}


@end

//
//  NSUserDefaults+Data.h
//  LawMonkey
//
//  Created by jason on 16/4/4.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (Data)
+ (void)saveObject:(id)object forKey:(NSString *)key;
+ (id)getObjectForKey:(NSString *)key;
+ (void)deleteObjectForKey:(NSString *)key;
@end

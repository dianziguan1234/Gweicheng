//
//  NBBaseModel.h
//  LawMonkey
//
//  Created by 刘彬 on 16/3/19.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NBBaseModel : NSObject<NSCoding,NSCopying>

@property(nonatomic,strong) NSError *error;

- (id)initWithJsonString:(NSString*)str;
- (id)initWithDictionary:(NSDictionary*)dict;
- (id)initWithObject:(NSObject *)obj;
- (void)setPropertyWithObject:(NSObject*)object;
- (void)setPropertyWithDictionary:(NSDictionary*)attrMapDic;
- (NSString *)customDescription;
- (NSString *)description;
- (NSData*)getArchivedData;
- (id)convert2object:(NSObject*)obj;
- (NSMutableDictionary *)convert2Dictionary;

@end

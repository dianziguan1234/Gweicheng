//
//  Person.m
//  Gwc
//
//  Created by apple on 9/1/16.
//  Copyright © 2016 com.dayangdata.gwc. All rights reserved.
//

#import "Person.h"

@interface Person ()

@property(nonatomic,assign)int age;
@end

@implementation Person

- (NSString *)description{
    //NSLog(@"%@",name);
    return [NSString stringWithFormat:@"名字是:%@ 年龄是:%d",self.name,_age];
}

- (void)run {
    DYLog(@"%s",__func__);
}
- (instancetype) init {
    self=[super init];
    if (self) {
        self.name = @"guanweicheng";
        _age =20;
    }
    return self;
}
@end

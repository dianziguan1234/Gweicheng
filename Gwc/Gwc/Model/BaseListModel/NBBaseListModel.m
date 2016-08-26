//
//  NBBaseListModel.m
//  LawMonkey
//
//  Created by 刘彬 on 16/4/12.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "NBBaseListModel.h"

@implementation NBBaseListModel

- (id)initWithArray:(NSArray *)array{
    self = [super init];
    if (self) {
        _items = [NSMutableArray arrayWithArray:array];
    }
    return self;
}

- (id)objectAtIndex:(NSUInteger)index {
    if (index < [self.items count]) {
        id object = [self.items objectAtIndex:index];
        return object;
    }
    return nil;
}

- (void)addObject:(id)object{
    [self.items addObject:object];
}

- (void)removeAllObjects{
    [self.items removeAllObjects];
}

#pragma mark - setter/getter
- (NSMutableArray *)items{
    if (_items == nil) {
        self.items = [NSMutableArray array];
    }
    return _items;
}

- (NSInteger)pageSize{
    if (_pageSize <= 0) {
        _pageSize = 10;
    }
    return _pageSize;
}

- (NSInteger)pageNum{
    if (_pageNum <= 0) {
        _pageNum = 1;
    }
    return _pageNum;
}

@end

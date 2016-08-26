//
//  NBBaseViewModel.m
//  LawMonkey
//
//  Created by 刘彬 on 16/3/19.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "NBBaseViewModel.h"

@implementation NBBaseViewModel

#pragma mark - generate data
- (void)loadData {
    
}

- (void)reloadData {
    
}

- (void)constructData {
    
}

- (void)didFinishLoadData:(id)dataModel error:(NSError *)error {
    _isLoading = NO;
    [self constructData];
    if(self.delegate && [self.delegate respondsToSelector:@selector(viewModel:didFinishLoadWithData:error:)]){
        [self.delegate viewModel:self didFinishLoadWithData:dataModel error:error];
    }
}

#pragma mark - setter/getter

- (NSMutableArray *)sections{
    if (_sections == nil) {
        _sections = [NSMutableArray array];
    }
    return _sections;
}

- (BOOL)isLoading {
    return _isLoading;
}

@end

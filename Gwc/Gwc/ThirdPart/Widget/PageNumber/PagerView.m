//
//  PagerView.m
//  LawMonkey
//
//  Created by 刘彬 on 16/3/29.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "PagerView.h"

#define kWidth 8
#define kPadding 5
#define kSelectedAlpha 0.9
#define kUnselectedAlpha 0.3

@implementation PagerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _numberViews = [[NSMutableArray alloc] init];
        self.unselectedColor = [UIColor blackColor];
        self.selectedColor = COLOR_APP_STYLE;
        
        self.unselectedAlpha = kUnselectedAlpha;
        self.selectedAlpha = kSelectedAlpha;
    }
    
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    CGFloat width = self.pageCount * kWidth + (self.pageCount - 1) * kPadding;
    CGFloat x = (self.frame.size.width - width) / 2;
    
    if (_numberViews.count == self.pageCount) {
        for (NSInteger index = 0; index < self.pageCount; index++) {
            UIView *view = [_numberViews objectAtIndex:index];
            view.frame = CGRectMake(x, 0, kWidth, kWidth);
            
            x += (kWidth + kPadding);
        }
    }
}

- (void)setCurrentPageNumber:(NSInteger)currentPageNumber
{
    _currentPageNumber = currentPageNumber;
    
    if (_currentPageNumber < _numberViews.count) {
        for (UIView *subView in self.subviews) {
            subView.alpha = self.unselectedAlpha;
            subView.backgroundColor = self.unselectedColor;
        }
        
        UIView *numberView = [_numberViews objectAtIndex:currentPageNumber];
        numberView.alpha = self.selectedAlpha;
        numberView.backgroundColor = self.selectedColor;
    }
}

- (void)setPageCount:(NSInteger)pageCount
{
    _pageCount = pageCount;
    
    [self clearSubviews];
    
    if (_pageCount <= 1) {
        return;
    }
    
    CGFloat width = pageCount * kWidth + (pageCount - 1) * kPadding;
    CGFloat x = (self.frame.size.width - width) / 2;
    
    for (NSInteger index = 0; index < pageCount; index++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, 0, kWidth, kWidth)];
        [view.layer setCornerRadius:kWidth / 2];
        [view.layer setMasksToBounds:YES];
        view.backgroundColor = self.unselectedColor;
        view.alpha = self.unselectedAlpha;
        [self addSubview:view];
        [_numberViews addObject:view];
        
        x += (kWidth + kPadding);
    }
    
    [self setCurrentPageNumber:_currentPageNumber];
}

- (void)clearSubviews
{
    [_numberViews removeAllObjects];
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
}

@end

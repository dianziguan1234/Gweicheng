//
//  PageControllView.m
//  LawMonkey
//
//  Created by 刘彬 on 16/3/20.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "PageControllView.h"
@interface PageControllView ()<UIScrollViewDelegate, UIGestureRecognizerDelegate>{
    NSInteger _pageCount;
    NSInteger _currentPage;
    
    int _pageWidth;
    CGFloat _preX;
    
    BOOL _respondsDidScrollSelector;
}
@end

@implementation PageControllView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _pageWidth = frame.size.width;
        
        self.contentScrolView = [[UIScrollView alloc]initWithFrame:self.bounds];
        self.contentScrolView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        
        self.contentScrolView.delegate = self;
        [self addSubview:self.contentScrolView];
        
        self.contentScrolView.pagingEnabled = YES;
        self.contentScrolView.showsVerticalScrollIndicator = NO;
        self.contentScrolView.showsHorizontalScrollIndicator = NO;
        self.contentScrolView.bounces = NO;
        self.contentScrolView.alwaysBounceVertical = NO;
        self.contentScrolView.alwaysBounceHorizontal = YES;
        self.contentScrolView.autoresizesSubviews = YES;
    }
    
    return self;
}

- (void)reload
{
    if (self.dataSource == nil) {
        return;
    }
    
    for (UIView *subView in self.contentScrolView.subviews) {
        [subView removeFromSuperview];
    }
    
    NSInteger pageCount = 0;
    
    if ([self.dataSource respondsToSelector:@selector(numberOfViewInPageControllView:)]) {
        pageCount = [self.dataSource numberOfViewInPageControllView:self];
    }
    
    _pageCount = pageCount;
    self.contentScrolView.contentSize = CGSizeMake(_pageWidth * _pageCount, 0);
    [self scrollViewDidScroll:self.contentScrolView];
    [self pageDidScroll:self.contentScrolView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentScrolView.frame = self.bounds;
    CGSize contentSize = self.contentScrolView.contentSize;
    contentSize.height = self.contentScrolView.frame.size.height;
    self.contentScrolView.contentSize = contentSize;
    for (UIView *subView in self.contentScrolView.subviews) {
        CGRect frame = subView.frame;
        frame.size.height = contentSize.height;
        subView.frame = frame;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.dataSource) {
        NSInteger pageIndex;
        if (scrollView.contentOffset.x > _preX) {
            pageIndex = ceilf(scrollView.contentOffset.x / self.frame.size.width);
        } else {
            pageIndex = floor(scrollView.contentOffset.x / self.frame.size.width);
        }
        
        [self loadSubView:pageIndex];
    }

    _preX = scrollView.contentOffset.x;
    
    if (_respondsDidScrollSelector) {//防止每次都去计算
        [self.pageControllViewDelagate pageControllDidScroll:self];
    }
    
}

- (void)loadSubView:(NSInteger)pageIndex
{
    pageIndex = MAX(0, pageIndex);
    pageIndex = MIN(pageIndex, _pageCount - 1);
    
    UIView *view = nil;
    
    if ([self.dataSource respondsToSelector:@selector(pageControllView:viewInPageIndex:)]) {
        view = [self.dataSource pageControllView:self viewInPageIndex:pageIndex];
    }

    if (![self.contentScrolView.subviews containsObject:view]) {
        [self.contentScrolView addSubview:view];
        view.frame = CGRectMake(pageIndex * _pageWidth, 0, _pageWidth, self.frame.size.height);
    }
}

- (void)pageDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidthh = scrollView.frame.size.width;
    
    if (pageWidthh > 0) {
        int page = floor((scrollView.contentOffset.x - pageWidthh / 2) / pageWidthh) + 1;
        
//        if(_currentPage != page){
            [self.pageControllViewDelagate pageControllView:self changedAtPageIndex:page];
            
//        }
        
        _currentPage = page;
    } else {
        _currentPage = 0;
    }
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self pageDidScroll:scrollView];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self pageDidScroll:scrollView];
    }
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    return NO;
}

-(void)selectPage:(NSInteger)index
{
    [self selectPage:index animated:NO];
}

-(void)selectPage:(NSInteger)index animated:(BOOL)animated
{
    [self.contentScrolView setContentOffset:CGPointMake(index*self.frame.size.width, 0) animated:animated];
    
    if (index != _currentPage && !animated) {
        [self pageDidScroll:self.contentScrolView];
    }
}

@synthesize pageControllViewDelagate = _pageControllViewDelagate;
- (void)setPageControllViewDelagate:(id<PageControllViewDelagate>)pageControllViewDelagate {
    _pageControllViewDelagate = pageControllViewDelagate;
    _respondsDidScrollSelector = [self.pageControllViewDelagate respondsToSelector:@selector(pageControllDidScroll:)];
}

- (void)dealloc
{
    self.contentScrolView.delegate = nil;
}

@end

//
//  PageControllView.h
//  LawMonkey
//
//  Created by 刘彬 on 16/3/20.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PageControllView;

@protocol PageControllViewDataSource <NSObject>

- (NSInteger)numberOfViewInPageControllView:(PageControllView *)pageControllView;
- (UIView *)pageControllView:(PageControllView *)pageControllView viewInPageIndex:(NSInteger)pageIndex;

@end

@protocol PageControllViewDelagate <NSObject>

@optional
- (void)pageControllDidScroll:(PageControllView *)pageControll;

@optional
- (void)pageControllView:(PageControllView *)pageControllView changedAtPageIndex:(NSInteger)index;

@end

@interface PageControllView : UIView

@property(nonatomic, retain) UIScrollView *contentScrolView;
@property(nonatomic, weak) id<PageControllViewDelagate> pageControllViewDelagate;
@property (nonatomic, weak) id<PageControllViewDataSource> dataSource;

- (void)selectPage:(NSInteger)index;
- (void)selectPage:(NSInteger)index animated:(BOOL)animated;
- (void)reload;

@end

//
//  CycleScrollView.h
//  LawMonkey
//
//  Created by 刘彬 on 16/3/29.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSTimer+Eazy.h"

@interface CycleScrollView : UIView

@property (nonatomic , readonly) UIScrollView *scrollView;
/**
 *  初始化
 *
 *  @param frame             frame
 *  @param animationDuration 自动滚动的间隔时长。如果<=0，不自动滚动。
 *
 *  @return instance
 */
- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration;

/**
 *  暂停定时 timer 在父亲view dealloc 时调用
 *
 */
- (void)pauseAnimationTimer;

/**
 *  停止定时 timer 在父亲view dealloc 时调用
 *
 */
- (void)stopAnimationTimer;

/**
 数据源：获取总的page个数
 **/
@property (nonatomic , copy) NSInteger (^totalPagesCount)(void);
/**
 数据源：获取第pageIndex个位置的contentView
 **/
@property (nonatomic , copy) UIView *(^fetchContentViewAtIndex)(NSInteger pageIndex);
/**
 当点击的时候，执行的block
 **/
@property (nonatomic , copy) void (^TapActionBlock)(NSInteger pageIndex);

/**
 当点击的时候，执行的block
 **/
@property (nonatomic , copy) void (^changeCurrentIndexBlock)(NSInteger pageIndex);


@end

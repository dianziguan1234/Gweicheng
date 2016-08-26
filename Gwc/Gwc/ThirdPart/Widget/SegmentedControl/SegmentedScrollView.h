//
//  SegementedScrollView.h
//  LawMonkey
//
//  Created by 刘彬 on 16/3/20.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SegmentedControl.h"

@interface SegmentedScrollView : UIView
{
    UIScrollView *_contentScrollView;
    SegmentedControl *_segmentedControl;
}

@property (nonatomic, readonly) SegmentedControl *segmentedControl;

- (id)initWithFrame:(CGRect)frame titles:(NSMutableArray *)titles;
- (void)selectIndex:(NSInteger)index;

@end

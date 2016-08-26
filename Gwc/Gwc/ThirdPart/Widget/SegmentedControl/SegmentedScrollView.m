//
//  SegementedScrollView.m
//  LawMonkey
//
//  Created by 刘彬 on 16/3/20.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "SegmentedScrollView.h"

@implementation SegmentedScrollView

- (id)initWithFrame:(CGRect)frame titles:(NSMutableArray *)titles;
{
    self = [super initWithFrame:frame];
    if (self) {
        _contentScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.showsVerticalScrollIndicator = NO;
        _contentScrollView.scrollsToTop = NO;
        
        _segmentedControl = [[SegmentedControl alloc] initWithTitles:titles];
        _segmentedControl.frame = CGRectMake(0, 0, 560, frame.size.height);
        _segmentedControl.style = SegmentedControlStyleFill;
        [_segmentedControl autoResizeFrame:frame.size.width];
        _contentScrollView.contentSize = _segmentedControl.frame.size;
        [_contentScrollView addSubview:_segmentedControl];
        _contentScrollView.backgroundColor = _segmentedControl.backgroundColor;
        [self addSubview:_contentScrollView];
    }
    
    return self;
}

- (void)selectIndex:(NSInteger)index
{
    _segmentedControl.selectedIndex = index;
 
    NSInteger startIndex = 0;
    NSInteger endIndex = 0;
    
    startIndex = index - 2;
    endIndex = index + 2;
    
    startIndex = MAX(0, startIndex);
    startIndex = MIN(startIndex, _segmentedControl.buttons.count - 1);

    endIndex = MAX(0, endIndex);
    endIndex = MIN(endIndex, _segmentedControl.buttons.count - 1);
    
    if (index < _segmentedControl.buttons.count) {
        UIButton *startButton = [_segmentedControl.buttons objectAtIndex:startIndex];
        UIButton *endButton = [_segmentedControl.buttons objectAtIndex:endIndex];
        
        
        CGRect startFrame = startButton.frame;
        CGRect endFrame = endButton.frame;
        
        if (startIndex != endIndex && endIndex != _segmentedControl.buttons.count - 1 && startIndex != 0) {
            startFrame = CGRectMake(startFrame.origin.x + startFrame.size.width / 2, startFrame.origin.y, startFrame.size.width, startFrame.size.height);
            endFrame = CGRectMake(endFrame.origin.x, endFrame.origin.y, endFrame.size.width / 2, endFrame.size.height);
        }
        
        CGRect visibleRect = CGRectUnion(startFrame, endFrame);
        
        if (_contentScrollView.contentOffset.x > visibleRect.origin.x) {
            [_contentScrollView setContentOffset:CGPointMake(visibleRect.origin.x, 0) animated:YES];
        } else if (_contentScrollView.contentOffset.x + _contentScrollView.frame.size.width < CGRectGetMaxX(visibleRect)) {
            [_contentScrollView setContentOffset:CGPointMake(CGRectGetMaxX(visibleRect) - _contentScrollView.frame.size.width, 0) animated:YES];
        }
    }
}

@end

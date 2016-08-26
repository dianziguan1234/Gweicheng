//
//  SegmentedControl.h
//  LawMonkey
//
//  Created by 刘彬 on 16/3/20.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SegmentedControlStyle) {
    SegmentedControlStyleRound = 0,
    SegmentedControlStyleFill = 1,
    SegmentedControlStyleFillAndFlowRound = 2
};

typedef NS_ENUM(NSInteger, SegmentedControlFlowStyle) {
    SegmentedControlFlowStyleLine = 0,
    SegmentedControlFlowStyleRound = 1,
    SegmentedControlFlowStyleCoustom = 2
};

@interface SegmentedControl : UIControl
{
    UIImageView *_flowView;
    NSMutableArray *_separatorViews;
    UIView *_shadowLine;
    
    CGFloat _marginX;
}

// titles 支持 attributeString 和 普通String
- (id)initWithTitles:(NSArray *)titles;
@property (nonatomic, retain) NSArray *titles;


@property (nonatomic, retain) NSArray *icons;
@property (nonatomic, retain) NSArray *highlightIcons;
@property (nonatomic, retain) UIColor *titleColor;
@property (nonatomic, retain) UIFont *titleFont;
@property (nonatomic, retain) UIFont *selectedTitleFont;
@property (nonatomic, assign) UIEdgeInsets titleInsets;
@property (nonatomic, assign) UIEdgeInsets imageInsets;

@property (nonatomic, retain) UIColor *selectedBackgroundColor;
@property (nonatomic, retain) UIColor *selectedTitleColor;

@property (nonatomic, assign) BOOL selectedFlow;
@property (nonatomic, assign) BOOL autoSelectedFlowWidth;
@property (nonatomic, assign) SegmentedControlFlowStyle flowStyle;
@property (nonatomic, assign) CGFloat flowOffsetY;
// 如果设置flowImage 默认会变成 SegmentedControlStyleCoustom
@property (nonatomic, strong) UIImage *flowImage;


@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) BOOL separatorHidden;
@property (nonatomic, retain) UIColor *separatorColor;

@property (nonatomic, assign) SegmentedControlStyle style;
@property (nonatomic, readonly) NSMutableArray *buttons;
@property (nonatomic, readonly) NSMutableArray *separatorViews;

- (void)setSelectedIndex:(NSInteger)selectedIndex animate:(BOOL)animate;
- (void)selectWithIndex:(NSInteger)index;
- (NSString *)getSelectedTitle;
- (void)autoResizeFrame:(CGFloat)minWidth;

@end

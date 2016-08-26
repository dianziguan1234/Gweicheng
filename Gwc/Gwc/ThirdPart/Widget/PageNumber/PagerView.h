//
//  PagerView.h
//  LawMonkey
//
//  Created by 刘彬 on 16/3/29.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PagerView : UIView{
    NSMutableArray *_numberViews;
}

@property (nonatomic, assign) NSInteger currentPageNumber;
@property (nonatomic, assign) NSInteger pageCount;
@property (nonatomic, strong) UIColor *unselectedColor;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, assign) CGFloat unselectedAlpha;
@property (nonatomic, assign) CGFloat selectedAlpha;


@end

//
//  BasePickerView.h
//  LawMonkey
//
//  Created by 刘彬 on 16/3/26.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasePickerView : UIActionSheet
{
    UIView *_backgroundView;
}

@property (nonatomic, readonly) BOOL isAppeared;
@property (nonatomic, strong) UILabel *textLabel;

- (void)cancle:(id)sender;
- (void)ok:(id)sender;

- (void)showInView:(UIView *)view;
- (void)dismiss;

@end

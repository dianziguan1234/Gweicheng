//
//  BasePickerView.m
//  LawMonkey
//
//  Created by 刘彬 on 16/3/26.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "BasePickerView.h"
#define kDuration 0.3
#define kButtonWidth 70.0f
@implementation BasePickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)init
{
    self = [super initWithFrame:CGRectMake(0.0f, 0.0f, kMainScreenWidth, 260)];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kMainScreenWidth, 44.0f)];
        headerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:headerView];

        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 43, kMainScreenWidth, 1)];
        line.backgroundColor = COLOR_TABLE_LINE;
        [headerView addSubview:line];
        
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(kButtonWidth, 0.0f, kMainScreenWidth - 2 * kButtonWidth, 44.0f)];
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        self.textLabel.textColor = COLOR_NORMAL_TEXT;
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        [headerView addSubview:self.textLabel];
        
        UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kButtonWidth, 44.0f)];
        [leftButton setTitle:@"取消" forState:UIControlStateNormal];
        [leftButton setTitleColor:COLOR_NORMAL_TEXT forState:UIControlStateNormal];
        [leftButton setTitleColor:COLOR_NORMAL_SUBINFO_TEXT forState:UIControlStateHighlighted];
        leftButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [leftButton addTarget:self action:@selector(cancle:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:leftButton];

        UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth - kButtonWidth, 0.0f, kButtonWidth, 44.0f)];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [rightButton setTitleColor:COLOR_APP_STYLE forState:UIControlStateNormal];
        [rightButton setTitleColor:COLOR_APP_STYLE forState:UIControlStateHighlighted];
        [rightButton setTitle:@"确定" forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(ok:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:rightButton];
        
        _backgroundView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = 0.4f;
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancle:)];
        [_backgroundView addGestureRecognizer:tapGestureRecognizer];
    }
    
    return self;
}

- (void)showInView:(UIView *) view
{
    if (self.superview != nil) {
        return;
    }
//    UIView *window = [[UIApplication sharedApplication] keyWindow];
    
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromTop;
    [self setAlpha:1.0f];
    [self.layer addAnimation:animation forKey:@"DDLocateView"];
    
    self.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    [view addSubview:_backgroundView];
    [view addSubview:self];
}

- (void)dismiss
{
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    [self setAlpha:0.0f];
    [self.layer addAnimation:animation forKey:@"TSLocateView"];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:kDuration];
    [_backgroundView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:kDuration];
}

- (BOOL)isAppeared
{
    return self.superview != nil;
}

- (void)cancle:(id)sender
{
    [self dismiss];
    if(self.delegate && [self.delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
        [self.delegate actionSheet:self clickedButtonAtIndex:0];
    }
}

- (void)ok:(id)sender
{
    [self dismiss];
    if(self.delegate && [self.delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
        [self.delegate actionSheet:self clickedButtonAtIndex:1];
    }
}

@end

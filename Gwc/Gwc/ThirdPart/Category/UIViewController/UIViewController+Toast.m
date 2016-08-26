//
//  UIViewController+Toast.m
//  LawMonkey
//
//  Created by 刘彬 on 16/3/20.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "UIViewController+Toast.h"
#import "UIView+Toast.h"
#import "UIImage+animatedGIF.h"
#import <SVProgressHUD.h>

@implementation UIViewController (Toast)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzleMethod([self class], @selector(viewDidAppear:), @selector(swizzle_viewDidAppear:));
        swizzleMethod([self class], @selector(viewDidDisappear:), @selector(swizzle_viewDidDisappear:));
    });
}

#pragma mark - Method Swizzling

- (void)swizzle_viewDidAppear:(BOOL)animated {
    [self swizzle_viewDidAppear:animated];
//    if (![self.indicatorView isAnimating]) {
//        [self.indicatorView startAnimating];
//    }
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
}
- (void)swizzle_viewDidDisappear:(BOOL)animated {
    [self swizzle_viewDidDisappear:animated];
//    if ([self.indicatorView isAnimating]) {
//        [self.indicatorView stopAnimating];
//    }
}

/**
 *  显示等待icon
 */
- (void)showIndicatorView {
    [SVProgressHUD show];
}

- (void)showIndicatorViewWithMessage:(NSString *)message{
    [SVProgressHUD showWithStatus:message];
}

/**
 *  隐藏等待icon
 */
- (void)hideIndicatorView {
    [SVProgressHUD dismiss];
}

- (void)hideIndicatorViewAfterDelay:(NSTimeInterval)delay{
    [SVProgressHUD dismissWithDelay:delay];
}

/*!
 *  @brief  显示一个普通提示框
 *
 *  @param message 提示信息
 */
- (void)toast:(NSString *)message {
    [SVProgressHUD showInfoWithStatus:message];
//    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//    [window makeToast:message duration:2.0 position:CSToastPositionCenter];
    
}

/*!
 *  @brief  显示一个错误提示框
 *
 *  @param error 错误信息
 */
- (void)toastWithError:(NSError *)error {
    if (error.localizedDescription.length > 0) {
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        return;
    }
    [SVProgressHUD showErrorWithStatus:@"啊哦~出错啦!"];
}

/*!
 *  @brief 显示一个错误提示框
 *
 *  @param message 错误信息
 */
- (void)toastWithErrorMessage:(NSString *)message{
    [SVProgressHUD showErrorWithStatus:message];
}

/*!
 *  @brief 显示一个成功提示框
 *
 *  @param message 提示信息
 */
- (void)toastWithSuccess:(NSString *)message{
    [SVProgressHUD showSuccessWithStatus:message];
}

/*!
 *  @brief  显示空数据界面
 */
- (void)showEmptyPlaceholder {
    [self showPlaceholderWithIcon:[UIImage imageNamed:@"icon_empty"] message:@"空空如也~" actionButton:@"再试试" action:@selector(placeholderButtonAction) inView:self.view insets:UIEdgeInsetsZero];
}

/*!
 *  @brief 显示空数据界面
 *
 *  @param icon    icon
 *  @param message 提示信息
 */
- (void)showEmptyPlaceholderWithIcon:(UIImage *)icon message:(NSString *)message {
    [self showPlaceholderWithIcon:icon message:message actionButton:nil action:nil inView:self.view insets:UIEdgeInsetsZero];
}

/*!
 *  @brief  显示异常界面
 *
 *  @param error 错误信息
 */
- (void)showErrorPlaceholderWithError:(NSError *)error {
    [self showPlaceholderWithIcon:[UIImage imageNamed:@"icon_nonetwork"] message:error.localizedDescription actionButton:@"再试试" action:@selector(placeholderButtonAction) inView:self.view insets:UIEdgeInsetsZero];
}

/*！
 *  @brief 显示placeholder view
 *
 *  @param icon    一个icon，文字icon一起 居中显示 ，可以为空
 *  @param message 提示文案，可以为空，可以多行
 *  @param buttonTitle 刷新按钮 按钮响应-(void)placeholderRefreshButtonAction
 *  @param supview 此viewshow在什么view上，传入nil表示控制的view上
 *
 *  @return 返回显示的placeView
 */
- (UIView *)showPlaceholderWithIcon:(UIImage *)icon
                            message:(NSString *)message
                       actionButton:(NSString *)buttonTitle
                             action:(SEL)action
                             inView:(UIView *)superview
                             insets:(UIEdgeInsets)insets {
    superview = nil == superview ? self.view : superview;
    // 重置placeholder的frame
    [self placeholderWithSuperView:superview insets:insets];
    //处理icon
    if (self.iconImageView == nil) {
        self.iconImageView = [UIImageView nb_imageViewWithImage:icon];
        [self.placeholderView addSubview:self.iconImageView];
    }
    self.iconImageView.size = icon.size;
    self.iconImageView.image = icon;
    
    //处理message
    if (self.messageLabel == nil) {
        self.messageLabel = [UILabel nb_labelWithWidthMin:0
                                                      max:(self.placeholderView.width - 2*kNormalPadding)
                                                     font:Normal_Font
                                                    color:COLOR_NORMAL_SUBINFO_TEXT
                                                backgroud:COLOR_SYSTEM_CLEAR
                                                alignment:NSTextAlignmentCenter
                                                multiLine:YES];
        [self.placeholderView addSubview:self.messageLabel];
    }
    self.messageLabel.text = message;
    [self.messageLabel nb_sizeToFit];
    
    // 按钮
    if (self.actionBtn == nil) {
        if (buttonTitle.length > 0 && [self respondsToSelector:action]) {
            UIImage *normalImage = [UIImage nb_imageWithColor:[UIColor whiteColor] border:1 color:HEX_COLOR(0xececec) cornerRadius:44];
            UIImage *selectedImage = [UIImage nb_imageWithColor:COLOR_APP_STYLE border:1 color:HEX_COLOR(0xececec) cornerRadius:44];
            self.actionBtn = [UIButton nb_buttonWithSize:CGSizeMake(220, 44)
                                                    font:Normal_Font
                                                   color:COLOR_APP_STYLE
                                                selected:[UIColor whiteColor]
                                                disabled:nil
                                               backgroud:[normalImage nb_centerStretchImage]
                                                selected:[selectedImage nb_centerStretchImage]
                                                disabled:nil];
            
            if (action) {
                [self.actionBtn nb_addTarget:self touchAction:action];
            } else {
                [self.actionBtn nb_addTarget:self touchAction:@selector(placeholderButtonAction)];
            }
            [self.placeholderView addSubview:self.actionBtn];
        }
    }
    self.actionBtn.nb_normalTitle = buttonTitle;
    // 刷新布局
    lmweak(ws);
    [self.iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.messageLabel);
        make.bottom.equalTo(ws.messageLabel.mas_top).offset(-kNormalPadding);
    }];
    [self.messageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.placeholderView);
        make.centerY.equalTo(ws.placeholderView);
    }];
    [self.actionBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.messageLabel);
        make.top.equalTo(ws.messageLabel.mas_bottom).offset(kNormalPadding);
        make.width.mas_equalTo(220);
    }];
    
    return self.placeholderView;
}

/*!
 *  @brief  重置placeholder的frame
 *
 *  @param superview <#superview description#>
 *  @param insets    <#insets description#>
 */
- (void)placeholderWithSuperView:(UIView *)superview insets:(UIEdgeInsets)insets {
    CGRect supviewbounds = superview.bounds;
    CGRect frame = CGRectMake(supviewbounds.origin.x + insets.left,
                              supviewbounds.origin.y + insets.top,
                              supviewbounds.size.width - insets.left - insets.right,
                              supviewbounds.size.height - insets.top - insets.bottom);
    UIView *placeholderView = [[UIView alloc] initWithFrame:frame];
    placeholderView.backgroundColor = COLOR_TABLE_BACKGROUND_GRAY;
    placeholderView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [placeholderView nb_addTapGestureWithTarget:self action:@selector(placeholderViewHandler)];
    [superview addSubview:placeholderView];
    self.placeholderView = placeholderView;
}

/*!
 *  @brief  view点击事件，可重载
 */
- (void)placeholderViewHandler{
    
}

/*!
 *  @brief  按钮点击事件，可重载
 */
- (void)placeholderButtonAction{
    [self removePlaceholder];
}

- (void)removePlaceholder {
    if (self.placeholderView) {
        [self.placeholderView removeFromSuperview];
        self.iconImageView = nil;
        self.messageLabel = nil;
        self.actionBtn = nil;
    }
}

#pragma mark - getter & setter
- (void)setIndicatorView:(IndicatorView *)indicatorView {
    [self associateStrongNonatomicObject:indicatorView withKey:@"indicatorView"];
}
- (IndicatorView *)indicatorView {
    return [self associatedObjectForKey:@"indicatorView"];
}

- (void)setLoadingView:(GifLoadingView *)loadingView {
    [self associateStrongNonatomicObject:loadingView withKey:@"loadingView"];
}
- (GifLoadingView *)loadingView {
    return [self associatedObjectForKey:@"loadingView"];
}

- (void)setAnimationTime:(NSInteger)animationTime{
    [self associateWeakObject:@(animationTime) withKey:@"animationTime"];
}
- (NSInteger)animationTime{
    return [[self associatedObjectForKey:@"animationTime"] integerValue];
}

- (void)setPlaceholderView:(UIView *)placeholderView {
    [self associateStrongNonatomicObject:placeholderView withKey:@"placeholderView"];
}
- (UIView *)placeholderView {
    return [self associatedObjectForKey:@"placeholderView"];
}

- (void)setIconImageView:(UIImageView *)iconImageView {
    [self associateStrongNonatomicObject:iconImageView withKey:@"iconImageView"];
}
- (UIImageView *)iconImageView {
    return [self associatedObjectForKey:@"iconImageView"];
}

- (void)setMessageLabel:(UILabel *)messageLabel{
    [self associateStrongNonatomicObject:messageLabel withKey:@"messageLabel"];
}
- (UILabel *)messageLabel{
    return [self associatedObjectForKey:@"messageLabel"];
}

- (void)setActionBtn:(UIButton *)actionBtn{
    [self associateStrongNonatomicObject:actionBtn withKey:@"actionBtn"];
}
- (UIButton *)actionBtn{
    return [self associatedObjectForKey:@"actionBtn"];
}

@end

/*!
 *  @brief  带gif的等待view
 */
@interface GifLoadingView ()

@property (nonatomic, strong) UIImageView *gifImageView;

@end

@implementation GifLoadingView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.gifImageView];
    }
    return self;
}

#pragma mark - getter
- (UIImageView *)gifImageView{
    if (_gifImageView == nil) {
        _gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 86, 86)];
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"loading" withExtension:@"gif"];
        _gifImageView.image = [UIImage animatedImageWithAnimatedGIFURL:url];
    }
    return _gifImageView;
}

@end


/*!
 *  @brief  等待iconview
 */
@interface IndicatorView ()

@property (nonatomic, assign) BOOL isAnimating;
@property (nonatomic, strong) UIView *waitView;
@property (nonatomic, assign) CGFloat angle;

@end

@implementation IndicatorView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.waitView];
    }
    return self;
}

- (void)startAnimating{
    [self setHidden:NO];
    self.isAnimating = YES;
    [self runSpinAnimationOnView:self.waitView duration:1 rotations:1 repeat:10000];
}

- (void)stopAnimating{
    [self setHidden:YES];
    self.isAnimating = NO;
    [self.waitView.layer removeAllAnimations];
}

- (BOOL)isAnimating{
    return _isAnimating;
}

- (void)runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat;{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 * rotations * duration ];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = repeat;
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

# pragma mark - getter & setter
- (UIView *)waitView {
    if (_waitView == nil) {
        _waitView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 25.0f, 25.0f)];
        [_waitView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_waiting"]]];
    }
    return _waitView;
}

@end



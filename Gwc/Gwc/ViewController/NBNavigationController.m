//
//  NBNavigationController.m
//  LawMonkey
//
//  Created by 刘彬 on 16/3/19.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "NBNavigationController.h"

@interface NBNavigationController () {
    BOOL _isPushingViewController;
}

@end

@implementation NBNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.enableGestureRecognizer = YES;
    [self setNavigationStyle];
    self.interactivePopGestureRecognizer.enabled = YES;
    // interactivePopGestureRecognizer设置
    __weak NBNavigationController *weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate = weakSelf;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    self.enableGestureRecognizer = YES;
}

- (void)setNavigationStyle{
    UIColor *color = [UIColor whiteColor];
    if (self.navigationBarColor) {
        color = self.navigationBarColor;
    }
    
    [self.navigationBar setTranslucent:NO];
    
    UIImage *image = [UIImage nb_imageWithColor:color size:CGSizeMake(1, kStatusBarHeight)];
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    if (self.showBarLine) {
        self.navigationBar.shadowImage = [UIImage nb_imageWithColor:COLOR_TABLE_LINE];
    }
    else {
        self.navigationBar.shadowImage = [UIImage nb_imageWithColor:COLOR_SYSTEM_CLEAR];
    }
    
}

- (void)setNavigationBarColor:(UIColor *)navigationBarColor {
    _navigationBarColor = navigationBarColor;
    if (navigationBarColor) {
        UIImage *image = [UIImage nb_imageWithColor:navigationBarColor size:CGSizeMake(1, kStatusBarHeight)];
        [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)setShowBarLine:(BOOL)showBarLine {
    if (showBarLine) {
        self.navigationBar.shadowImage = [UIImage nb_imageWithColor:COLOR_TABLE_LINE];
    } else {
        self.navigationBar.shadowImage = [UIImage nb_imageWithColor:COLOR_SYSTEM_CLEAR];
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated

{
    if (_isPushingViewController && animated) {
        return;
    }
    if (animated) {
        [self setPushing];
    }
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]&&animated==YES) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated

{
    if (_isPushingViewController && animated) {
        return nil;
    }
    
    if (animated) {
        [self setPushing];
    }
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]&&animated==YES) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    return  [super popToRootViewControllerAnimated:animated];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated

{
    if (_isPushingViewController && animated) {
        return nil;
    }
    
    if (animated) {
        [self setPushing];
    }
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    return [super popToViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    if (_isPushingViewController && animated) {
        return nil;
    }
    
    if (animated) {
        [self setPushing];
    }
    
    return [super popViewControllerAnimated:animated];
}

#pragma mark UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    
    _isPushingViewController = NO;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]){
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)setPushing
{
    _isPushingViewController = YES;
    [self performSelector:@selector(updatePushing) withObject:nil afterDelay:1];
}

- (void)updatePushing
{
    _isPushingViewController = NO;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        if (self.viewControllers.count < 2 || self.visibleViewController == [self.viewControllers objectAtIndex:0]) {
            return NO;
        }
    }
    return self.enableGestureRecognizer;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return  NO;
}


@end

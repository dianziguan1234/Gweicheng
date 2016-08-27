//
//  NBBaseViewController.m
//  LawMonkey
//
//  Created by 刘彬 on 16/3/20.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "NBBaseViewController.h"
#import "NBNavigationController.h"
#import <RDVTabBarController/RDVTabBarController.h>

@interface NBBaseViewController ()<UINavigationControllerDelegate>

@end

@implementation NBBaseViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_TABLE_BACKGROUND_GRAY;
    [self setNavBackButton]; // 默认显示返回按钮
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 默认都显示导航栏，若vc需要隐藏到导航栏，则重载viewWillAppear方法
    if ([self.navigationController isNavigationBarHidden]) {
        [self.navigationController setNavigationBarHidden:NO animated:animated];
    }
    [(NBNavigationController *)self.navigationController setShowBarLine:NO];
    [(NBNavigationController *)self.navigationController setEnableGestureRecognizer:YES];
    // 隐藏tabbar
    if (self.navigationController.viewControllers.count > 1) {
        [[self rdv_tabBarController] setTabBarHidden:YES animated:NO];
    }
    // 解决导航栏切换的问题(先注释掉)
    //self.navigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    // 显示tabbar
    if (self.navigationController.viewControllers.count <= 1) {
        [[self rdv_tabBarController] setTabBarHidden:NO animated:NO];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)dealloc{
    //移除所有通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)back {
    if (self.navigationController.viewControllers.count > 1 && [self.navigationController respondsToSelector:@selector(popViewControllerAnimated:)]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if([self.tabBarController.navigationController respondsToSelector:@selector(popViewControllerAnimated:)]){
        [self.tabBarController.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}


- (void)setHideTabBar:(BOOL)hideTabBar{
    [[self rdv_tabBarController] setTabBarHidden:hideTabBar animated:NO];
}

#pragma mark - Private Methods
#pragma mark Whether need Navigation Bar Hidden
- (BOOL) needHiddenBarInViewController:(UIViewController *)viewController {
    
    BOOL needHideNaivgaionBar = NO;
    /*
     if ([viewController isKindOfClass: [MLMineViewController class]] ||
     [viewController isKindOfClass: [MLUserHomePageViewController class]] ||
     [viewController isKindOfClass: [MLLoginViewController class]]) {
     needHideNaivgaionBar = YES;
     }
     */
    
    return needHideNaivgaionBar;
}

#pragma mark - UINaivgationController Delegate
#pragma mark Will Show ViewController
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [self.navigationController setNavigationBarHidden: [self needHiddenBarInViewController: viewController]
                                             animated: animated];
}

@end

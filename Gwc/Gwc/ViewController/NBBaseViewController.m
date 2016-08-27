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

#pragma mark 添加返回按钮
- (void) addBackNavigationBarItem {
    
    UIButton *button = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 44, 44)];
    [button setImage: [UIImage imageNamed: @"nav_icon_back_normal"] forState: UIControlStateNormal];
    [button addTarget: self action: @selector(popAction:) forControlEvents: UIControlEventTouchUpInside];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 3, 5);
    UIBarButtonItem *placeHolderItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFixedSpace target: nil action: nil];
    placeHolderItem.width = -15;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView: button];
    self.navigationItem.leftBarButtonItems = @[placeHolderItem, backItem];
}

#pragma mark Pop Action
- (void) popAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: YES];
}

#pragma mark 添加导航栏标题
- (void) addNavigationTitle:(NSString *)title {
    
    //    1. 计算 Label 宽度
    CGFloat labelWidth = [title boundingRectWithSize:CGSizeMake(200, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20]} context:nil].size.width;
    
    //    2. 创建 TitleLabel
    UILabel *titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, labelWidth, 44)];
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    //    3. 设置导航栏的 TitleView
    self.navigationItem.titleView = titleLabel;
}

#pragma makr 添加导航栏右侧按钮
- (void) addRightNavigationItemWithTitle:(NSString *)title {
    
    UIButton *button = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 44, 44)];
    [button setTitle: title forState: UIControlStateNormal];
    [button setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button addTarget: self action: @selector(rightNavigationItemAction:) forControlEvents: UIControlEventTouchUpInside];
    CGFloat titleWidth = [title boundingRectWithSize: CGSizeMake(100, 100) options: NSStringDrawingUsesLineFragmentOrigin attributes: @{NSFontAttributeName : button.titleLabel.font} context: nil].size.width;
    CGFloat edgeInsetRight = 44 - titleWidth;
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -edgeInsetRight);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: button];
}

#pragma mark - Actions
#pragma mark -
#pragma mark Right Bar Button Item Click Action
- (void) rightNavigationItemAction:(UIButton *)sender {
    NSLog(@"%s", __FUNCTION__);
}

#pragma makr 添加导航栏左侧文字按钮
- (void) addLeftNavigationItemWithTitle:(NSString *)title {
    
    UIButton *button = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 44, 44)];
    [button setTitle: title forState: UIControlStateNormal];
    [button setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button addTarget: self action: @selector(leftNavigationItemAction:) forControlEvents: UIControlEventTouchUpInside];
    CGFloat titleWidth = [title boundingRectWithSize: CGSizeMake(100, 100) options: NSStringDrawingUsesLineFragmentOrigin attributes: @{NSFontAttributeName : button.titleLabel.font} context: nil].size.width;
    CGFloat edgeInsetRight = 44 - titleWidth;
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -edgeInsetRight);
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: button];
}

#pragma mark - Actions
#pragma mark -
#pragma mark Left Bar Button Item Click Action
- (void) leftNavigationItemAction:(UIButton *)sender {
    NSLog(@"%s", __FUNCTION__);
}
@end

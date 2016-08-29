//
//  UIViewController+NavigationBar.m
//  LawMonkey
//
//  Created by 刘彬 on 16/3/20.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "UIViewController+NavigationBar.h"

@implementation UIViewController (NavigationBar)

#pragma mark - set title

- (void)setNavTitle:(NSString *)title{
    [self setNavTitle:title color:COLOR_NAVIGATIONBAR_TITLE font:NavigationBar_Title_Font];
}

- (void)setNavTitle:(NSString *)title color:(UIColor *)color{
    [self setNavTitle:title color:color font:NavigationBar_Title_Font];
}

- (void)setNavTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font {
    if ([NSString nb_isEmpty:title]) {
        return;
    }
    color                                = (color == nil ? COLOR_NAVIGATIONBAR_TITLE : color);
    font                                 = (font == nil ? NavigationBar_Title_Font : font);
    UILabel *titleLabel                  = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    titleLabel.text                      = title;
    titleLabel.textColor                 = color;
    titleLabel.font                      = font;
    self.currentNavigationItem.titleView = titleLabel;
}

- (void)setNavTitleWithView:(UIView *)view {
    self.currentNavigationItem.titleView = view;
}

- (void)setNavTitleWithImage:(NSString *)imageName {
    UIImageView *imageView = [[UIImageView  alloc] initWithImage:[UIImage imageNamed:imageName]];
    self.currentNavigationItem.titleView = imageView;
}

#pragma mark - set barbutton
/*!
 *  @brief  清除左边按钮
 */
- (void)clearLeftButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 15, 44);
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.currentNavigationItem.backBarButtonItem = barButton;
    self.currentNavigationItem.leftBarButtonItem = barButton;
}

/*!
 *  @brief  清除右边按钮
 */
- (void)clearRightButton {
    self.currentNavigationItem.rightBarButtonItem = nil;
}

/*!
 *  @brief  设置返回按钮
 */
- (void)setNavBackButton {
    UIButton *backBtn                            = [UIButton nb_buttonWithSize:CGSizeMake(50, 30) font:NavigationBar_Button_Font color:COLOR_NAVIGATIONBAR_BUTTON selected:COLOR_NAVIGATIONBAR_BUTTON disabled:COLOR_DISABLE_TEXT backgroud:nil selected:nil disabled:nil];
    backBtn.nb_x                                 = 0;
    backBtn.nb_y                                 = 7;
    backBtn.nb_normalImage                       = [UIImage imageNamed:@"btn_nav_back"];
    backBtn.nb_selectedImage                     = [UIImage imageNamed:@"btn_nav_back"];
    backBtn.nb_hitEdgeOutsets                    = UIEdgeInsetsMake(5, 5, 5, 5);// 扩大一下点击范围
    backBtn.contentHorizontalAlignment           = UIControlContentHorizontalAlignmentLeft;
    [backBtn nb_addTarget:self touchAction:@selector(back)];
    
    UIBarButtonItem *backItem                    = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.currentNavigationItem.leftBarButtonItem = backItem;
}

/*!
 *  @brief  设置左边按钮
 *
 *  @param imageName 按钮图片
 *  @param text      按钮文字
 *  @param color     按钮文字颜色
 *  @param action    按钮响应SEL
 *
 *  @return 按钮
 */
- (UIButton *)setNavLeftButtonWithImageName:(NSString *)imageName action:(SEL)action {
    UIBarButtonItem *barItem = [self generateBarButtonItemWithContentAlignment:UIControlContentHorizontalAlignmentLeft imageName:imageName target:self action:action];
    self.currentNavigationItem.leftBarButtonItem = barItem;
    return (UIButton *)barItem.customView;
}
- (UIButton *)setNavLeftButtonWithText:(NSString *)text action:(SEL)action {
    UIBarButtonItem *barItem = [self generateBarButtonItemWithContentAlignment:UIControlContentHorizontalAlignmentLeft title:text titleColor:nil target:self action:action];
    self.currentNavigationItem.leftBarButtonItem = barItem;
    return (UIButton *)barItem.customView;
}
- (UIButton *)setNavLeftButtonWithText:(NSString *)text textColor:(UIColor *)color action:(SEL)action {
    UIBarButtonItem *barItem = [self generateBarButtonItemWithContentAlignment:UIControlContentHorizontalAlignmentLeft title:text titleColor:color target:self action:action];
    self.currentNavigationItem.leftBarButtonItem = barItem;
    return (UIButton *)barItem.customView;
}

/*!
 *  @brief  设置右边按钮
 *
 *  @param imageName 按钮图片
 *  @param text      按钮文字
 *  @param color     按钮文字颜色
 *  @param action    按钮响应SEL
 *
 *  @return 按钮
 */
- (UIButton *)setNavRightButtonWithImageName:(NSString *)imageName action:(SEL)action {
    UIBarButtonItem *barItem = [self generateBarButtonItemWithContentAlignment:UIControlContentHorizontalAlignmentRight imageName:imageName target:self action:action];
    self.currentNavigationItem.rightBarButtonItem = barItem;
    return (UIButton *)barItem.customView;
}
- (UIButton *)setNavRightButtonWithText:(NSString *)text action:(SEL)action {
    UIBarButtonItem *barItem = [self generateBarButtonItemWithContentAlignment:UIControlContentHorizontalAlignmentRight title:text titleColor:nil target:self action:action];
    self.currentNavigationItem.rightBarButtonItem = barItem;
    return (UIButton *)barItem.customView;
}
- (UIButton *)setNavRightButtonWithText:(NSString *)text textColor:(UIColor *)color action:(SEL)action {
    UIBarButtonItem *barItem = [self generateBarButtonItemWithContentAlignment:UIControlContentHorizontalAlignmentRight title:text titleColor:color target:self action:action];
    self.currentNavigationItem.rightBarButtonItem = barItem;
    return (UIButton *)barItem.customView;
}

# pragma mark - UIControl Responder
- (void)back {
    if (self.navigationController.viewControllers.count > 1 && [self.navigationController respondsToSelector:@selector(popViewControllerAnimated:)]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if([self.tabBarController.navigationController respondsToSelector:@selector(popViewControllerAnimated:)]){
        [self.tabBarController.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

# pragma mark - pricate method  暂时不对外开放
/*!
 *  @brief  生成导航图片按钮
 *
 *  @param alignment  对齐方式
 *  @param imageName  图片名字
 *  @param target     事件响应者
 *  @param action     点击响应SEL
 *
 *  @return UIBarButtonItem
 */
- (UIBarButtonItem *)generateBarButtonItemWithContentAlignment:(UIControlContentHorizontalAlignment)alignment imageName:(NSString *)imageName target:(id)target action:(SEL)action {
    if ([NSString nb_isEmpty:imageName]) {
        return nil;
    }
    UIImage *image                    = [UIImage imageNamed:imageName];
    CGRect frame                      = CGRectMake(0, 0, image.size.width + 10, image.size.height + 10);
    
    UIButton *barBtn                  = [UIButton nb_buttonWithSize:frame.size font:NavigationBar_Button_Font color:COLOR_NAVIGATIONBAR_BUTTON selected:COLOR_NAVIGATIONBAR_BUTTON disabled:COLOR_DISABLE_TEXT backgroud:nil selected:nil disabled:nil];
    barBtn.nb_origin                  = frame.origin;
    barBtn.nb_normalImage             = image;
    barBtn.nb_selectedImage           = image;
    barBtn.nb_hitEdgeOutsets          = UIEdgeInsetsMake(5, 5, 5, 5);// 扩大一下点击范围
    barBtn.contentHorizontalAlignment = alignment;
    barBtn.imageEdgeInsets            = UIEdgeInsetsMake(0, 0, 0, 0);
    barBtn.exclusiveTouch             = YES;
    [barBtn nb_addTarget:self touchAction:action];
    
    UIBarButtonItem *barButtonItem    = [[UIBarButtonItem alloc] initWithCustomView:barBtn];
    
    return barButtonItem;
}

/*!
 *  @brief  生成导航文字按钮
 *
 *  @param alignment  对齐方式
 *  @param title      标题
 *  @param titleColor 标题颜色
 *  @param target     事件响应者
 *  @param action     点击响应SEL
 *
 *  @return UIBarButtonItem
 */
- (UIBarButtonItem *)generateBarButtonItemWithContentAlignment:(UIControlContentHorizontalAlignment)alignment title:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action {
    if ([NSString nb_isEmpty:title]) {
        return nil;
    }
    titleColor                        = titleColor == nil ? COLOR_NAVIGATIONBAR_BUTTON : titleColor;
    CGRect frame                      = CGRectMake(0, 0, 60, 30);
    
    UIButton *barBtn                  = [UIButton nb_buttonWithSize:frame.size font:NavigationBar_Button_Font color:titleColor selected:titleColor disabled:COLOR_DISABLE_TEXT backgroud:nil selected:nil disabled:nil];
    barBtn.nb_origin                  = frame.origin;
    barBtn.nb_normalTitle             = title;
    barBtn.nb_hitEdgeOutsets          = UIEdgeInsetsMake(5, 5, 5, 5);// 扩大一下点击范围
    barBtn.contentHorizontalAlignment = alignment;
    barBtn.imageEdgeInsets            = UIEdgeInsetsMake(0, 0, 0, 0);
    barBtn.exclusiveTouch             = YES;
    [barBtn nb_addTarget:self touchAction:action];
    
    UIBarButtonItem *barButtonItem    = [[UIBarButtonItem alloc] initWithCustomView:barBtn];
    
    return barButtonItem;
}

- (UINavigationItem *)currentNavigationItem {
    if (self.parentViewController != nil && ![self.parentViewController isKindOfClass:[UINavigationController class]]) {
        return self.parentViewController.navigationItem;
    } else {
        return self.navigationItem;
    }
}

- (void)setImagePickerNavigationBarStyle:(UIImagePickerController*)picker{
    //改变按钮颜色
    picker.navigationBar.tintColor = COLOR_SYSTEM_WHITE;
    //改变背景色
    double version = [[UIDevice currentDevice].systemVersion doubleValue];
    CGFloat height;
    if(version < 7.0f) {
        height = 44.0f;
    } else {
        height = 64.0f;
    }
    UIImage *image = [UIImage nb_imageWithColor:COLOR_NAVIVATIONBAR size:CGSizeMake(1, height)];
    [picker.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

#pragma mark 添加返回按钮
- (void) addBackNavigationBarItem {
    
    UIButton *button = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 44, 44)];
    [button setImage: [UIImage imageNamed: @"btn_nav_back"] forState: UIControlStateNormal];
    [button addTarget: self action: @selector(back) forControlEvents: UIControlEventTouchUpInside];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 3, 5);
    UIBarButtonItem *placeHolderItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFixedSpace target: nil action: nil];
    placeHolderItem.width = -15;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView: button];
    self.currentNavigationItem.leftBarButtonItems = @[placeHolderItem, backItem];
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
    self.currentNavigationItem.titleView = titleLabel;
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
    
    self.currentNavigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: button];
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
    
    self.currentNavigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: button];
}

#pragma mark - Actions
#pragma mark -
#pragma mark Left Bar Button Item Click Action
- (void) leftNavigationItemAction:(UIButton *)sender {
    NSLog(@"%s", __FUNCTION__);
}


@end

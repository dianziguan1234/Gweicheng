//
//  LMNavigationController.m
//  LawMonkey
//
//  Created by 刘彬 on 16/3/19.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "LMNavigationController.h"

@implementation LMNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.navigationBarColor = COLOR_NAVIVATIONBAR;
        self.showBarLine = NO;
        //self.NavTitle = @"律大圣";
    }
    return self;
}

//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    if (navigationController.viewControllers.count > 1) {
//        [viewController setNavBackButton];
//        if (!self.rdv_tabBarController.tabBarHidden) {
//            self.rdv_tabBarController.tabBarHidden = YES;
//        }
//    } else {
//        if (self.rdv_tabBarController.tabBarHidden) {
//            self.rdv_tabBarController.tabBarHidden = NO;
//        }
//    }
//}


//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    [viewController setNavBackButton];
//    if (!self.rdv_tabBarController.tabBarHidden) {
//        self.rdv_tabBarController.tabBarHidden = YES;
//    }
//    [super pushViewController:viewController animated:animated];
//}
//
//
//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    [super navigationController:navigationController didShowViewController:viewController animated:animated];
//    if (navigationController.viewControllers.count > 1) {
//        [viewController setNavBackButton];
//        if (!self.rdv_tabBarController.tabBarHidden) {
//            self.rdv_tabBarController.tabBarHidden = YES;
//        }
//    } else {
//        if (self.rdv_tabBarController.tabBarHidden) {
//            self.rdv_tabBarController.tabBarHidden = NO;
//        }
//    }
//    
//}

@end

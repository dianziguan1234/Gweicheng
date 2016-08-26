//
//  NBNavigationController.h
//  LawMonkey
//
//  Created by 刘彬 on 16/3/19.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NBNavigationController : UINavigationController<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, assign) BOOL enableGestureRecognizer;
@property (nonatomic, assign) BOOL showBarLine;
@property (nonatomic, strong) UIColor *navigationBarColor;

@end

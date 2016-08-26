//
//  NBBaseViewController.h
//  LawMonkey
//
//  Created by 刘彬 on 16/3/20.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,LoginOrRegistType){
    LoginOrRegistType_Login = 0,
    LoginOrRegistType_Regist = 1,
    LoginOrRegistType_FindPassWord = 2,
    LoginOrRegistType_BindPhone = 3,
    LoginOrRegistType_EditPassWord = 4,
};

@interface NBBaseViewController : UIViewController

@property (nonatomic, assign) BOOL hideTabBar;

@end

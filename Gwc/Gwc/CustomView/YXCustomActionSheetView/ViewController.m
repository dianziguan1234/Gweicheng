//
//  ViewController.m
//  YXCustomActionSheet
//
//  Created by Houhua Yan on 16/7/12.
//  Copyright © 2016年 YanHouhua. All rights reserved.
//

#import "ViewController.h"
#import "YXCustomActionSheet.h"
#import "YXScrollowActionSheet.h"

@interface ViewController ()<YXCustomActionSheetDelegate,YXScrollowActionSheetDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}

- (IBAction)showActionSheet:(id)sender {
    
    YXCustomActionSheet *cusSheet = [[YXCustomActionSheet alloc] init];
    cusSheet.delegate = self;
    NSArray *contentArray = @[@{@"name":@"新浪微博",@"icon":@"sns_icon_3"},
                              @{@"name":@"QQ空间 ",@"icon":@"sns_icon_5"},
                              @{@"name":@"QQ ",@"icon":@"sns_icon_4"},
                              @{@"name":@"微信",@"icon":@"sns_icon_7"},
                              @{@"name":@"朋友圈",@"icon":@"sns_icon_8"},
//                              @{@"name":@"QQ ",@"icon":@"sns_icon_4"},
//                              @{@"name":@"微信",@"icon":@"sns_icon_7"},
//                              @{@"name":@"朋友圈",@"icon":@"sns_icon_8"},
                              @{@"name":@"新浪微博",@"icon":@"sns_icon_3"},
                              @{@"name":@"QQ空间 ",@"icon":@"sns_icon_5"},
                              @{@"name":@"微信收藏",@"icon":@"sns_icon_9"}];
    
    [cusSheet showInView:[UIApplication sharedApplication].keyWindow contentArray:contentArray];
}

- (IBAction)showScrollowActionSheet:(id)sender {
    
    YXScrollowActionSheet *cusSheet = [[YXScrollowActionSheet alloc] init];
    cusSheet.delegate = self;
    NSArray *contentArray = @[@{@"name":@"新浪微博",@"icon":@"sns_icon_3"},
                              @{@"name":@"QQ空间 ",@"icon":@"sns_icon_5"},
                              @{@"name":@"QQ ",@"icon":@"sns_icon_4"},
                              @{@"name":@"微信",@"icon":@"sns_icon_7"},
                              @{@"name":@"朋友圈",@"icon":@"sns_icon_8"},
                              @{@"name":@"微信收藏",@"icon":@"sns_icon_9"}];
    
    [cusSheet showInView:[UIApplication sharedApplication].keyWindow contentArray:contentArray];

    
}


#pragma mark - YXCustomActionSheetDelegate

- (void) customActionSheetButtonClick:(YXActionSheetButton *)btn
{
    NSLog(@"第%li个按钮被点击了",(long)btn.tag);
}

#pragma mark - YXScrollowActionSheetDelegate
- (void) scrollowActionSheetButtonClick:(YXActionSheetButton *) btn
{
     NSLog(@"第%li个按钮被点击了",(long)btn.tag);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

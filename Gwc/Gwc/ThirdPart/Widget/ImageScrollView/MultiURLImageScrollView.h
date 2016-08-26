//
//  MultiURLImageScrollView.h
//  LawMonkey
//
//  Created by 刘彬 on 16/5/14.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MultiURLImageScrollView : UIView

@property (nonatomic) NSUInteger currentPage;
- (instancetype) initWithImages:(NSArray *)imageURLs;
- (void)showInView:(UIView *)view;

@end

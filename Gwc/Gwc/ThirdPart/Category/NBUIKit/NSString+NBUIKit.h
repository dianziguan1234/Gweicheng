//
//  NSString+NBUIKit.h
//  NBCategory
//
//  Created by 刘彬 on 16/3/18.
//  Copyright © 2016年 NewBee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (NBUIKit)

/**
 *  返回一个string显示font需要的尺寸
 *
 *  @param font     字体大小
 *  @param maxWidth 最大宽度
 *
 *  @return 返回合适的尺寸
 */
- (CGSize)nb_sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;

@end

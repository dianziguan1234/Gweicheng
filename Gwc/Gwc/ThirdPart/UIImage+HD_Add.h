//
//  UIImage+HD_Add.h
//  GoodFolks
//
//  Created by deng on 16/11/2.
//  Copyright © 2016年 deng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HD_Add)

/**
 *  生成二维码图片
 *
 *  @param str 下载链接
 *
 *  @return 下载链接生成的二维码图片
 */
+ (UIImage *)imageCodeWithStr:(NSString *)str;


@end

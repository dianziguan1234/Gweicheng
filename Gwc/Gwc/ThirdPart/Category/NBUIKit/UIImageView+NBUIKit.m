//
//  UIImageView+NBUIKit.m
//  NBCategory
//
//  Created by 刘彬 on 16/3/15.
//  Copyright © 2016年 NewBee. All rights reserved.
//

#import "UIImageView+NBUIKit.h"
#import "UIImage+NBUIKit.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (NBUIKit)

+ (instancetype)nb_imageViewWithSize:(CGSize)size image:(UIImage *)image {
    
    CGRect frame              = CGRectZero;
    frame.size.width          = (size.width <= 0.0f ? 40.0f : size.width);
    frame.size.height         = (size.height <= 0.0f ? 40.0f : size.height);

    UIImageView *imageView    = [[[self class] alloc] initWithFrame:frame];
    imageView.clipsToBounds   = YES;
    imageView.backgroundColor = [UIColor clearColor];
    imageView.image           = image;
    return imageView;
}

/**
 *  一个高宽都为width的imageView
 *
 *  @param width 边框，默认值40
 *
 *  @return imageView
 */
+ (instancetype)nb_imageViewWithWidth:(CGFloat)width {
    return [self nb_imageViewWithSize:CGSizeMake(width, width) image:nil];
}

/**
 *  一个图片
 *
 *  @param size 高宽，默认值CGSize(40,40)
 *
 *  @return imageView
 */
+ (instancetype)nb_imageViewWithSize:(CGSize)size {
    return [self nb_imageViewWithSize:size image:nil];
}

/**
 *  一个图片
 *
 *  @param image 设置的image，大小取image大小
 *
 *  @return imageView
 */
+ (instancetype)nb_imageViewWithImage:(UIImage *)image {
    return [self nb_imageViewWithSize:image.size image:image];
}

/**
 *  一个一像素高度的线，内部根据当前分辨率扩充其透明线
 *
 *  @param width        边框，默认值40
 *  @param color        线的颜色，不能为空
 *  @param orientation  线的方向
 *
 *  @return 一个线的view
 */
+ (instancetype)nb_lineWithWidth:(CGFloat)width color:(UIColor *)color orientation:(UIInterfaceOrientation)orientation {
    
    UIImage *image            = [UIImage nb_lineWithColor:color orientation:orientation];
    CGRect frame              = CGRectZero;
    CGFloat aWidth            = (width <= 0.0f ? 40.0f : width);

    if (UIInterfaceOrientationLandscapeLeft == orientation || UIInterfaceOrientationLandscapeRight == orientation) {
        frame.size.height         = aWidth;
        frame.size.width          = 1;
    }
    else {
        frame.size.width          = aWidth;
        frame.size.height         = 1;
    }

    UIImageView *imageView    = [[[self class] alloc] initWithFrame:frame];
    imageView.clipsToBounds   = YES;
    imageView.backgroundColor = [UIColor clearColor];
    imageView.image           = image;
    return imageView;
}

/*!
 *  @brief  圆形图像的头像
 *
 *  @param width        头像宽
 *  @param borderWidth  边线
 *  @param borderColor  边线色
 *  @param defaultImage 默认图
 *
 *  @return 头像imageview
 */
+ (instancetype)nb_avatarWithWidth:(CGFloat)width borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor defaultImage:(UIImage *)defaultImage {
    UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
    avatar.backgroundColor = COLOR_TABLE_BACKGROUND_GRAY;
    avatar.contentMode = UIViewContentModeScaleAspectFill;
    avatar.image = defaultImage;
    avatar.layer.masksToBounds = YES;
    avatar.layer.cornerRadius = floorf(width/2.0f);
    
    // 先画边框
    if (borderWidth > 0 && borderColor) {
        UIImage *frameImage = [UIImage nb_circleLineWithDiameter:width border:(borderWidth > 0 ? borderWidth : 1) color:(borderColor ? borderColor :COLOR_APP_STYLE)];
        UIImageView *frameImageView = [[UIImageView alloc] initWithImage:frameImage];
        frameImageView.frame = CGRectMake(0, 0, width, width);
        frameImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        [avatar addSubview:frameImageView];
    }
    
    return avatar;
}

/*!
 *  @brief  设置图片
 *
 *  @param url 图片链接
 */
- (void)nb_setURL:(NSString *)url {
    [self nb_setURL:url placeholderImage:nil];
}

/*!
 *  @brief 设置图片
 *
 *  @param url   图片链接
 *  @param image 占位图片
 */
- (void)nb_setURL:(NSString *)url placeholderImage:(UIImage *)image{
    if (image) {
        [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:image];
    }else{
        [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"img_download_error"]];
    }
}

@end

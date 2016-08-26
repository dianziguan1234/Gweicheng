//
//  UIImage+NBUIKit.m
//  NBCategory
//
//  Created by 刘彬 on 16/3/15.
//  Copyright © 2016年 NewBee. All rights reserved.
//

#import "UIImage+NBUIKit.h"
#import <Accelerate/Accelerate.h>

@implementation UIImage (NBUIKit)

/**
 *  返回一像素（size(1,1)）这个color颜色的图片
 *
 *  @param color 一个颜色指标【不能为nil】
 *
 *  @return 图片
 */
+ (UIImage *)nb_imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)nb_imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 *  返回一个size为给定size的color颜色图片
 *
 *  @param size   size大小
 *  @param color  填充色颜色
 *  @param radius 圆角半径
 *
 *  @return 图片
 */
+ (UIImage *)nb_imageWithColor:(UIColor *)color cornerRadius:(CGFloat)radius {
    CGFloat width = radius + 3;
    return [self nb_imageWithSize:CGSizeMake(width, width) color:color border:0.0f color:nil cornerRadius:radius];
}


/**
 *  返回一个size为给定size的color颜色带with宽边线和borderColor颜色的图片
 *
 *  @param color       填充色颜色
 *  @param width       边线宽度
 *  @param borderColor 边线颜色
 *  @param radius      圆角半径
 *
 *  @return 图片
 */
+ (UIImage *)nb_imageWithColor:(UIColor *)color border:(CGFloat)width color:(UIColor *)borderColor cornerRadius:(CGFloat)radius {
    CGFloat awidth = radius + width + 3;
    return [self nb_imageWithSize:CGSizeMake(awidth, awidth) color:color border:width color:borderColor cornerRadius:radius];
}

/**
 *  返回一个size为给定size的color颜色带with宽边线和borderColor颜色的图片
 *
 *  @param size        size大小
 *  @param color       填充色颜色
 *  @param width       边线宽度
 *  @param borderColor 边线颜色
 *  @param radius      圆角半径
 *
 *  @return 图片
 */
+ (UIImage *)nb_imageWithSize:(CGSize)size color:(UIColor *)color border:(CGFloat)width color:(UIColor *)borderColor cornerRadius:(CGFloat)radius {
    
    UIColor *bcolor = color;
    if (!color) {
        bcolor = [UIColor clearColor];
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    UIBezierPath *borderPath = nil;//
    CGFloat border_width = ceil(width);
    if (border_width > 0.0f) {//
        borderPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:radius];
        //        borderPath.lineWidth = border_width;
    }
    
    UIBezierPath *fillPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(border_width, border_width, size.width - border_width * 2, size.height - border_width * 2) cornerRadius:radius - border_width];
    
    if (borderPath) {
        [borderColor setFill];
        [borderPath fill];
    }
    
    [bcolor setFill];
    [fillPath fill];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 *  返回一个size为给定size的渐变颜色从from到to的图片
 *
 *  @param size   size大小
 *  @param from   起始颜色，位置在top
 *  @param to     终止颜色，位置在bottom
 *  @param radius 圆角半径
 *
 *  @return 图片
 */
+ (UIImage *)nb_imageWithSize:(CGSize)size gradientColor:(UIColor *)from to:(UIColor *)to cornerRadius:(CGFloat)radius {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSArray *aColors = @[(id)(from.CGColor),(id)(to.CGColor)];
    CGFloat aLocations[2] = {0.0f,1.0f};
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)aColors, aLocations);
    
    UIBezierPath *roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:radius];
    CGContextSaveGState(context);
    [roundedRectanglePath addClip];
    CGContextDrawLinearGradient(context, gradient, CGPointMake(size.width / 2, 0), CGPointMake(size.width / 2, size.height), 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 *  返回一个size为给定size的渐变颜色从from到to的带with宽边线和borderColor颜色的图片
 *
 *  @param size        size大小
 *  @param from        起始颜色，位置在top
 *  @param to          终止颜色，位置在bottom
 *  @param width       边线宽度
 *  @param borderColor 边线颜色
 *  @param radius      圆角半径
 *
 *  @return 图片
 */
+ (UIImage *)nb_imageWithSize:(CGSize)size gradientColor:(UIColor *)from to:(UIColor *)to border:(CGFloat)width color:(UIColor *)borderColor cornerRadius:(CGFloat)radius {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSArray *aColors = @[(id)(from.CGColor),(id)(to.CGColor)];
    CGFloat aLocations[2] = {0.0f,1.0f};
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)aColors, aLocations);
    
    UIBezierPath *roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:radius];
    CGContextSaveGState(context);
    [roundedRectanglePath addClip];
    CGContextDrawLinearGradient(context, gradient, CGPointMake(size.width / 2, 0), CGPointMake(size.width / 2, size.height), 0);
    CGContextRestoreGState(context);
    
    [borderColor setStroke];
    roundedRectanglePath.lineWidth = width;
    [roundedRectanglePath stroke];
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 *  返回一个size为给定size的渐变颜色从from到to的带with宽边线和borderColor颜色的图片
 *
 *  @param size        size大小
 *  @param from        起始颜色，位置在top
 *  @param to          终止颜色，位置在bottom
 *  @param width       边线宽度
 *  @param borderColor 边线颜色
 *  @param blendingWidth 边缘配色宽度，使得绘制出的图片渐变更自然
 *  @param blendingColor 边缘配色，使得绘制出的图片渐变更自然
 *  @param radius      圆角半径
 *
 *  @return 图片
 */
+ (UIImage *)nb_imageWithSize:(CGSize)size gradientColor:(UIColor *)from to:(UIColor *)to border:(CGFloat)width color:(UIColor *)borderColor blending:(CGFloat)blendingWidth color:(UIColor *)blendingColor cornerRadius:(CGFloat)radius {
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSArray *aColors = @[(id)(from.CGColor),(id)(to.CGColor)];
    CGFloat aLocations[2] = {0.0f,1.0f};
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)aColors, aLocations);
    
    //TODO:If I use '[borderPath stroke]' when setting the path width to 0.5, it will look aliasing on its corner. So I use two rounded rectangle path to draw the image, one for border, the other for fill color. It looks good, but you will find the rgb value of the image corner is different using PhotoShop. -- By QingShan
    
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:radius];
    UIBezierPath *fillPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(width, width, size.width - width * 2, size.height - width * 2) cornerRadius:radius - width];
    
    //fill borderPath
    [borderColor setFill];
    [borderPath fill];
    //fill fillPath
    [blendingColor setFill];
    [fillPath fill];
    //draw gradient in fillPath
    CGContextSaveGState(context);
    [fillPath addClip];
    CGContextDrawLinearGradient(context, gradient, CGPointMake(size.width / 2, width + blendingWidth), CGPointMake(size.width / 2, size.height - width), 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 *  返回一个size为给定size的渐变颜色带with宽边线和borderColor颜色的图片
 *
 *  @param size         size大小
 *  @param colors       渐变颜色序列，元素为UIColor
 *  @param locations    渐变位置数组元素为CGFloat，取值[0~1]
 *  @param width         边框宽度
 *  @param borderColor   变宽颜色
 *  @param blendingWidth 配色宽度
 *  @param blendingColor 配色颜色
 *  @param radius        圆角半径
 *
 *  @return 图片
 */
+ (UIImage *)nb_imageWithSize:(CGSize)size gradientColors:(NSArray *)colors gradientLocations:(const CGFloat [])locations border:(CGFloat)width color:(UIColor *)borderColor blending:(CGFloat)blendingWidth color:(UIColor *)blendingColor cornerRadius:(CGFloat)radius {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSMutableArray *aColors = [NSMutableArray array];
    for (UIColor *color in colors) {
        [aColors addObject:(id)(color.CGColor)];
    }
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)aColors, locations);
    
    //TODO:If I use '[borderPath stroke]' when setting the path width to 0.5, it will look aliasing on its corner. So I use two rounded rectangle path to draw the image, one for border, the other for fill color. It looks good, but you will find the rgb value of the image corner is different using PhotoShop. -- By QingShan
    
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:radius];
    UIBezierPath *fillPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(width, width, size.width - width * 2, size.height - width * 2) cornerRadius:radius - width];
    
    //fill borderPath
    [borderColor setFill];
    [borderPath fill];
    //fill fillPath
    [blendingColor setFill];
    [fillPath fill];
    //draw gradient in fillPath
    CGContextSaveGState(context);
    [fillPath addClip];
    CGContextDrawLinearGradient(context, gradient, CGPointMake(size.width / 2, width + blendingWidth), CGPointMake(size.width / 2, size.height - width), 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 *  一像素线图片，实际是1x2或者1x3的图片，根据屏幕scale决定
 *
 *  @param orientation 透明像素填充方向
 *
 *  @return 一像素线图片
 */
+ (UIImage *)nb_lineWithColor:(UIColor *)color orientation:(UIInterfaceOrientation)orientation {
    
    CGFloat widthpx = [UIScreen mainScreen].scale; //px
    
    CGSize size = CGSizeZero;
    
    if (UIInterfaceOrientationLandscapeLeft == orientation || UIInterfaceOrientationLandscapeRight == orientation) {
        size.width = widthpx;
        size.height = 1;
    }
    else {
        size.width = 1;
        size.height = widthpx;
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 1);
    
    [color set];
    switch (orientation) {
        case UIInterfaceOrientationPortrait:
            UIRectFill(CGRectMake(0, 0, 1, 1));
            if (widthpx > 1) {
                [[UIColor clearColor] set];
                UIRectFill(CGRectMake(0, 1, 1, widthpx - 1));
            }
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            UIRectFill(CGRectMake(0, widthpx - 1, 1, 1));
            if (widthpx > 1) {
                [[UIColor clearColor] set];
                UIRectFill(CGRectMake(0, 0, 1, widthpx - 1));
            }
            break;
        case UIInterfaceOrientationLandscapeLeft:
            UIRectFill(CGRectMake(widthpx - 1, 0, 1, 1));
            if (widthpx > 1) {
                [[UIColor clearColor] set];
                UIRectFill(CGRectMake(0, 0, widthpx - 1, 1));
            }
            break;
        case UIInterfaceOrientationLandscapeRight:
            UIRectFill(CGRectMake(0, 0, 1, 1));
            if (widthpx > 1) {
                [[UIColor clearColor] set];
                UIRectFill(CGRectMake(1, 0, widthpx - 1, 1));
            }
            break;
        default:
            UIRectFill(CGRectMake(0, 0, 1, 1));
            if (widthpx > 1) {
                [[UIColor clearColor] set];
                UIRectFill(CGRectMake(0, 1, 1, widthpx - 1));
            }
            break;
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#define   nb_pi (3.14159265359)
#define   nb_degrees_to_radians(degrees)  ((nb_pi * degrees)/ 180)

/**
 *  绘制一个圆形线圈
 *
 *  @param diameter    直径
 *  @param width       线宽
 *  @param borderColor 线颜色
 *
 *  @return 绘制一个圆形线圈
 */
+ (UIImage *)nb_circleLineWithDiameter:(CGFloat)diameter border:(CGFloat)width color:(UIColor *)borderColor {
    
    CGSize size = CGSizeMake(diameter, diameter);
    CGFloat radius = floor(diameter/2.0f);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    UIBezierPath* borderPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius)
                                                              radius:radius
                                                          startAngle:0
                                                            endAngle:nb_degrees_to_radians(360)
                                                           clockwise:YES];
    
    borderPath.lineWidth = width;
    borderPath.lineCapStyle = kCGLineCapRound; //线条拐角
    borderPath.lineJoinStyle = kCGLineCapRound; //终点处理
    
    [borderColor setStroke]; //设置线条颜色
    [borderPath stroke];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 *  绘制一个圆形线圈
 *
 *  @param diameter    直径
 *  @param width       线宽
 *  @param borderColor 线颜色
 *  @param backgroudColor 背景色
 *
 *  @return 绘制一个圆形线圈
 */
+ (UIImage *)nb_circleLineWithDiameter:(CGFloat)diameter border:(CGFloat)width color:(UIColor *)borderColor backgroudColor:(UIColor *)backgroudColor {
    CGSize size = CGSizeMake(diameter, diameter);
    CGFloat radius = floor(diameter/2.0f);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    UIBezierPath* borderPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius)
                                                              radius:radius
                                                          startAngle:0
                                                            endAngle:nb_degrees_to_radians(360)
                                                           clockwise:YES];
    
    borderPath.lineWidth = width;
    borderPath.lineCapStyle = kCGLineCapRound; //线条拐角
    borderPath.lineJoinStyle = kCGLineCapRound; //终点处理
    
    [borderColor setFill];
    [borderPath fill];
    
    CGSize fillsize = CGSizeMake(diameter - 2*width, diameter - 2*width);
    CGFloat fillradius = floor(fillsize.width/2.0f);
    
    UIBezierPath *fillPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius)
                                                            radius:fillradius
                                                        startAngle:0
                                                          endAngle:nb_degrees_to_radians(360)
                                                         clockwise:YES];
    [backgroudColor setFill];
    [fillPath fill];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 *  绘制一个圆
 *
 *  @param diameter 直径
 *  @param color    颜色
 *
 *  @return 绘制一个圆
 */
+ (UIImage *)nb_circleWithDiameter:(CGFloat)diameter color:(UIColor *)color {
    
    CGSize size = CGSizeMake(diameter, diameter);
    CGFloat radius = floor(diameter/2.0f);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    UIBezierPath* borderPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius)
                                                              radius:radius
                                                          startAngle:0
                                                            endAngle:nb_degrees_to_radians(360)
                                                           clockwise:YES];
    
    [color setFill]; //设置颜色
    [borderPath fill];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)nb_centerStretchImage {
    CGSize size = self.size;
    CGFloat half_width = floor(size.width/2);
    CGFloat half_height = floor(size.height/2);
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(half_height, half_width, half_height, half_width)];
}

#pragma mark 毛玻璃绘制
void nb_ImageBufferInitialized(vImage_Buffer *buffer, CGImageRef image) {
    memset(buffer, 0, sizeof(vImage_Buffer));
    
    buffer->width = CGImageGetWidth( image );
    buffer->height = CGImageGetHeight( image );
    buffer->rowBytes = CGImageGetBytesPerRow( image );
    buffer->data = malloc( buffer->rowBytes * buffer->height );
}

void nb_ImageBufferDestory(vImage_Buffer *buffer) {
    if (buffer->data) {
        free(buffer->data);
        buffer->data = NULL;
    }
    
    memset(buffer, 0, sizeof(vImage_Buffer));
}

- (UIImage *)nb_scaleImage {
    CGSize selfSize = self.size;
    CGFloat selfScale = self.scale;
    CGFloat screenScale = [UIScreen mainScreen].scale;
    CGSize targetSize = CGSizeMake(floor(selfSize.width * selfScale / screenScale), floor(selfSize.height * selfScale / screenScale));
    UIGraphicsBeginImageContextWithOptions(targetSize, NO, screenScale);
    [self drawInRect:CGRectMake(0, 0, targetSize.width, targetSize.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)nb_gaussianBlurImage {
    
    uint32_t radius = 5;
    uint8_t iterations = 5;
    
    return [self nb_gaussianBlurImageWithRadius:radius iterations:iterations];
}

/**
 *  绘制毛玻璃
 *
 *  @param complete 绘制完
 */
- (void)nb_gaussianBlurImageComplete:(void(^)(UIImage *image))complete {
    __weak typeof(self) w_self = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{__strong typeof(w_self) self = w_self;
        if (!self) {
            return ;
        }
        UIImage *image = [self nb_gaussianBlurImage];
        if (complete) {
            dispatch_async(dispatch_get_main_queue(), ^{
                complete(image);
            });
        }
    });
}

/**
 *  绘制毛玻璃
 *
 *  @param radius     渲染半径
 *  @param iterations 重复渲染次数
 *
 *  @return 渲染后图片
 */
- (UIImage *)nb_gaussianBlurImageWithRadius:(NSUInteger)radius iterations:(NSUInteger)iterations {
    
    UIImage *image = [self nb_scaleImage];//先矫正图片
    
    CGImageRef cgimage = image.CGImage;
    
    vImage_Buffer tempImageBuffer;
    vImage_Buffer finalImageBuffer;
    
    nb_ImageBufferInitialized(&tempImageBuffer, cgimage);
    nb_ImageBufferInitialized(&finalImageBuffer, cgimage);
    
    CFDataRef dataSource = CGDataProviderCopyData( CGImageGetDataProvider( cgimage ));
    memcpy( tempImageBuffer.data, CFDataGetBytePtr( dataSource ), tempImageBuffer.rowBytes * tempImageBuffer.height );
    memcpy( finalImageBuffer.data, CFDataGetBytePtr( dataSource ), finalImageBuffer.rowBytes * finalImageBuffer.height );
    CFRelease(dataSource);
    
    // Radius must be an odd integer, or we'll get a kvImageInvalidKernelSize error. See
    // vImageBoxConvolve_ARGB8888 documentation for a better discussion
    uint32_t finalRadius = ( uint32_t )( radius * image.scale );
    if(( finalRadius & 1 ) == 0 ) {
        ++finalRadius;
    }
    
    // The reason of the loop below is that many convolve iterations generate a better blurred image
    // than applying a greater convolve radius
    for( uint16_t i = 0 ; i < iterations ; ++i )
    {
        vImage_Error error = vImageBoxConvolve_ARGB8888( &tempImageBuffer, &finalImageBuffer, NULL, 0, 0, finalRadius, finalRadius, NULL, kvImageEdgeExtend );
        if( error != kvImageNoError )
        {
            return nil;
        }
        
        void *temp = tempImageBuffer.data;
        tempImageBuffer.data = finalImageBuffer.data;
        finalImageBuffer.data = temp;
    }
    
    // The last processed image is being hold by tempImageBuffer. So let's fix it
    // by swaping buffers again
    void *temp = tempImageBuffer.data;
    tempImageBuffer.data = finalImageBuffer.data;
    finalImageBuffer.data = temp;
    
    CGColorSpaceRef colorSpace = CGImageGetColorSpace( cgimage );
    CGBitmapInfo info = CGImageGetBitmapInfo( cgimage );
    CGContextRef finalImageContext = CGBitmapContextCreate(finalImageBuffer.data,
                                                           finalImageBuffer.width,
                                                           finalImageBuffer.height,
                                                           8,
                                                           finalImageBuffer.rowBytes,
                                                           colorSpace,
                                                           info);
    
    // TODO : Here we could call a delegate with the context, so we could do a post process. Or
    // we could receive a block to do the same
    // ...
    
    CGImageRef finalImageRef = CGBitmapContextCreateImage( finalImageContext );
    UIImage *finalImage = [UIImage imageWithCGImage:finalImageRef scale:image.scale orientation: image.imageOrientation];
    CGImageRelease( finalImageRef );
    CGContextRelease( finalImageContext );
    
    //释放
    nb_ImageBufferDestory(&tempImageBuffer);
    nb_ImageBufferDestory(&finalImageBuffer);
    
    return finalImage;
}

/**
 *  绘制毛玻璃
 *
 *  @param radius     渲染半径
 *  @param iterations 重复渲染次数
 *  @param complete   渲染完成回调
 */
- (void)nb_gaussianBlurImageWithRadius:(NSUInteger)radius iterations:(NSUInteger)iterations complete:(void(^)(UIImage *image))complete {
    __weak typeof(self) w_self = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{__strong typeof(w_self) self = w_self;
        if (!self) {
            return ;
        }
        UIImage *image = [self nb_gaussianBlurImageWithRadius:radius iterations:iterations];
        if (complete) {
            dispatch_async(dispatch_get_main_queue(), ^{
                complete(image);
            });
        }
    });
}

#pragma mark 绘制倒影
/**
 *  绘制倒影图片
 *
 *  @return 倒影
 */
- (UIImage *)nb_mirroredImage {
    
    // http://www.360doc.com/content/14/0314/13/16235376_360519517.shtml
    
    CGSize pSize = CGSizeMake(CGImageGetWidth(self.CGImage), CGImageGetHeight(self.CGImage));
    
    UIGraphicsBeginImageContextWithOptions(pSize, YES, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextDrawImage(context, CGRectMake(0, 0, pSize.width, pSize.height), self.CGImage);
    
    UIImage *mirrored = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return mirrored;
}

/*!
 *  @brief  压缩图片尺寸
 *
 *  @param newSize 新的尺寸
 *
 *  @return 新的图片
 */
- (UIImage *)nb_scaledToSize:(CGSize)newSize{
    
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}


/*!
 *  @brief  读取大图片
 *
 *  @param imageName 图片名字
 *
 *  @return 新的图片
 */
+ (UIImage *)nb_imageWithContentOfImageName:(NSString*)imageName{
    if(IS_IPHONE6P){
        imageName = [NSString stringWithFormat:@"%@@3x",imageName];
    }else{
        imageName = [NSString stringWithFormat:@"%@@2x",imageName];
    }
    NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
    return [UIImage imageWithContentsOfFile:filePath];
}


@end

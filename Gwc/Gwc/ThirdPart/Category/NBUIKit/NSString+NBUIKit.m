//
//  NSString+NBUIKit.m
//  NBCategory
//
//  Created by 刘彬 on 16/3/18.
//  Copyright © 2016年 NewBee. All rights reserved.
//

#import "NSString+NBUIKit.h"

@implementation NSString (NBUIKit)

- (CGSize)nb_sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth {
    
    CGSize maxSize = CGSizeMake(maxWidth, 3000);
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSDictionary *attributes = @{ NSFontAttributeName:font };
        CGRect rect = [self boundingRectWithSize:maxSize
                                         options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attributes
                                         context:nil];
        return CGSizeMake(ceil(rect.size.width), ceil(rect.size.height));
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
    CGSize size = [self sizeWithFont:font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    return CGSizeMake(ceil(size.width), ceil(size.height));
#pragma clang diagnostic pop

}

@end

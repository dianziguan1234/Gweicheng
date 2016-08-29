//
//  UILabel+StringFrame.m
//  DayangHealth
//
//  Created by apple on 16/3/29.
//  Copyright © 2016年 com.dayangdata.gwc. All rights reserved.
//

#import "UILabel+StringFrame.h"

@implementation UILabel (StringFrame)

- (CGSize)boundingRectWithSize:(CGSize)size
{
    NSDictionary *attribute = @{NSFontAttributeName: self.font};
    
    CGSize retSize = [self.text boundingRectWithSize:size
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
    return retSize;
}

/****eg
// 字符串
NSString *str = @"日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝，与慈悲淡然的佛境禅心，在清欢中，从容幽静，自在安然。一直向往走进青的山，碧的水，体悟山水的绚丽多姿，领略草木的兴衰荣枯，倾听黄天厚土之声，探寻宇宙自然的妙趣。走进了山水，也就走出了喧嚣，给身心以清凉，给精神以沉淀，给灵魂以升华。";

// 初始化label
UILabel *label = [UILabel new];
label.backgroundColor = [UIColor whiteColor];
[self.view addSubview:label];

// label获取字符串
label.text = str;


// label获取字体
label.font = [UIFont fontWithName:nil size:18];

// 根据获取到的字符串以及字体计算label需要的size
CGSize size = [label boundingRectWithSize:CGSizeMake(320, 0)];

// 设置无限换行
label.numberOfLines = 0;

// 设置label的frame
label.frame = CGRectMake(0.0f, 50.0f, size.width, size.height);
 **/
@end

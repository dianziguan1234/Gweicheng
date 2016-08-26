//
//  UIConfigMarco.h
//  Gwc
//
//  Created by apple on 8/26/16.
//  Copyright © 2016 com.dayangdata.gwc. All rights reserved.
//

#ifndef UIConfigMarco_h
#define UIConfigMarco_h

#pragma mark - ----------------------Font macros----------------------

#define HEL_8               [UIFont systemFontOfSize:8]
#define HEL_9               [UIFont systemFontOfSize:9]
#define HEL_10              [UIFont systemFontOfSize:10]
#define HEL_11              [UIFont systemFontOfSize:11]
#define HEL_12              [UIFont systemFontOfSize:12]
#define HEL_13              [UIFont systemFontOfSize:13]
#define HEL_14              [UIFont systemFontOfSize:14]
#define HEL_15              [UIFont systemFontOfSize:15]
#define HEL_16              [UIFont systemFontOfSize:16]
#define HEL_17              [UIFont systemFontOfSize:17]
#define HEL_18              [UIFont systemFontOfSize:18]
#define HEL_19              [UIFont systemFontOfSize:19]
#define HEL_20              [UIFont systemFontOfSize:20]
#define HEL_21              [UIFont systemFontOfSize:21]
#define HEL_22              [UIFont systemFontOfSize:22]
#define HEL_24              [UIFont systemFontOfSize:24]
#define HEL_30              [UIFont systemFontOfSize:30]
#define HEL_36              [UIFont systemFontOfSize:36]


#define HEL_BOLD_12         [UIFont boldSystemFontOfSize:12]
#define HEL_BOLD_13         [UIFont boldSystemFontOfSize:13]
#define HEL_BOLD_14         [UIFont boldSystemFontOfSize:14]
#define HEL_BOLD_15         [UIFont boldSystemFontOfSize:15]
#define HEL_BOLD_16         [UIFont boldSystemFontOfSize:16]
#define HEL_BOLD_18         [UIFont boldSystemFontOfSize:18]
#define HEL_BOLD_19         [UIFont boldSystemFontOfSize:19]
#define HEL_BOLD_20         [UIFont boldSystemFontOfSize:20]
#define HEL_BOLD_22         [UIFont boldSystemFontOfSize:22]
#define HEL_BOLD_24         [UIFont boldSystemFontOfSize:24]
#define HEL_BOLD_30         [UIFont boldSystemFontOfSize:30]

#pragma mark - ----------------------Common Font & Color----------------------

// 粗体文本字号
#define Biggest_Border_Font    HEL_BOLD_22
#define Biger_Border_Font      HEL_BOLD_18
#define Big_Border_Font        HEL_BOLD_16
#define Middle_Bold_Font       HEL_BOLD_15
#define Normal_Bold_Font       HEL_BOLD_14
#define Normal_Small_Bold_Font HEL_BOLD_12
// 普通文本字号
#define Biggest_Font           HEL_22
#define Biger_Font             HEL_18
#define Big_Font               HEL_16
#define Middle_Font            HEL_15
#define Normal_Font            HEL_13
#define Normal_Small_Font      HEL_12
#define Normal_Smaller_Font    HEL_11
#define Small_Font             HEL_10
#define Smaller_Font           HEL_9
// navigationbar字体
#define NavigationBar_Title_Font  Biger_Border_Font
#define NavigationBar_Button_Font HEL_15

#define HEX_COLOR(hex)              [UIColor nb_colorWithHex:hex alpha:1.0]
#define HEX_ALPHA_COLOR(hex,a)      [UIColor nb_colorWithHex:hex alpha:a]
#define RGBA_COLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

// 系统色
#define COLOR_SYSTEM_WHITE          [UIColor whiteColor]
#define COLOR_SYSTEM_BLACK          [UIColor blackColor]
#define COLOR_SYSTEM_CLEAR          [UIColor clearColor]

// app默认风格颜色
#define COLOR_APP_STYLE             HEX_COLOR(0xBC8B36)
#define COLOR_APP_STYLE_HIGHLIGHT   HEX_COLOR(0xD5B680)

// navigationbar颜色
#define COLOR_NAVIVATIONBAR         HEX_COLOR(0x000000)
// 默认文本颜色[标题文字，正文内容，对话内容]
#define COLOR_NORMAL_TEXT           HEX_COLOR(0x1d282e)
// 灰色文本颜色[状态文字，辅助文字]
#define COLOR_NORMAL_SUBINFO_TEXT   HEX_COLOR(0xb0b0b0)
// 高亮文本颜色[金额，等级等高权重文字]
#define COLOR_HIGHLIGHT_TEXT        HEX_COLOR(0xfa680c)
// 提示文本颜色
#define COLOR_PLACEHOLDER_TEXT      HEX_COLOR(0xc2c2c2)
// 禁止状态文本颜色
#define COLOR_DISABLE_TEXT          HEX_COLOR(0x989898)
// 普通分隔线颜色
#define COLOR_TABLE_LINE            HEX_COLOR(0xd8d8d8)
// section颜色
#define COLOR_TABLE_SECTION         HEX_COLOR(0Xf1f1f1)
// tableview背景色
#define COLOR_TABLE_BACKGROUND_GRAY HEX_COLOR(0xf5f5f5)
// cell选择颜色
#define COLOR_TABLE_CELL_SELECTED   HEX_COLOR(0xf6f6f6)

// navigationbar标题颜色
#define COLOR_NAVIGATIONBAR_TITLE   HEX_COLOR(0xffffff)
// navigationbar按钮颜色
#define COLOR_NAVIGATIONBAR_BUTTON  HEX_COLOR(0xffffff)
// 默认的字体颜色 (New)
#define COLOR_COMMON_TITLE  HEX_COLOR(0x333333)

#define COLOR_COMMON_NORMAL_TEXT   HEX_COLOR(0xA3A3A3)

#pragma mark - ----------------------Common Frame Config----------------------

#define kSmallPadding    (5)
#define kNormalPadding   (12)
#define kMiddlePadding   (10)
#define kBigPadding      (15)

#define kSmallLineSpace  (3)
#define kNormalLineSpace (5)
#define kBigLineSpace    (8)


#endif /* UIConfigMarco_h */

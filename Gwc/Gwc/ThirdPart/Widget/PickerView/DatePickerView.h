//
//  DatePickerView.h
//  LawMonkey
//
//  Created by 刘彬 on 16/3/26.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasePickerView.h"

@interface DatePickerView : BasePickerView

- (id)initWithTitle:(NSString *)title delegate:(id /*<UIActionSheetDelegate>*/)delegate;

@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) NSDate *minimumDate;
@property (strong, nonatomic) NSDate *maximumDate;
@property (strong, nonatomic) NSDate *date;
@property (copy  , nonatomic) NSString *title;

@end

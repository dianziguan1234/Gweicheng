//
//  DatePickerView.m
//  LawMonkey
//
//  Created by 刘彬 on 16/3/26.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "DatePickerView.h"

@implementation DatePickerView

@synthesize datePicker;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithTitle:(NSString *)title delegate:(id /*<UIActionSheetDelegate>*/)delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.textLabel.text = title;
        
        self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0f, 44, kMainScreenWidth, 216)];
        [self addSubview:self.datePicker];
        
        self.datePicker.datePickerMode = UIDatePickerModeDate;
    }
    return self;
}



- (void)setMinimumDate:(NSDate *)aMinimumDate
{
    self.datePicker.minimumDate = aMinimumDate;
}

- (NSDate *)minimumDate
{
    return self.datePicker.minimumDate;
}

- (void)setMaximumDate:(NSDate *)aMaximumDate
{
    self.datePicker.maximumDate = aMaximumDate;
}

- (NSDate *)maximumDate
{
    return self.datePicker.maximumDate;
}

- (void)setDate:(NSDate *)aDate
{
    if (aDate != nil) {
        self.datePicker.date = aDate;
    }
}

- (NSDate *)date
{
    return self.datePicker.date;
}

- (void)setTitle:(NSString *)title
{
    self.textLabel.text = title;
}

- (NSString *)title
{
    return self.textLabel.text;
}

@end

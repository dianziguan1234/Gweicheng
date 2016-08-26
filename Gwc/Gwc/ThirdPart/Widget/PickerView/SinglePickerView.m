//
//  GenderPickerView.m
//  LawMonkey
//
//  Created by 刘彬 on 16/3/26.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "SinglePickerView.h"

@implementation SinglePickerView

@synthesize picker;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithTexts:(NSMutableArray *)texts delegate:(id)delegate
{
    return [self initWithTexts:texts title:@"" delegate:delegate];
}

- (id)initWithTexts:(NSMutableArray *)texts title:(NSString *)title delegate:(id)delegate
{
    self = [super init];
    if (self) {
        _array = texts;
        
        self.textLabel.text = title;
        self.picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0f, 44, kMainScreenWidth, 216)];
        self.picker.backgroundColor = [UIColor whiteColor];
        self.picker.showsSelectionIndicator = YES;
        self.picker.delegate = self;
        self.picker.dataSource = self;
        
        [self addSubview:self.picker];
        
        self.delegate = delegate;
        
    }
    return self;
}

#pragma mark - UIPickerView Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _array.count;
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_array objectAtIndex:row];
}

- (void)setSelectedIndex:(NSInteger)aSelectedIndex
{
    if (aSelectedIndex < _array.count) {
        [self.picker selectRow:aSelectedIndex inComponent:0 animated:NO];
    }
}

- (NSInteger)selectedIndex
{
    return [self.picker selectedRowInComponent:0];
}

- (void)setSelectedText:(NSString *)selectedText
{
    self.selectedIndex = [_array indexOfObject:selectedText];
}

- (NSString *)selectedText
{
    if (self.selectedIndex < _array.count) {
        return [_array objectAtIndex:self.selectedIndex];
    } else {
        return @"";
    }
}

@end

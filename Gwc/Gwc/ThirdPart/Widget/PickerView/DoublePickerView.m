//
//  DoublePickerView.m
//  LawMonkey
//
//  Created by 刘彬 on 16/3/26.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "DoublePickerView.h"

@implementation DoublePickerView

- (id)initWithTitle:(NSString *)title delegate:(id /*<UIActionSheetDelegate>*/)delegate mainColumData:(NSArray *)mainColumData subColumData:(NSArray *)subColumData
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.textLabel.text = title;
        
        self.picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0f, 44, kMainScreenWidth, 216)];
        self.picker.backgroundColor = [UIColor whiteColor];
        self.picker.showsSelectionIndicator = YES;
        [self addSubview:self.picker];
        self.picker.dataSource = self;
        self.picker.delegate = self;
        
        self.mainArray = mainColumData;
        self.subArray = subColumData;
        
        self.selectedMain = [mainColumData objectAtIndex:0];
        self.selectedSub = [subColumData objectAtIndex:0];
    }
    
    return self;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [self.mainArray count];
            break;
        case 1:
            return [self.subArray count];
            break;
        default:
            return 0;
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0:
            self.selectedMain = [self.mainArray objectAtIndex:row];
            break;
        case 1:
            self.selectedSub = [self.subArray objectAtIndex:row];
            break;
        default:
            break;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UIView *background = [[UIView alloc] init];
    background.autoresizesSubviews = YES;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 140, 30)];

    label.backgroundColor = [UIColor clearColor];
    [background addSubview:label];
    switch (component) {
        case 0:
    label.font = [UIFont boldSystemFontOfSize:15];
            label.text = [self.mainArray objectAtIndex:row];
            break;
        case 1:
    label.font = [UIFont boldSystemFontOfSize:15];
            label.text = [self.subArray objectAtIndex:row];
            break;
        default:
            break;
    }

    
    return background;
}

@end

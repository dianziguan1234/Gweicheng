//
//  GenderPickerView.h
//  LawMonkey
//
//  Created by 刘彬 on 16/3/26.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "BasePickerView.h"

@interface SinglePickerView : BasePickerView<UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSArray *_array;
}

@property (strong, nonatomic) UIPickerView *picker;
@property (assign, nonatomic) NSInteger selectedIndex;
@property (strong, nonatomic) NSString *selectedText;

- (id)initWithTexts:(NSMutableArray *)texts delegate:(id)delegate;
- (id)initWithTexts:(NSMutableArray *)texts title:(NSString *)title delegate:(id)delegate;

@end

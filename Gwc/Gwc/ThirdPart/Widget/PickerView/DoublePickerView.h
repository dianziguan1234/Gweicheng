//
//  DoublePickerView.h
//  LawMonkey
//
//  Created by 刘彬 on 16/3/26.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "BasePickerView.h"

@interface DoublePickerView : BasePickerView<UIPickerViewDelegate, UIPickerViewDataSource>
{

}

- (id)initWithTitle:(NSString *)title delegate:(id /*<UIActionSheetDelegate>*/)delegate mainColumData:(NSArray *)mainColumData subColumData:(NSArray *)subColumData;

@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, strong) NSArray *mainArray;
@property (nonatomic, strong) NSArray *subArray;


@property (nonatomic, copy) NSString *selectedMain;
@property (nonatomic, copy) NSString *selectedSub;

@end

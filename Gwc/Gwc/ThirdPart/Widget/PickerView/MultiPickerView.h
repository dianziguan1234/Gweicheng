//
//  MultiPickerView.h
//  LawMonkey
//
//  Created by 刘彬 on 16/3/26.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "BasePickerView.h"

@interface MultiPickerView : BasePickerView<UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSString *_idKey;
    NSString *_nameKey;
    NSString *_childKey;
    NSInteger _count;

    NSMutableDictionary *_selectedRows;
}

- (id)initWithDelegate:(id /*<UIActionSheetDelegate>*/)delegate data:(NSArray *)data count:(NSInteger)count;

- (id)initWithTitle:(NSString *)title delegate:(id /*<UIActionSheetDelegate>*/)delegate data:(NSArray *)data count:(NSInteger)count;

- (id)initWithTitle:(NSString *)title delegate:(id /*<UIActionSheetDelegate>*/)delegate data:(NSArray *)data count:(NSInteger)count idKey:(NSString *)idKey nameKey:(NSString *)nameKey childKey:(NSString *)childKey;

@property (nonatomic, strong) NSString *selectedChildKey;
@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSDictionary *selectedItem;

@end

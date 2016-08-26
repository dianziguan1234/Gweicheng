//
//  MultiPickerView.m
//  LawMonkey
//
//  Created by 刘彬 on 16/3/26.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "MultiPickerView.h"

@implementation MultiPickerView

- (id)initWithDelegate:(id /*<UIActionSheetDelegate>*/)delegate data:(NSArray *)data count:(NSInteger)count
{
    return [self initWithTitle:@"" delegate:delegate data:data count:count];
}

- (id)initWithTitle:(NSString *)title delegate:(id /*<UIActionSheetDelegate>*/)delegate data:(NSArray *)data count:(NSInteger)count
{
    return [self initWithTitle:title delegate:delegate data:data count:count idKey:@"identify" nameKey:@"name" childKey:@"childs"];
}

- (id)initWithTitle:(NSString *)title delegate:(id /*<UIActionSheetDelegate>*/)delegate data:(NSArray *)data count:(NSInteger)count idKey:(NSString *)idKey nameKey:(NSString *)nameKey childKey:(NSString *)childKey;
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
        
        self.data = data;
        _idKey = idKey;
        _nameKey = nameKey;
        _childKey = childKey;
    
        _count = count;
        _selectedRows = [[NSMutableDictionary alloc] init];
        self.selectedChildKey = @"child";
        
        // 初始都选择第0行
        for (NSInteger index = 0; index < count; index++) {
            [_selectedRows setObject:@(0) forKey:@(index)];
        }
    }
    
    return self;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return _count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self getDataWithComponent:component].count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *data = [self getDataWithComponent:component];
    
    return [[data objectAtIndex:row] objectForKey:_nameKey];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSInteger selectedRow = [[_selectedRows objectForKey:@(component)] integerValue];
    
    if (selectedRow == row) {
        return;
    }
    
    [_selectedRows setObject:@(row) forKey:@(component)];
    
    NSInteger itemRow = row;
    for (NSInteger index = component; index < _count - 1; index++) {
        NSArray *data = [self getDataWithComponent:index];
        
        if(data.count == 0) {
            [_selectedRows setObject:@(0) forKey:@(index + 1)];
            [self.picker reloadComponent:index + 1];
            continue;
        }
        
        NSDictionary *item = [data objectAtIndex:itemRow];
        NSArray *child = [item objectForKey:_childKey];
        
        if (child.count > 0) {
            [_selectedRows setObject:@(0) forKey:@(index + 1)];
            [self.picker selectRow:0 inComponent:index + 1 animated:NO];
            [self.picker reloadComponent:index + 1];
        } else {
            [_selectedRows setObject:@(0) forKey:@(index + 1)];
            [self.picker reloadComponent:index + 1];
        }
        
        itemRow = 0;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        pickerLabel.textColor = COLOR_NORMAL_TEXT;
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:16]];
    }
    
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (NSArray *)getDataWithComponent:(NSInteger)component
{
    NSArray *childs = self.data;
    
    for (NSUInteger index = 0; index < component; index ++) {
        if (childs.count > 0) {
            NSDictionary *item = [childs objectAtIndex:[[_selectedRows objectForKey:@(index)] integerValue]];
            childs = [item objectForKey:_childKey];
        }
    }
    
    return childs;
}

- (NSDictionary *)selectedItem
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    for (NSUInteger index = 0; index < _count; index++) {
        NSArray *data = [self getDataWithComponent:index];
        NSInteger row = [[_selectedRows objectForKey:@(index)] integerValue];

        if (data.count > row) {
            NSDictionary *item = [data objectAtIndex:row];
            
            NSMutableDictionary *result = [[NSMutableDictionary alloc] initWithDictionary:item];
            [result removeObjectForKey:_childKey];
            [results addObject:result];
        } else {
            break;
        }
    }
    
    for (NSInteger index = 0; index < results.count - 1; index++) {
        NSMutableDictionary *item = [results objectAtIndex:index];
        
        [item setObject:[results objectAtIndex:index + 1] forKey:self.selectedChildKey];
    }
    
    return results.count > 0 ? [results objectAtIndex:0] : nil;
}

- (void)setSelectedItem:(NSDictionary *)selectedItem
{
    NSDictionary *backup = selectedItem;
    for (NSInteger index = 0; index < _count; index++) {
        NSInteger row = 0;
        NSArray *child = [self getDataWithComponent:index];
        
        if (child.count > 0) {
            NSString *selectedId = [NSString stringWithFormat:@"%@", [backup objectForKey:_idKey]];
            NSString *selectedName = [backup objectForKey:_nameKey];
            
            for (NSDictionary *item in child) {
                NSString *ID = [NSString stringWithFormat:@"%@", [item objectForKey:_idKey]];
                NSString *name = [item objectForKey:_nameKey];
                
                if ((selectedId && ID && [selectedId isEqualToString:ID]) ||
                    (selectedName && name && [selectedName isEqualToString:name])) {
                    row = [child indexOfObject:item];
                    break;
                }
            }
        }
        
        [_selectedRows setObject:@(row) forKey:@(index)];
        [self.picker selectRow:row inComponent:index animated:NO];
        [self.picker reloadComponent:index];
        
        backup = [backup objectForKey:self.selectedChildKey];
    }
}

@end

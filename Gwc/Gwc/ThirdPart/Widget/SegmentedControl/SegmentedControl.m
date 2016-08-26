//
//  SegmentedControl.m
//  LawMonkey
//
//  Created by 刘彬 on 16/3/20.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "SegmentedControl.h"

#define kFlowViewHeightRadio 1 / 20.0f

#define kSeparatorMarginTop 7.0f
#define kFlowViewMarginLeft 0.0f

#define kMarginLeft 10
#define kFlowRoundHeight 20

@implementation SegmentedControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithTitles:(NSArray *)titles
{
    self = [super init];
    
    if (self) {
        self.selectedFlow = YES;
        self.backgroundColor = COLOR_APP_STYLE;
        
        _buttons = [[NSMutableArray alloc] init];
        
        for (id title in titles) {
            UIButton *button = [[UIButton alloc] init];
            [button setBackgroundColor:[UIColor clearColor]];
            [button addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchDown];
            [button.titleLabel setBackgroundColor:[UIColor clearColor]];
            button.titleLabel.font = Normal_Small_Font;
            [button setBackgroundImage:[UIImage nb_imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
            button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            [button setTitle:title forState:UIControlStateNormal];
            [self addSubview:button];
            [_buttons addObject:button];
        }
        
        self.titles = titles;
        
        _separatorViews = [[NSMutableArray alloc] init];
        
        for (NSUInteger i = 0; i < titles.count - 1; i++) {
            UIView *separatorView = [[UIView alloc] init];
            separatorView.backgroundColor = [UIColor whiteColor];
            
            [self addSubview:separatorView];
            [_separatorViews addObject:separatorView];
        }
        
        if (_buttons.count > 0) {
            [self selectWithIndex:0];
        }
        
        _flowView = [[UIImageView alloc] init];
        _flowView.backgroundColor = COLOR_APP_STYLE;

        _shadowLine = [UIImageView nb_lineWithWidth:kMainScreenWidth color:COLOR_TABLE_LINE];

        [self addSubview:_flowView];
        [self addSubview:_shadowLine];
        [self setStyle:SegmentedControlStyleRound];
        
        self.flowOffsetY = 0.5;
    }

    return self;
}

- (void)addBlurToView:(UIView *)view {
    UIView *blurView = nil;
    
//    if([UIBlurEffect class]) { // iOS 8
//        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//        blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//        blurView.frame = view.frame;
//        blurView.alpha = 0.98;
//    } else { // workaround for iOS 7
        blurView = [[UIToolbar alloc] initWithFrame:view.bounds];
//    }
    
    [blurView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [view insertSubview:blurView atIndex:0];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[blurView]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(blurView)]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[blurView]|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(blurView)]];
}

- (CGFloat)getTitleWidthAtIndex:(NSInteger)index
{
    id title = [_titles objectAtIndex:index];
    CGFloat width = 0;
    
    if ([title isKindOfClass:[NSAttributedString class]]) {
        width = [title nb_sizeWithMaxWidth:CGFLOAT_MAX].width;
    } else if ([title isKindOfClass:[NSString class]]) {
        width = [title length] > 0 ? [((NSString *)title) nb_sizeWithFont:(self.titleFont?self.titleFont:Normal_Font) maxWidth:CGFLOAT_MAX].width : 0;
    }

    return width;
}

- (void)autoResizeFrame:(CGFloat)minWidth
{
    NSInteger x = 0;
   
    for (NSUInteger i = 0; i < _titles.count; i++) {
        UIButton *button = [_buttons objectAtIndex:i];
        
        CGFloat width = [self getTitleWidthAtIndex:i];
        width += 2 * kMarginLeft;
        button.frame = CGRectMake(x, 0, width, self.frame.size.height);
        x += width;
        
        if (i != _titles.count - 1) {
            UIView *line = [_separatorViews objectAtIndex:i];
            CGFloat lineWidth = line.frame.size.width;
            line.frame = CGRectMake(x - lineWidth / 2.0f, line.frame.origin.y, line.frame.size.width, line.frame.size.height);
        }
    }
    
    if (x < minWidth) {
        CGFloat margin = (minWidth - (x - _titles.count * 2 * kMarginLeft)) / (_titles.count * 2);
        x = 0;
        for (NSUInteger i = 0; i < _titles.count; i++) {
            UIButton *button = [_buttons objectAtIndex:i];
            
            CGFloat width = [self getTitleWidthAtIndex:i];
            width += 2 * margin;
            
            button.frame = CGRectMake(x, 0, width, self.frame.size.height);
            x += width;
        
            if (i != _titles.count - 1) {
                UIView *line = [_separatorViews objectAtIndex:i];
                CGFloat lineWidth = line.frame.size.width;
                line.frame = CGRectMake(x - lineWidth / 2.0f, line.frame.origin.y, line.frame.size.width, line.frame.size.height);
            }
        }
    }
    
    [super setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, x, self.frame.size.height)];
    
    [self reCalculationFlowFrame];
}

- (void)setStyle:(SegmentedControlStyle)style
{
    _style = style;
    if (style == SegmentedControlStyleRound) {
        self.titleColor = COLOR_APP_STYLE;
        self.selectedTitleColor = [UIColor whiteColor];
        self.titleFont = Normal_Font;
        self.separatorColor = COLOR_APP_STYLE;
        
        self.selectedBackgroundColor = COLOR_APP_STYLE;
        self.backgroundColor = [UIColor whiteColor];
        self.selectedFlow = NO;
        self.separatorHidden = NO;
        [self.layer setMasksToBounds:YES];
        [self.layer setBorderColor:[COLOR_APP_STYLE CGColor]];
        [self.layer setBorderWidth:1.0f];
        [self.layer setCornerRadius:5.0f];
    } else if (style == SegmentedControlStyleFill) {
        self.titleColor = COLOR_NORMAL_SUBINFO_TEXT;
        self.selectedTitleColor = COLOR_NORMAL_TEXT;
        self.titleFont = Normal_Font;
        self.separatorColor = COLOR_APP_STYLE;
        self.backgroundColor = [UIColor whiteColor];
        self.selectedBackgroundColor = COLOR_SYSTEM_WHITE;
        _flowView.backgroundColor = COLOR_APP_STYLE;
        self.flowStyle = SegmentedControlFlowStyleLine;
        
        self.selectedFlow = YES;
        self.separatorHidden = YES;
        
        [self.layer setMasksToBounds:YES];
        [self.layer setBorderWidth:0.0f];
        [self.layer setCornerRadius:0.0f];
    } else {
        self.titleColor = COLOR_NORMAL_TEXT;
        self.selectedTitleColor = [UIColor whiteColor];
        self.titleFont = Normal_Font;
        self.separatorColor = COLOR_APP_STYLE;
        self.backgroundColor = [UIColor clearColor];
        self.selectedBackgroundColor = [UIColor clearColor];
        _flowView.backgroundColor = COLOR_APP_STYLE;
        self.flowStyle = SegmentedControlFlowStyleRound;
        
        self.selectedFlow = YES;
        self.separatorHidden = YES;
        
        [self.layer setMasksToBounds:YES];
        [self.layer setBorderWidth:0.0f];
        [self.layer setCornerRadius:0.0f];
    }
}

- (void)setFlowStyle:(SegmentedControlFlowStyle)flowStyle
{
    _flowStyle = flowStyle;
    
    if (self.flowStyle == SegmentedControlFlowStyleLine) {
        [_flowView.layer setCornerRadius:0];
        [self bringSubviewToFront:_flowView];
    } else if (self.flowStyle == SegmentedControlFlowStyleRound) {
        [_flowView.layer setCornerRadius:kFlowRoundHeight / 2];
        [self sendSubviewToBack:_flowView];
    } else {
        [_flowView.layer setCornerRadius:0];
        [self bringSubviewToFront:_flowView];
    }
    
    [_flowView.layer setMasksToBounds:YES];
    [self reCalculationFlowFrame];
}

- (void)setFlowImage:(UIImage *)flowImage
{
    _flowView.image = flowImage;
    
    if (_flowView.image) {
        _flowView.backgroundColor = [UIColor clearColor];
    } else {
        _flowView.backgroundColor = COLOR_APP_STYLE;
    }
    
    self.flowStyle = SegmentedControlFlowStyleCoustom;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex animate:(BOOL)animate
{
    _selectedIndex = selectedIndex;
    [self selectWithIndex:selectedIndex animate:animate];
}

- (void)selectWithIndex:(NSInteger)index
{
    [self selectWithIndex:index animate:YES];
}

- (void)selectWithIndex:(NSInteger)index animate:(BOOL)animate
{
    index = MIN(index, _buttons.count - 1);
    _selectedIndex = index;
    
    for (UIButton *button in _buttons) {
        button.enabled = YES;
        [button.titleLabel setFont:self.titleFont?self.titleFont:Normal_Font];
    }
    
    UIButton *selectedButton = [_buttons objectAtIndex:index];
    [selectedButton setEnabled:NO];
    [selectedButton.titleLabel setFont:self.selectedTitleFont?self.selectedTitleFont:Normal_Bold_Font];
    
    if (self.selectedFlow) {
        if (animate) {
            [UIView beginAnimations:@"flow" context:nil];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            
            [UIView animateWithDuration:0.2 animations:^{
                [self reCalculationFlowFrame];
            } completion:^(BOOL finished) {
                if (finished) {
                    
                }
            }];
            
            [UIView commitAnimations];
        } else {
            [self reCalculationFlowFrame];
        }
    }
}

- (NSString *)getSelectedTitle
{
    return [self.titles objectAtIndex:_selectedIndex];
}

- (void)buttonTouched:(UIButton *)button
{
    [self selectWithIndex:[_buttons indexOfObject:button]];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)setFrame:(CGRect)frame
{
    CGRect backupFrame = self.frame;
    [super setFrame:frame];
    
    if (CGSizeEqualToSize(backupFrame.size, frame.size)){
        return;
    }
//    [self addBlurToView:self];

    CGFloat width = frame.size.width / _buttons.count;
    
    for (NSUInteger i = 0 ; i < _buttons.count; i++) {
        UIButton *button = [_buttons objectAtIndex:i];
        button.frame = CGRectMake(i * width, 0, width, frame.size.height);
    }

    for (NSUInteger i = 0; i < _separatorViews.count; i++) {
        UIView *separatorView = [_separatorViews objectAtIndex:i];
        separatorView.frame = CGRectMake((i + 1) * width - 0.5f, 0, 1.0f, self.nb_height);
    }

    
    _marginX = width * 0.16;
    [self reCalculationFlowFrame];
    
    _shadowLine.frame = CGRectMake(0, self.nb_height - _shadowLine.nb_height, kMainScreenWidth, _shadowLine.nb_height);
}

- (void)reCalculationFlowFrame
{
    CGFloat flowHeight = 2;
    UIButton *selectedButton = [_buttons objectAtIndex:self.selectedIndex];
    CGRect frame = _flowView.frame;
    
    CGFloat titleWidth = [self getTitleWidthAtIndex:self.selectedIndex];
    
    if (self.flowStyle == SegmentedControlFlowStyleLine) {
        frame.size.height = flowHeight;
        frame.origin.y = self.frame.size.height - flowHeight - self.flowOffsetY;
        
        if (self.autoSelectedFlowWidth) {
            frame.origin.x = CGRectGetMinX(selectedButton.frame) + (selectedButton.nb_width - titleWidth) / 2;
            frame.size.width = titleWidth;
        } else {
            frame.origin.x = CGRectGetMinX(selectedButton.frame) + _marginX;
            frame.size.width = selectedButton.frame.size.width - 2 * _marginX;
        }
    } else if (self.flowStyle == SegmentedControlFlowStyleCoustom) {
        frame.size.height = _flowView.image.size.height;
        frame.size.width = _flowView.image.size.width;
        frame.origin.x = CGRectGetMinX(selectedButton.frame) + (selectedButton.nb_width - frame.size.width) / 2;
        frame.origin.y = (self.frame.size.height - frame.size.height + 0.5);
    } else {
        frame.size.height = kFlowRoundHeight;
        frame.origin.y = (self.frame.size.height - kFlowRoundHeight) / 2;
        frame.origin.x = CGRectGetMinX(selectedButton.frame) + (selectedButton.nb_width - titleWidth) / 2 - 8;
        frame.size.width = titleWidth + 16;
    }
    
    _flowView.frame = frame;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    [self selectWithIndex:selectedIndex];
}

- (void)setIcons:(NSArray *)icons
{
    _icons = icons;
    if (icons.count == _buttons.count) {
        for (NSUInteger i = 0; i < icons.count; i++) {
            UIImage *icon = [icons objectAtIndex:i];
            UIButton *button = [_buttons objectAtIndex:i];
            [button setImage:icon forState:UIControlStateNormal];
            [button setImage:icon forState:UIControlStateHighlighted];
        }
    }
}

- (void)setHighlightIcons:(NSArray *)highlightIcons
{
    _highlightIcons = highlightIcons;
    if (highlightIcons.count == _buttons.count) {
        for (NSUInteger i = 0; i < _highlightIcons.count; i++) {
            UIImage *icon = [highlightIcons objectAtIndex:i];
            UIButton *button = [_buttons objectAtIndex:i];
            [button setImage:icon forState:UIControlStateDisabled];
            [button setImage:icon forState:UIControlStateHighlighted];
        }
    }
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    for (UIButton *button in _buttons) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
}

- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor
{
    _selectedTitleColor = selectedTitleColor;
    for (UIButton *button in _buttons) {
        [button setTitleColor:selectedTitleColor forState:UIControlStateDisabled];
        [button setTitleColor:selectedTitleColor forState:UIControlStateHighlighted];
    }
}

- (void)setSelectedBackgroundColor:(UIColor *)selectedBackgroundColor
{
    _selectedBackgroundColor = selectedBackgroundColor;
    
    for (UIButton *button in _buttons) {
        [button setBackgroundImage:[UIImage nb_imageWithColor:selectedBackgroundColor] forState:UIControlStateDisabled];
        [button setBackgroundImage:[UIImage nb_imageWithColor:selectedBackgroundColor] forState:UIControlStateHighlighted];
    }
}

- (void)setTitles:(NSArray *)titles
{
    _titles = titles;
    for (NSUInteger i = 0; i < _titles.count; i++) {
        UIButton *button = _buttons[i];
        
        id title = _titles[i];
        
        if ([title isKindOfClass:[NSAttributedString class]]) {
            [button setAttributedTitle:_titles[i] forState:UIControlStateNormal];
        } else if ([title isKindOfClass:[NSString class]]) {
            [button setTitle:_titles[i] forState:UIControlStateNormal];
        }
    }
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    for (UIButton *button in _buttons) {
        [button.titleLabel setFont:titleFont];
    }
}

- (void)setTitleInsets:(UIEdgeInsets)titleInsets
{
    _titleInsets = titleInsets;
    for (UIButton *button in _buttons) {
        [button setTitleEdgeInsets:titleInsets];
    }
}

- (void)setImageInsets:(UIEdgeInsets)imageInsets
{
    _imageInsets = imageInsets;
    for (UIButton *button in _buttons) {
        [button setImageEdgeInsets:imageInsets];
    }
}

- (void)setSelectedFlow:(BOOL)selectedFlow
{
    _selectedFlow = selectedFlow;
    _flowView.hidden = !selectedFlow;
}

- (void)setSeparatorHidden:(BOOL)separatorHidden
{
    _separatorHidden = separatorHidden;
    for (UIView *view in _separatorViews) {
        view.hidden = _separatorHidden;
    }
}

- (void)setSeparatorColor:(UIColor *)separatorColor
{
    _separatorColor = separatorColor;
    for (UIView *view in _separatorViews) {
        view.backgroundColor = separatorColor;
    }
}


@end

//
//  UITextView+Placeholder.m
//  LawMonkey
//
//  Created by jason on 16/8/20.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "UITextView+Placeholder.h"

static const void *NBTextViewPlaceholderLabelKey = "NBTextViewPlaceholderLabelKey";
static const void *NBTextViewPlaceholderTextKey = "NBfTextViewPlaceholderTextKey";


@implementation UIApplication (Placeholder)

- (void)nb_placehoderTextChange:(NSNotification *)nofitication {
    UITextView *textView = nofitication.object;
    if ([textView isKindOfClass:[UITextView class]]) {
        if (![NSString nb_isEmpty:textView.text]) {
            textView.nb_placeholderLabel.text = @"";
        } else {
            textView.nb_placeholderLabel.text = textView.nb_placeholder;
        }
    }
}

@end

@interface UITextView ()

@property (nonatomic, strong) UILabel *placeholderLabel;

@end

@implementation UITextView (Placeholder)

- (void)setPlaceholderLabel:(UILabel *)placeholderLabel {
    objc_setAssociatedObject(self,
                             NBTextViewPlaceholderLabelKey,
                             placeholderLabel,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)placeholderLabel {
    UILabel *label = objc_getAssociatedObject(self, NBTextViewPlaceholderLabelKey);
    if (label == nil || ![label isKindOfClass:[UILabel class]]) {
        label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = self.font;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = COLOR_COMMON_TITLE;
        [self addSubview:label];
        
        lmweak(ws);
        self.placeholderLabel = label;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws).insets(UIEdgeInsetsMake(7.5, 7, 0, 0));
        }];
        label.enabled = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:[UIApplication sharedApplication]
                                                 selector:@selector(nb_placehoderTextChange:)
                                                     name:UITextViewTextDidChangeNotification
                                                   object:nil];
    }
    return label;
}

- (UILabel *)nb_placeholderLabel {
    return self.placeholderLabel;
}

- (void)setNb_placeholder:(NSString *)nb_placeholder {
    if ([NSString nb_isEmpty:nb_placeholder]) {
        objc_setAssociatedObject(self, NBTextViewPlaceholderLabelKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self.placeholderLabel removeFromSuperview];
        return;
    }
    
    objc_setAssociatedObject(self,
                             NBTextViewPlaceholderTextKey,
                             nb_placeholder,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    if (![NSString nb_isEmpty:self.text]) {
        self.placeholderLabel.text = nil;
    } else {
        self.placeholderLabel.text = nb_placeholder;
    }
}


- (NSString *)nb_placeholder {
    return objc_getAssociatedObject(self, NBTextViewPlaceholderTextKey);
}

- (void)setNb_placeholderColor:(UIColor *)nb_placeholderColor{
    self.placeholderLabel.textColor = nb_placeholderColor;
}

- (UIColor *)nb_placeholderColor {
    return self.placeholderLabel.textColor;
}

- (void)setNb_placeholderFont:(UIFont *)nb_placeholderFont {
    self.placeholderLabel.font = nb_placeholderFont;
}

- (UIFont *)nb_placeholderFont {
    return self.placeholderLabel.font;
}

@end

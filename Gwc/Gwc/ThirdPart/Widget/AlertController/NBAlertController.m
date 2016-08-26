//
//  NBAlertController.m
//  LawMonkey
//
//  Created by 刘彬 on 16/4/23.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "NBAlertController.h"
#import <objc/runtime.h>

@interface NSObject (alertController)
@property (nullable, nonatomic, strong) NBAlertController *alertController;
@end

@implementation NSObject (alertController)

@dynamic alertController;

-(void)setAlertController:(NBAlertController *)alertController {
    objc_setAssociatedObject(self, @selector(alertController), alertController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NBAlertController *)alertController {
    return objc_getAssociatedObject(self, @selector(alertController));
}

@end

@interface NBAlertAction ()
@property (nonnull, nonatomic, copy) NSString *title;
@property (nonatomic, assign) NBAlertActionStyle style;
@property (nonatomic, copy) void (^handler)(NBAlertAction *);
@property (nullable, nonatomic, weak) NBAlertController *controller;

-(void)performAction;
@end

@implementation NBAlertAction
+ (instancetype)actionWithTitle:(NSString *)title style:(NBAlertActionStyle)style handler:(void (^)(NBAlertAction * _Nonnull action))handler {
    NBAlertAction *action = [[NBAlertAction alloc] init];
    action.title = [title copy];
    action.style = style;
    action.handler = [handler copy];
    return action;
}

-(void)performAction {
    if (self.handler) {
        self.handler(self);
        self.handler = nil;
    }
}

@end


@interface NBAlertController () <UIAlertViewDelegate, UIActionSheetDelegate>

@property (nonnull,nonatomic,strong,readwrite) id adaptiveAlert;

@property (nonnull,nonatomic, readwrite) NSArray<NBAlertAction *> *actions;

@property (nullable, nonatomic, copy, readwrite) NSArray< void (^)(UITextField *textField)> *textFieldHandlers;

@property (nonatomic, readwrite) NBAlertControllerStyle preferredStyle;

@end

@implementation NBAlertController

#pragma mark - lifecycle

- (BOOL)alertControllerEnable {
    //return NSStringFromClass([UIAlertController class]);
    NSString *result = NSStringFromClass([UIAlertController class]);
    if ([NSString nb_isEmpty:result]) {
        return NO;
    } else {
        return YES;
    }
}

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(NBAlertControllerStyle)preferredStyle {
    return [[self alloc] initWithTitle:title message:message preferredStyle:preferredStyle];
}

+ (instancetype)actionSheetWithTitle:(nullable NSString *)title {
    return [[self alloc] initWithTitle:title message:nil preferredStyle:NBAlertControllerStyleActionSheet];
}

+ (instancetype)alertWithTitle:(nullable NSString *)title message:(nullable NSString *)message {
    return [[self alloc] initWithTitle:title message:message preferredStyle:NBAlertControllerStyleAlter];
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(NBAlertControllerStyle)preferredStyle {
    if (self = [super init]) {
        self.preferredStyle = preferredStyle;
        
        if ([self alertControllerEnable]) {
            self.adaptiveAlert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(NSInteger)preferredStyle];
        } else {
            switch (preferredStyle) {
                case NBAlertControllerStyleAlter:
                    self.adaptiveAlert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
                    break;
                case  NBAlertControllerStyleActionSheet:
                    self.adaptiveAlert = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
                    break;
                default:
                    break;
            }
        }
    }
    return self;
}

#pragma mark - function

-(void)nb_presentViewWithController:(UIViewController *)viewController {
    [self nb_presentViewWithController:viewController animated:YES completion:nil];
}

-(void)nb_presentViewWithController:(UIViewController *)viewController animated:(BOOL)flag completion:(void (^)(void))completion {
    if ([self alertControllerEnable]) {
        if (viewController == nil) {
            UIApplication *applection = [UIApplication performSelector: NSSelectorFromString(NSStringFromSelector(@selector(sharedApplication)))];
            viewController = applection.keyWindow.rootViewController;
            
            while (viewController.presentedViewController) {
                viewController = viewController.presentedViewController;
            }
            
            if (viewController == nil) {
                return;
            }
        }
        [viewController presentViewController:self.adaptiveAlert animated:flag completion:^{
            objc_setAssociatedObject(viewController, _cmd, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }];
    } else {
        self.alertController = self;
        if ([self.adaptiveAlert isKindOfClass:[UIAlertView class]]) {
            [self.textFieldHandlers enumerateObjectsUsingBlock:^(void (^configurationHandler)(UITextField *textField), NSUInteger idx, BOOL * _Nonnull stop) {
                configurationHandler([self.adaptiveAlert textFieldAtIndex:idx]);
            }];
            [self.adaptiveAlert show];
        } else if ([self.adaptiveAlert isKindOfClass:[UIActionSheet class]]) {
            [self.adaptiveAlert showInView:viewController.view];
        }
    }
    
    if (completion) {
        completion();
    }
}

-(void)addAction:(NBAlertAction *)action {
    action.controller = self;
    self.actions = [[NSArray arrayWithArray:self.actions] arrayByAddingObject:action];
    
    if ([self alertControllerEnable]) {
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:action.title style:(NSInteger)action.style handler:^(UIAlertAction * _Nonnull uiaction) {
            [action performAction];
        }];
        [(UIAlertController *)self.adaptiveAlert addAction:alertAction];
    } else {
        if (NBAlertControllerStyleActionSheet == self.preferredStyle) {
            UIActionSheet *actionSheet = (UIActionSheet *)self.adaptiveAlert;
            NSUInteger currentButtonIndex = [actionSheet addButtonWithTitle:action.title];
            
            if (action.style == NBAlertActionStyleDestructive) {
                actionSheet.destructiveButtonIndex = currentButtonIndex;
            } else if (action.style == NBAlertActionStyleCancel) {
                actionSheet.cancelButtonIndex = currentButtonIndex;
            }
        } else {
            UIAlertView *alertView = (UIAlertView *)self.adaptiveAlert;
            NSUInteger currentButtonIndex = [alertView addButtonWithTitle:action.title];
            if (action.style == NBAlertActionStyleCancel) {
                alertView.cancelButtonIndex = currentButtonIndex;
            }
        }
    }
}

-(void)addTextFieldWithConfigurationHandler:(void (^)(UITextField * textField))configurationHandler {
    if ([self alertControllerEnable]) {
        [(UIAlertController *)self.adaptiveAlert addTextFieldWithConfigurationHandler:configurationHandler];
    } else {
        NSAssert(self.preferredStyle == NBAlertControllerStyleAlter, @"textfield only support alter");
        self.textFieldHandlers = [[NSArray arrayWithArray:self.textFieldHandlers] arrayByAddingObject:configurationHandler];
        [(UIAlertView *)self.adaptiveAlert setAlertViewStyle: self.textFieldHandlers.count > 1? UIAlertViewStyleLoginAndPasswordInput : UIAlertViewStylePlainTextInput];
    }
}

- (NSArray<UITextField *> *)textFields
{
    if ([self alertControllerEnable]) {
        return ((UIAlertController *)self.adaptiveAlert).textFields;
    }
    else {
        if ([self.adaptiveAlert isKindOfClass:[UIAlertView class]]) {
            switch (((UIAlertView *)self.adaptiveAlert).alertViewStyle) {
                case UIAlertViewStyleDefault: {
                    return @[];
                    break;
                }
                case UIAlertViewStyleSecureTextInput: {
                    return @[[((UIAlertView *)self.adaptiveAlert) textFieldAtIndex:0]];
                    break;
                }
                case UIAlertViewStylePlainTextInput: {
                    return @[[((UIAlertView *)self.adaptiveAlert) textFieldAtIndex:0]];
                    break;
                }
                case UIAlertViewStyleLoginAndPasswordInput: {
                    return @[[((UIAlertView *)self.adaptiveAlert) textFieldAtIndex:0], [((UIAlertView *)self.adaptiveAlert) textFieldAtIndex:1]];
                    break;
                }
                default: {
                    break;
                }
            }
        }
        else {
            return nil;
        }
    }
}

#pragma mark - ActionSheetDelegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    __weak typeof(NBAlertAction) *weakAction = self.actions[buttonIndex];
    if (self.actions[buttonIndex]) {
        self.actions[buttonIndex].handler(weakAction);
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    self.alertController = nil;
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    self.alertController = nil;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    __weak typeof(NBAlertAction) *weakAction = self.actions[buttonIndex];
    if (self.actions[buttonIndex]) {
        self.actions[buttonIndex].handler(weakAction);
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    self.alertController = nil;
}

- (void)alertViewCancel:(UIAlertView *)alertView
{
    self.alertController = nil;
}

#pragma mark - property

- (NSString *)title
{
    return [self.adaptiveAlert title];
}

- (void)setTitle:(NSString *)title
{
    [self.adaptiveAlert setTitle:title];
}

- (NSString *)message
{
    return [self.adaptiveAlert message];
}

- (void)setMessage:(NSString *)message
{
    [self.adaptiveAlert setMessage:message];
}

- (UIAlertViewStyle)alertViewStyle
{
    if (![self alertControllerEnable] && [self.adaptiveAlert isKindOfClass:[UIAlertView class]]) {
        return [self.adaptiveAlert alertViewStyle];
    }
    return 0;
}

- (void)setAlertViewStyle:(UIAlertViewStyle)alertViewStyle
{
    if (![self alertControllerEnable] && [self.adaptiveAlert isKindOfClass:[UIAlertView class]]) {
        [self.adaptiveAlert setAlertViewStyle:alertViewStyle];
    }
}

- (NBAlertAction *)preferredAction
{
    if (kCurrentSystemVersion >= 9.0) {
        return (NBAlertAction *)[self.adaptiveAlert preferredAction];
    }
    return nil;
}

- (void)setPreferredAction:(NBAlertAction *)preferredAction
{
    if (kCurrentSystemVersion >= 9.0) {
        [self.adaptiveAlert setPreferredAction:preferredAction];
    }
}

@end

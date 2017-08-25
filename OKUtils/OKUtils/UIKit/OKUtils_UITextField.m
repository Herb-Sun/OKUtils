//
//  OKUtils_UITextField.m
//  OKUtils
//
//  Created by MAC on 2017/8/23.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import "OKUtils_UITextField.h"
#import <objc/runtime.h>

@implementation UITextField (OKUtils_Category)

- (BOOL)isMenuItemDisabled {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setMenuItemDisabled:(BOOL)menuItemDisabled {
    objc_setAssociatedObject(self, @selector(isMenuItemDisabled), @(menuItemDisabled), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (self.isMenuItemDisabled || self.isSecureTextEntry) {
        UIMenuController *menuCtrl = [UIMenuController sharedMenuController];
        if (menuCtrl) {
            menuCtrl.menuVisible = NO;
        }
        return NO;
    }
    return [super canPerformAction:action withSender:sender];
}

- (void)setPlaceholderColor:(UIColor *)color {
    if (color) [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)setPlaceholderFont:(UIFont *)font {
    if (font) [self setValue:font forKeyPath:@"_placeholderLabel.font"];
}

@end

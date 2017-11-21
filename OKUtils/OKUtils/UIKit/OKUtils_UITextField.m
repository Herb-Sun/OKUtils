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

- (OKMenuItemDisabledType)menuItemDisabledType {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setMenuItemDisabledType:(OKMenuItemDisabledType)menuItemDisabledType {
    objc_setAssociatedObject(self, @selector(menuItemDisabledType), @(menuItemDisabledType), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    if (self.isSecureTextEntry || (self.menuItemDisabledType & OKMenuItemDisabledTypeAll)) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    else {
        if (action == @selector(cut:)
            && (self.menuItemDisabledType & OKMenuItemDisabledTypeCut)) {
            return NO;
        }
        else if (action == @selector(copy:)
                 && (self.menuItemDisabledType & OKMenuItemDisabledTypeCopy)) {
            return NO;
        }
        else if (action == @selector(paste:)
                 && (self.menuItemDisabledType & OKMenuItemDisabledTypePaste)) {
            return NO;
        }
        else if (action == @selector(delete:)
                 && (self.menuItemDisabledType & OKMenuItemDisabledTypeDelete)) {
            return NO;
        }
        else if (action == @selector(select:)
                 && (self.menuItemDisabledType & OKMenuItemDisabledTypeSelect)) {
            return NO;
        }
        else if (action == @selector(selectAll:)
                 && (self.menuItemDisabledType & OKMenuItemDisabledTypeSelectAll)) {
            return NO;
        }
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

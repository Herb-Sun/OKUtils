//
//  OKUtils_UITextField.m
//  OKUtils
//
//  Created by MAC on 2017/8/23.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import "OKUtils_UITextField.h"

@implementation UITextField (OKUtils_Extension)

- (void)setPlaceholderColor:(UIColor *)color {
    if (color) [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)setPlaceholderFont:(UIFont *)font {
    if (font) [self setValue:font forKeyPath:@"_placeholderLabel.font"];
}

@end

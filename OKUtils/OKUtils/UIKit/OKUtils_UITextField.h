//
//  OKUtils_UITextField.h
//  OKUtils
//
//  Created by MAC on 2017/8/23.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSInteger, OKMenuItemDisabledType) {
    OKMenuItemDisabledTypeCut       = 1 << 0,
    OKMenuItemDisabledTypeCopy      = 1 << 1,
    OKMenuItemDisabledTypePaste     = 1 << 2,
    OKMenuItemDisabledTypeDelete    = 1 << 3,
    OKMenuItemDisabledTypeSelect    = 1 << 4,
    OKMenuItemDisabledTypeSelectAll = 1 << 5,
    OKMenuItemDisabledTypeAll       = 0xFF,
};

@interface UITextField (OKUtils_Category)

/// 是否禁用menuBar
@property (nonatomic, assign) OKMenuItemDisabledType menuItemDisabledType;

/// 设置placeholder 颜色
- (void)setPlaceholderColor:(UIColor *)color;

/// 设置placeholder 字体
- (void)setPlaceholderFont:(UIFont *)font;

@end


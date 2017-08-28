//
//  OKUtils_UIColor.h
//  OKUtils
//
//  Created by MAC on 2017/8/24.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/// 随机颜色

UIKIT_EXTERN UIColor *OKColor_Random(void);
/// 反转颜色
UIKIT_EXTERN UIColor *OKColor_Inverted(UIColor *color);

UIKIT_EXTERN UIColor *OKColor_RGB(CGFloat r, CGFloat g, CGFloat b);
UIKIT_EXTERN UIColor *OKColor_RGBA(CGFloat r, CGFloat g, CGFloat b, CGFloat a);

/// 16进制颜色
UIKIT_EXTERN UIColor *OKColor_Hex(unsigned int hex);
UIKIT_EXTERN UIColor *OKColor_HexA(unsigned int hex, CGFloat alpha);
UIKIT_EXTERN UIColor *OKColor_HexString(NSString *hexString);
UIKIT_EXTERN UIColor *OKColor_HexStringA(NSString *hexString, CGFloat alpha);

/// 渐变颜色
UIKIT_EXTERN UIColor *OKColor_Gradient(NSArray<UIColor *> *colors, CGFloat height);
/// 获取图片颜色
UIKIT_EXTERN UIColor *OKColorFromImage(UIImage *image);

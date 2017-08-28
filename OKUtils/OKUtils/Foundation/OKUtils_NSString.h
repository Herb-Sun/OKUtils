//
//  OKUtils_NSString.h
//  OKUtils
//
//  Created by MAC on 2017/8/23.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/// 是否空字符串
FOUNDATION_EXPORT BOOL OKStringEmpty(NSString *string);

/// 安全处理字符串 if string is nil return @""
FOUNDATION_EXPORT NSString *OKStringSafety(NSString *string);

/// 安全处理字符串 当string为空时 返回 占位字符串
FOUNDATION_EXPORT NSString *OKStringValid(NSString *string,  NSString *placeholder);

@interface NSString (OKUtils_Category)

- (CGFloat)widthWithFont:(UIFont *)font containerHeight:(CGFloat)containerHeight;
- (CGFloat)heightWithFont:(UIFont *)font containerWidth:(CGFloat)containerWidth;

/**
 *  计算字符串高度
 *
 *  @param font          字体大小
 *  @param containerSize 字体显示的区域
 *
 *  @return 字符串占用的区域
 */
- (CGSize)sizeWithFont:(UIFont *)font containerSize:(CGSize)containerSize;

@end

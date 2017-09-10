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
FOUNDATION_EXTERN BOOL OKStringEmpty(NSString *string);

/// 安全处理字符串 if string is nil return @""
FOUNDATION_EXTERN NSString *OKStringSafety(NSString *string);

/// 安全处理字符串 当string为空时 返回 占位字符串
FOUNDATION_EXTERN NSString *OKStringValid(NSString *string,  NSString *placeholder);

/**
 Create string from repeat string
 👉OKRepeat(@"a", 2) => @"aa"
 */
FOUNDATION_EXTERN NSString *OKRepeat(NSString *string, NSUInteger length);

@interface NSString (OKUtils_Category)

- (NSString *)padStart:(NSUInteger)length string:(NSString *)string;
- (NSString *)padEnd:(NSUInteger)length string:(NSString *)string;

- (NSString *)trim;
- (NSString *)trimWhiteSpace;
- (NSString *)trimStart;
- (NSString *)trimEnd;

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

//
//  OKUtils_NSString.h
//  OKUtils
//
//  Created by MAC on 2017/8/23.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 是否空字符串
FOUNDATION_EXTERN BOOL OKStringEmpty(NSString *string);

/// 安全处理字符串 if string is nil return @""
FOUNDATION_EXTERN NSString *OKStringSafety(NSString *string);

/// 安全处理字符串 当string为空时 返回 占位字符串
FOUNDATION_EXTERN NSString *OKStringValid(NSString *string,  NSString *placeholder);


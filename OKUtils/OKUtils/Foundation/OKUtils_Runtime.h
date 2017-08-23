//
//  OKUtils_Runtime.h
//  OKUtils
//
//  Created by MAC on 2017/8/23.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import <Foundation/Foundation.h>

// Check whether class belongs to mainbundle
FOUNDATION_EXTERN BOOL OKIsMainBundleClass(Class cls);

// Method swizzling
FOUNDATION_EXTERN void OKSwizzleClassMethod(Class cls, SEL original, SEL replacement);
FOUNDATION_EXTERN void OKSwizzleInstanceMethod(Class cls, SEL original, SEL replacement);

// Method adding
FOUNDATION_EXTERN BOOL OKAddClassMethod(Class toCls, Class fromCls, SEL sel);
FOUNDATION_EXTERN BOOL OKAddInstanceMethod(Class toCls, Class fromCls, SEL sel);

// Method replace
FOUNDATION_EXTERN void OKReplaceClassMethod(Class toCls, Class fromCls, SEL sel);
FOUNDATION_EXTERN void OKReplaceInstanceMethod(Class toCls, Class fromCls, SEL sel);

//
//  OKUtils_Runtime.h
//  OKUtils
//
//  Created by MAC on 2017/8/23.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import <Foundation/Foundation.h>

// Check whether class belongs to mainbundle
FOUNDATION_EXPORT BOOL OKIsMainBundleClass(Class cls);

// Method swizzling
FOUNDATION_EXPORT void OKSwizzleClassMethod(Class cls, SEL original, SEL replacement);
FOUNDATION_EXPORT void OKSwizzleInstanceMethod(Class cls, SEL original, SEL replacement);

// Method adding
FOUNDATION_EXPORT BOOL OKAddClassMethod(Class toCls, Class fromCls, SEL sel);
FOUNDATION_EXPORT BOOL OKAddInstanceMethod(Class toCls, Class fromCls, SEL sel);

// Method replace
FOUNDATION_EXPORT void OKReplaceClassMethod(Class toCls, Class fromCls, SEL sel);
FOUNDATION_EXPORT void OKReplaceInstanceMethod(Class toCls, Class fromCls, SEL sel);

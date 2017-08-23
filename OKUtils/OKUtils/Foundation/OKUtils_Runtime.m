//
//  OKUtils_Runtime.m
//  OKUtils
//
//  Created by MAC on 2017/8/23.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import "OKUtils_Runtime.h"
#import <objc/runtime.h>

BOOL OKIsMainBundleClass(Class cls)
{
    NSString *mainBundlePath = [NSBundle mainBundle].bundlePath;
    NSString *classBundlePath = [NSBundle bundleForClass:cls].bundlePath;
    return [mainBundlePath isEqualToString:classBundlePath];
}

void OKSwizzleClassMethod(Class cls, SEL original, SEL replacement)
{
    Method originalMethod = class_getClassMethod(cls, original);
    IMP originalImplementation = method_getImplementation(originalMethod);
    const char *originalArgTypes = method_getTypeEncoding(originalMethod);
    
    Method replacementMethod = class_getClassMethod(cls, replacement);
    IMP replacementImplementation = method_getImplementation(replacementMethod);
    const char *replacementArgTypes = method_getTypeEncoding(replacementMethod);
    
    if (class_addMethod(cls, original, replacementImplementation, replacementArgTypes)) {
        class_replaceMethod(cls, replacement, originalImplementation, originalArgTypes);
    } else {
        method_exchangeImplementations(originalMethod, replacementMethod);
    }
}

void OKSwizzleInstanceMethod(Class cls, SEL original, SEL replacement)
{
    Method originalMethod = class_getInstanceMethod(cls, original);
    IMP originalImplementation = method_getImplementation(originalMethod);
    const char *originalArgTypes = method_getTypeEncoding(originalMethod);
    
    Method replacementMethod = class_getInstanceMethod(cls, replacement);
    IMP replacementImplementation = method_getImplementation(replacementMethod);
    const char *replacementArgTypes = method_getTypeEncoding(replacementMethod);
    
    if (class_addMethod(cls, original, replacementImplementation, replacementArgTypes)) {
        class_replaceMethod(cls, replacement, originalImplementation, originalArgTypes);
    } else {
        method_exchangeImplementations(originalMethod, replacementMethod);
    }
}

BOOL OKAddClassMethod(Class toCls, Class fromCls, SEL sel)
{
    Method addMethod = class_getClassMethod(fromCls, sel);
    IMP addImplementation = method_getImplementation(addMethod);
    const char *addArgTpes = method_getTypeEncoding(addMethod);
    return class_addMethod(toCls, sel, addImplementation, addArgTpes);
}

BOOL OKAddInstanceMethod(Class toCls, Class fromCls, SEL sel)
{
    Method addMethod = class_getInstanceMethod(fromCls, sel);
    IMP addImplementation = method_getImplementation(addMethod);
    const char *addArgTpes = method_getTypeEncoding(addMethod);
    return class_addMethod(toCls, sel, addImplementation, addArgTpes);
}

void OKReplaceClassMethod(Class toCls, Class fromCls, SEL sel)
{
    Method replaceMethod = class_getClassMethod(fromCls, sel);
    IMP replaceImplementation = method_getImplementation(replaceMethod);
    const char *replaceArgTypes = method_getTypeEncoding(replaceMethod);
    class_replaceMethod(toCls, sel, replaceImplementation, replaceArgTypes);
}

void OKReplaceInstanceMethod(Class toCls, Class fromCls, SEL sel)
{
    Method replaceMethod = class_getInstanceMethod(fromCls, sel);
    IMP replaceImplementation = method_getImplementation(replaceMethod);
    const char *replaceArgTypes = method_getTypeEncoding(replaceMethod);
    class_replaceMethod(toCls, sel, replaceImplementation, replaceArgTypes);
}


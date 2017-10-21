//
//  OKMacro.h
//  OKUtils
//
//  Created by MAC on 2017/8/23.
//  Copyright © 2017年 HERB. All rights reserved.
//

#ifndef OKMacro_h
#define OKMacro_h

#pragma mark - LOG

#ifndef OKLOG_ENABLED
#define OKLOG_ENABLED DEBUG
#endif

#if OKLOG_ENABLED
    #define __OKLOG(s, ...) NSLog(@"%@",[NSString stringWithFormat:(s), ##__VA_ARGS__])
    #define OKLogV() __OKLOG(@"\n✅ {%@} %@ > %s Line:(%d)\n", [NSThread isMainThread] ? @"UI" : @"BG", \
                                [NSURL URLWithString:@__FILE__].lastPathComponent, __FUNCTION__, __LINE__)
    #define OKLog(s, ...) __OKLOG(@"\n✅ {%@} %@ > %s Line:(%d): %@ \n", \
                                    [NSThread isMainThread] ? @"UI" : @"BG", \
                                    [NSURL URLWithString:@__FILE__].lastPathComponent, \
                                    __FUNCTION__, __LINE__, \
                                    [NSString stringWithFormat:(s), ##__VA_ARGS__])
#else
    #define __OKLOG(s, ...) do{} while(0)
    #define OKLogV() do{} while(0)
    #define OKLog(...) do{} while(0)
#endif

#pragma mark - WEAK SELF

#ifndef OKWeakify
    #if __has_feature(objc_arc)
    #define OKWeakify(object) __weak __typeof__(object) weak##_##object = object;
    #else
    #define OKWeakify(object) __block __typeof__(object) block##_##object = object;
    #endif
#endif

#ifndef OKStrongify
    #if __has_feature(objc_arc)
    #define OKStrongify(object) __typeof__(object) object = weak##_##object;
    #else
    #define OKStrongify(object) __typeof__(object) object = block##_##object;
    #endif
#endif

#ifndef OKBLOCK_SAFE_EXEC
#define OKBLOCK_SAFE_EXEC(block, ...) if(block){block(__VA_ARGS__);}
#endif

#ifndef OKFormatString
#define OKFormatString(str, ...) [NSString stringWithFormat:str, ##__VA_ARGS__]
#endif

#ifndef OKExecOnce
#define OKExecOnce(block) \
{ \
static dispatch_once_t predicate = 0; \
dispatch_once(&predicate, block); \
}
#endif

#define OKTICK NSDate *startTime = [NSDate date];
#define OKTOCK NSLog(@"Time:%f", -[startTime timeIntervalSinceNow]);

#pragma mark - SIZE

#define OKSCREEN_RECT   ([[UIScreen mainScreen] bounds])
#define OKSCREEN_SIZE   ([UIScreen mainScreen].bounds.size)
#define OKSCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define OKSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#pragma mark - SINGLETON

#define OKSINGLETON_H + (instancetype)sharedInstance;
#define OKSINGLETON_H_(methodName) + (instancetype)methodName;
#define OKSINGLETON_M \
static id _instance = nil; \
+ (instancetype)sharedInstance { \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        if (_instance == nil) { _instance = [[self alloc] init]; } \
    }); \
    return _instance; \
} \
+ (instancetype)allocWithZone:(struct _NSZone *)zone { \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        if (_instance == nil) { _instance = [super allocWithZone:zone]; } \
    }); \
    return _instance; \
} \
+ (id)copyWithZone:(struct _NSZone *)zone { return _instance; } \
+ (id)mutableCopyWithZone:(struct _NSZone *)zone { return _instance; }

#define OKSINGLETON_M_(cls, methodName) \
static cls _instance = nil; \
+ (instancetype)methodName { \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        if (_instance == nil) { _instance = [[self alloc] init]; } \
    }); \
    return _instance; \
} \
+ (instancetype)allocWithZone:(struct _NSZone *)zone { \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
    if (_instance == nil) { _instance = [super allocWithZone:zone]; } \
    }); \
    return _instance; \
} \
+ (id)copyWithZone:(struct _NSZone *)zone { return _instance; } \
+ (id)mutableCopyWithZone:(struct _NSZone *)zone { return _instance; }

#endif /* OKMacro_h */

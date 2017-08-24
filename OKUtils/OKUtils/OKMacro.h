//
//  OKMacro.h
//  OKUtils
//
//  Created by MAC on 2017/8/23.
//  Copyright © 2017年 HERB. All rights reserved.
//

#ifndef OKMacro_h
#define OKMacro_h

#ifndef OKLOG_ENABLED
#define OKLOG_ENABLED DEBUG
#endif

#if defined(DEBUG) && !defined(NDEBUG)
#define OKKeywordify autoreleasepool {}
#else
#define OKKeywordify try {} @finally {}
#endif

#if OKLOG_ENABLED
    #define __OKLOG(s, ...) NSLog(@"%@",[NSString stringWithFormat:(s), ##__VA_ARGS__])
    #define OKLogV() __OKLOG(@"\n✅ {%@} %@ > %s Line:(%d)\n", [NSThread isMainThread] ? @"UI" : @"BG", \
                                [NSURL URLWithString:@__FILE__].lastPathComponent, __FUNCTION__, __LINE__)
    #define OKLog(id, ...) __OKLOG(@"\n✅ {%@} %@ > %s Line:(%d): %@ \n", \
                                    [NSThread isMainThread] ? @"UI" : @"BG", \
                                    [NSURL URLWithString:@__FILE__].lastPathComponent, \
                                    __FUNCTION__, __LINE__, \
                                    [NSString stringWithFormat:(id), ##__VA_ARGS__])
#else
    #define OKLogV() do{} while(0)
    #define OKLog(...) do{} while(0)
#endif

#define weakify(self) \
    OKKeywordify \
    __weak typeof(self) OKWeak_##self = self;

#define strongify(self) \
    OKKeywordify \
    _Pragma("clang diagnostic push") \
    _Pragma("clang diagnostic ignored \"-Wshadow\"") \
    __strong typeof(self) self = OKWeak_##self; \
    _Pragma("clang diagnostic pop")


#define OKTABBAR_H        49.0f
#define OKSTATUSBAR_H     20.0f
#define OKNAVBAR_H        64.5f

#define OKTICK NSDate *startTime = [NSDate date];
#define OKTOCK NSLog(@"Time:%f", -[startTime timeIntervalSinceNow]);

/** 获取屏幕尺寸、宽度、高度 */
#define OKSCREEN_RECT   ([[UIScreen mainScreen] bounds])
#define OKSCREEN_SIZE   ([UIScreen mainScreen].bounds.size)
#define OKSCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define OKSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

/// 安全执行block
#define OKBLOCK_SAFE_EXEC(block, ...) if(block){block(__VA_ARGS__);}
#define OKFormatString(str,...) [NSString stringWithFormat:str, ##__VA_ARGS__]

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

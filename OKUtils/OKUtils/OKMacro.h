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
#define OKLOG_ENABLED 1
#endif

#ifdef OKLOG_ENABLED
#define __OKLOG(s, ...) NSLog(@"%@",[NSString stringWithFormat:(s), ##__VA_ARGS__])
#define OKLog(id, ...) __OKLOG(@"😱OKLog-> %s::%s::Line:(%d):%@ \n", __FILE__, __FUNCTION__, \
__LINE__, [NSString stringWithFormat:(id), ##__VA_ARGS__])
#else
#define OKLog(...) do{} while(0)
#endif

/// 安全执行block
#define OKBLOCK_SAFE_EXEC(block, ...) if(block){block(__VA_ARGS__);}
#define OKFormatString(str,...) [NSString stringWithFormat:str, ##__VA_ARGS__]

#define OKSINGLETON_H + (instancetype)sharedInstance;

#define OKSINGLETON_M \
static id _instance = nil; \
+ (instancetype)sharedInstance { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
if (_instance == nil) { _instance = [[self alloc] init]; } \
}); \
return _instance; } \
+ (instancetype)allocWithZone:(struct _NSZone *)zone { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
if (_instance == nil) { _instance = [super allocWithZone:zone]; } \
}); \
return _instance; } \
+ (id)copyWithZone:(struct _NSZone *)zone { return _instance; } \
+ (id)mutableCopyWithZone:(struct _NSZone *)zone { return _instance; }

#endif /* OKMacro_h */

//
//  OKUtils_NSBundle.m
//  OKUtils
//
//  Created by MAC on 2017/8/24.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import "OKUtils_NSBundle.h"

/// 获取当前语言
NSString *OKCurrentLanguage(void)
{
    return [[NSLocale preferredLanguages] objectAtIndex:0];
}

/// 获取APP名称
NSString *OKAPP_NAME(void)
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

/// 获取APP版本
NSString *OKAPP_VERSION(void)
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

/// 获取APP build版本
NSString *OKAPP_BUILD(void)
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

/// 获取Documents目录
NSString *OKDocumentsPath(void)
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

/// 获得Documents下指定文件名的文件路径
NSString *OKDocumentFilePath(NSString *fileName)
{
    return [OKDocumentsPath() stringByAppendingPathComponent:fileName];
}

/// 获取Library目录
NSString *OKLibraryPath(void)
{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
}

/// 获取Caches目录
NSString *OKCachesPath(void)
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}

/// references 目录包含应用程序的偏好设置文件
NSString *OKLibraryOreferencePath(void)
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return paths.count > 0 ? [[paths firstObject] stringByAppendingFormat:@"/Preferences"] : @"undefined";
}

/// 获取Tmp目录
NSString *OKTmpPath(void)
{
    return NSTemporaryDirectory();
}

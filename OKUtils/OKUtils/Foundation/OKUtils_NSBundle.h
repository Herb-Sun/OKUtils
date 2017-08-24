//
//  OKUtils_NSBundle.h
//  OKUtils
//
//  Created by MAC on 2017/8/24.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 获取当前语言
FOUNDATION_EXTERN NSString *OKCurrentLanguage(void);
/// 获取APP名称
FOUNDATION_EXTERN NSString *OKAPP_NAME(void);
/// 获取APP版本
FOUNDATION_EXTERN NSString *OKAPP_VERSION(void);
/// 获取APP build版本
FOUNDATION_EXTERN NSString *OKAPP_BUILD(void);

/// 获取Documents目录
FOUNDATION_EXTERN NSString *OKDocumentsPath(void);
/// 获得Documents下指定文件名的文件路径
FOUNDATION_EXTERN NSString *OKDocumentFilePath(NSString *fileName);
/// 获取Library目录
FOUNDATION_EXTERN NSString *OKLibraryPath(void);
/// 获取Caches目录
FOUNDATION_EXTERN NSString *OKCachesPath(void);
/// 获取Tmp目录
FOUNDATION_EXTERN NSString *OKTmpPath(void)

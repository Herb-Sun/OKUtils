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

/// 获取Documents目录 [苹果建议将程序中建立的或在程序中浏览到的文件数据保存在该目录下，iTunes备份和恢复的时候会包括此目录]
FOUNDATION_EXTERN NSString *OKDocumentsPath(void);
/// 获得Documents下指定文件名的文件路径
FOUNDATION_EXTERN NSString *OKDocumentFilePath(NSString *fileName);
/// 获取Library目录 [存储程序的默认设置或其它状态信息]
FOUNDATION_EXTERN NSString *OKLibraryPath(void);
/// 获取Caches目录 [存放缓存文件，iTunes不会备份此目录，此目录下文件不会在应用退出删除]
FOUNDATION_EXTERN NSString *OKCachesPath(void);
/// references 目录包含应用程序的偏好设置文件
FOUNDATION_EXTERN NSString *OKLibraryOreferencePath(void);
/// 获取Tmp目录
FOUNDATION_EXTERN NSString *OKTmpPath(void);

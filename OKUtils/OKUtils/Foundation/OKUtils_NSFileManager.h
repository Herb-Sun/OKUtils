//
//  OKUtils_NSFileManager.h
//  OKUtils
//
//  Created by MAC on 2017/8/25.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 该文件夹下所有文件的文件名及文件夹名的数组
FOUNDATION_EXPORT NSArray *OKAllFilesByPath(NSString *path);
/// 在path目录下创建文件
FOUNDATION_EXPORT BOOL OKCreateFile(NSString *path, NSString *fileName);
/// 在path目录下创建文件夹
FOUNDATION_EXPORT BOOL OKCreateDirectory(NSString *path, NSString *dirName);
/// 计算文件夹size
FOUNDATION_EXPORT unsigned long long OKFolderSize(NSString *folderPath);

/// 读取文件
FOUNDATION_EXPORT NSData *OKReadFile(NSString *path, NSString *fileName);
/// 写文件
FOUNDATION_EXPORT void OKWriteFile(NSData *data, NSString *path, NSString *fileName);
/// 追加数据
FOUNDATION_EXPORT void OKAppendFile(NSData *data, NSString *path, NSString *fileName);

/// 所有mime 类型
FOUNDATION_EXPORT NSDictionary *OKAllMIME(void);

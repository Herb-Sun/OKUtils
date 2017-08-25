//
//  OKUtils_UIDevice.h
//  OKUtils
//
//  Created by MAC on 2017/8/23.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/// 判断是否为iPhone
UIKIT_EXTERN BOOL isiPhone(void);
/// 判断是否是iPad
UIKIT_EXTERN BOOL isiPad(void);
/// 是否是iTV
UIKIT_EXTERN BOOL isiTV(void);
/// 判断是否为iPod
UIKIT_EXTERN BOOL isiPod(void);
/// 判断是否 Retina屏
UIKIT_EXTERN BOOL isRetina(void);

UIKIT_EXTERN NSString *OKDeviceName(void);
/// 获取设备电量级别
UIKIT_EXTERN float OKBatteryLevel(void);
UIKIT_EXTERN NSString *OKIPAddress(void);
UIKIT_EXTERN NSString *OKMacAddress(void);

/// CPU个数
UIKIT_EXTERN NSUInteger OKCPU_Number(void);
/// CUP 频率
UIKIT_EXTERN NSUInteger OKCPU_FREQ(void);
/// 总线频率
UIKIT_EXTERN NSUInteger OKBUS_FREQ(void);
/// 物理内存size
UIKIT_EXTERN NSUInteger OKPhysicalRamSize(void);
/// 内存大小
UIKIT_EXTERN NSUInteger OKTotalMemorySize(void);
UIKIT_EXTERN long long OKFreeDiskSpace(void);
UIKIT_EXTERN long long OKTotalDiskSpace(void);










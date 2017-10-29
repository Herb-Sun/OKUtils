//
//  OKUtils_UIDevice.m
//  OKUtils
//
//  Created by MAC on 2017/8/23.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import "OKUtils_UIDevice.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import <AdSupport/AdSupport.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <sys/socket.h>
#import <sys/param.h>
#import <sys/mount.h>
#import <sys/stat.h>
#import <sys/utsname.h>
#import <net/if.h>
#import <net/if_dl.h>
#import <mach/mach.h>
#import <mach/mach_host.h>
#import <mach/processor_info.h>

BOOL OKIsiPhone4Inch(void) {
    return [UIScreen instancesRespondToSelector:@selector(currentMode)] ? [[UIScreen mainScreen] currentMode].size.width == 640 : NO;
}

/// 判断是否为iPhone
BOOL OKIsiPhone(void)
{
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
}

/// 判断是否是iPad
BOOL OKIsiPad(void)
{
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
}

/// 是否是iTV
BOOL OKIsiTV(void)
{
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomTV;
}

/// 判断是否为iPod
BOOL OKIsiPod(void)
{
    return [[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"];
}

/// 判断是否 Retina屏
BOOL OKIsRetina(void)
{
    return [[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)]
    && ([UIScreen mainScreen].scale == 2.0f);
}

NSString *OKDeviceName(void)
{
    static NSDictionary *deviceCode = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        deviceCode = @{
                       @"iPod1,1" : @"iPod Touch 1G",
                       @"iPod2,1" : @"iPod Touch 2G",
                       @"iPod3,1" : @"iPod Touch 3G",
                       @"iPod4,1" : @"iPod Touch 4G",
                       @"iPod5,1" : @"iPod Touch 5G",
                       @"iPod7,1" : @"iPod Touch 6G",
                       
                       @"iPhone1,1" : @"iPhone 1G",
                       @"iPhone1,2" : @"iPhone 3G",
                       @"iPhone2,1" : @"iPhone 3GS",
                       @"iPhone3,1" : @"iPhone 4",
                       @"iPhone3,2" : @"iPhone 4",
                       @"iPhone3,3" : @"iPhone 4",
                       @"iPhone4,1" : @"iPhone 4S",
                       @"iPhone5,1" : @"iPhone 5",
                       @"iPhone5,2" : @"iPhone 5",
                       @"iPhone5,3" : @"iPhone 5C",
                       @"iPhone5,4" : @"iPhone 5C",
                       @"iPhone6,1" : @"iPhone 5S",
                       @"iPhone6,2" : @"iPhone 5S",
                       @"iPhone7,1" : @"iPhone 6P",
                       @"iPhone7,2" : @"iPhone 6",
                       @"iPhone8,1" : @"iPhone 6S",
                       @"iPhone8,2" : @"iPhone 6SP",
                       @"iPhone8,3" : @"iPhone SE",
                       @"iPhone8,4" : @"iPhone SE",
                       @"iPhone9,1" : @"iPhone 7",
                       @"iPhone9,2" : @"iPhone 7P",
                       @"iPhone9,3" : @"iPhone 7",
                       @"iPhone9,4" : @"iPhone 7P",
                       @"iPhone10,1" : @"iPhone 8",
                       @"iPhone10,2" : @"iPhone 8",
                       @"iPhone10,3" : @"iPhone X",
                       @"iPhone10,4" : @"iPhone 8",
                       @"iPhone10,5" : @"iPhone 8P",
                       @"iPhone10,6" : @"iPhone X",
                       
                       @"iPad1,1" : @"iPad",
                       @"iPad1,2" : @"iPad 3G",
                       @"iPad2,1" : @"iPad 2",
                       @"iPad2,2" : @"iPad 2",
                       @"iPad2,3" : @"iPad 2",
                       @"iPad2,4" : @"iPad 2",
                       @"iPad2,5" : @"iPad Mini",
                       @"iPad2,6" : @"iPad Mini",
                       @"iPad2,7" : @"iPad Mini",
                       @"iPad3,1" : @"iPad 3",
                       @"iPad3,2" : @"iPad 3",
                       @"iPad3,3" : @"iPad 3",
                       @"iPad3,4" : @"iPad 4",
                       @"iPad3,5" : @"iPad 4",
                       @"iPad3,6" : @"iPad 4",
                       @"iPad4,1" : @"iPad Air",
                       @"iPad4,2" : @"iPad Air",
                       @"iPad4,3" : @"iPad Air",
                       @"iPad4,4" : @"iPad Mini 2",
                       @"iPad4,5" : @"iPad Mini 2",
                       @"iPad4,7" : @"iPad Mini 3",
                       @"iPad4,8" : @"iPad Mini 3",
                       @"iPad4,9" : @"iPad Mini 3",
                       @"iPad5,1" : @"iPad Mini 4",
                       @"iPad5,2" : @"iPad Mini 3",
                       @"iPad5,3" : @"iPad Air 2",
                       @"iPad5,4" : @"iPad Air 2",
                       @"iPad6,3" : @"iPad Pro",
                       @"iPad6,4" : @"iPad Pro",
                       @"iPad6,7" : @"iPad Pro",
                       @"iPad6,8" : @"iPad Pro",
                       @"iPad6,11" : @"iPad 5",
                       @"iPad6,12" : @"iPad 5",
                       @"iPad7,1" : @"iPad Pro",
                       @"iPad7,2" : @"iPad Pro",
                       @"iPad7,3" : @"iPad Pro",
                       @"iPad7,4" : @"iPad Pro",
                       
                       @"AppleTV2,1" : @"iTV 2",
                       @"AppleTV3,1" : @"iTV 3",
                       @"AppleTV3,2" : @"iTV 3",
                       @"AppleTV5,3" : @"iTV 4",
                       
                       @"i386" : @"Simulator",
                       @"x86_64" : @"Simulator",
                       };
    });
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *code = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSString *deviceName = deviceCode[code];
    return deviceName ?: @"Unknown device";
}


NSString *OKDeviceAbsoluteName(void)
{
    static NSDictionary *absoluteDeviceCode = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        absoluteDeviceCode = @{
                               @"iPod1,1" : @"iPod Touch (Original)",
                               @"iPod2,1" : @"iPod Touch (Second Generation)",
                               @"iPod3,1" : @"iPod Touch (Third Generation)",
                               @"iPod4,1" : @"iPod Touch (Fourth Generation)",
                               @"iPod5,1" : @"iPod Touch (Fifth Generation)",
                               
                               @"iPhone1,1" : @"iPhone 1G",
                               @"iPhone1,2" : @"iPhone 3G",
                               @"iPhone2,1" : @"iPhone 3GS",
                               @"iPhone3,1" : @"iPhone 4 (GSM)",
                               @"iPhone3,2" : @"iPhone 4 (GSM Rev. A)",
                               @"iPhone3,3" : @"iPhone 4 (CDMA)",
                               @"iPhone4,1" : @"iPhone 4S",
                               @"iPhone5,1" : @"iPhone 5 (GSM)",
                               @"iPhone5,2" : @"iPhone 5 (Global)",
                               @"iPhone5,3" : @"iPhone 5C (GSM)",
                               @"iPhone5,4" : @"iPhone 5C (Global)",
                               @"iPhone6,1" : @"iPhone 5S (GSM)",
                               @"iPhone6,2" : @"iPhone 5S (Global)",
                               @"iPhone7,1" : @"iPhone 6 Plus",
                               @"iPhone7,2" : @"iPhone 6",
                               @"iPhone8,1" : @"iPhone 6s",
                               @"iPhone8,2" : @"iPhone 6s Plus",
                               @"iPhone8,3" : @"iPhone SE",
                               @"iPhone8,4" : @"iPhone SE",
                               @"iPhone9,1" : @"iPhone 7 (A1660/A1779/A1780)",
                               @"iPhone9,2" : @"iPhone 7 Plus (A1661/A1785/A1786)",
                               @"iPhone9,3" : @"iPhone 7 (A1778)",
                               @"iPhone9,4" : @"iPhone 7 Plus (A1784)",
                               @"iPhone10,1" : @"iPhone 8",
                               @"iPhone10,2" : @"iPhone 8",
                               @"iPhone10,3" : @"iPhone X",
                               @"iPhone10,4" : @"iPhone 8",
                               @"iPhone10,5" : @"iPhone 8P",
                               @"iPhone10,6" : @"iPhone X",
                               
                               @"iPad1,1" : @"iPad (WiFi)",
                               @"iPad1,2" : @"iPad 3G",
                               @"iPad2,1" : @"iPad 2 (WiFi)",
                               @"iPad2,2" : @"iPad 2 (GSM)",
                               @"iPad2,3" : @"iPad 2 (CDMA)",
                               @"iPad2,4" : @"iPad 2 (WiFi Rev. A)",
                               @"iPad2,5" : @"iPad Mini (WiFi)",
                               @"iPad2,6" : @"iPad Mini (GSM)",
                               @"iPad2,7" : @"iPad Mini (CDMA)",
                               @"iPad3,1" : @"iPad 3 (WiFi)",
                               @"iPad3,2" : @"iPad 3 (CDMA)",
                               @"iPad3,3" : @"iPad 3 (Global)",
                               @"iPad3,4" : @"iPad 4 (WiFi)",
                               @"iPad3,5" : @"iPad 4 (CDMA)",
                               @"iPad3,6" : @"iPad 4 (Global)",
                               @"iPad4,1" : @"iPad Air (WiFi)",
                               @"iPad4,2" : @"iPad Air (WiFi+GSM)",
                               @"iPad4,3" : @"iPad Air (WiFi+CDMA)",
                               @"iPad4,4" : @"iPad Mini Retina (WiFi)",
                               @"iPad4,5" : @"iPad Mini Retina (WiFi+CDMA)",
                               @"iPad4,7" : @"iPad Mini 3 (Wifi)",
                               @"iPad4,8" : @"iPad Mini 3 (Cellular)",
                               @"iPad4,9" : @"iPad Mini 3 (Cellular)",
                               @"iPad5,1" : @"iPad Mini 4 (Wifi)",
                               @"iPad5,2" : @"iPad Mini 3 (Cellular)",
                               @"iPad5,3" : @"iPad Air 2 (Wifi)",
                               @"iPad5,4" : @"iPad Air 2 (Cellular)",
                               @"iPad6,3" : @"iPad Pro 97inch (Wifi)",
                               @"iPad6,4" : @"iPad Pro 97inch (Cellular)",
                               @"iPad6,7" : @"iPad Pro 129inch (Wifi)",
                               @"iPad6,8" : @"iPad Pro 129inch (Cellular)",
                               @"iPad6,11" : @"iPad 5 (Wifi)",
                               @"iPad6,12" : @"iPad 5 (Cellular)",
                               @"iPad7,1" : @"iPad Pro 129inch (Wifi)",
                               @"iPad7,2" : @"iPad Pro 129inch (Cellular)",
                               @"iPad7,3" : @"iPad Pro 105inch (Wifi)",
                               @"iPad7,4" : @"iPad Pro 105inch (Cellular)",
                               
                               @"AppleTV2,1" : @"iTV 2",
                               @"AppleTV3,1" : @"iTV 3",
                               @"AppleTV3,2" : @"iTV 3",
                               @"AppleTV5,3" : @"iTV 4",
                               
                               @"i386" : @"Simulator",
                               @"x86_64" : @"Simulator",
                               };
    });
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *code = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSString *deviceName = absoluteDeviceCode[code];
    
    return deviceName ?: @"Unknown device";
}

// 获取设备电量级别
float OKBatteryLevel(void)
{
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    float deviceLevel = [UIDevice currentDevice].batteryLevel;
    [UIDevice currentDevice].batteryMonitoringEnabled = NO;
    return deviceLevel;
}

NSString *OKIPAddress(void)
{
    NSString *address = @"";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    success = getifaddrs(&interfaces);
    if (success == 0) {
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    freeifaddrs(interfaces);
    return address;
}


NSString *OKMacAddress(void)
{
    int                mib[6];
    size_t             len;
    char               *buf;
    unsigned char      *ptr;
    struct if_msghdr   *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return nil;
    }
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return nil;
    }
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. Rrror!\n");
        return nil;
    }
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return nil;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *macAddr = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    return macAddr;
}

NSString *OKIDFA(void) {
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

NSDate *OKLastestSystemUptime(void) {
    NSTimeInterval time = [[NSProcessInfo processInfo] systemUptime];
    return [[NSDate alloc] initWithTimeIntervalSinceNow:(0 - time)];
}

// 获取设备内存容量 (待优化)
NSString *deviceRam() {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString* code = [NSString stringWithCString:systemInfo.machine
                                        encoding:NSUTF8StringEncoding];
    static NSDictionary* deviceRamByCode = nil;
    if (!deviceRamByCode) {
        deviceRamByCode = @{@"i386"      :@"Simulator",
                            @"x86_64"    :@"Simulator",
                            @"iPod1,1"   :@"128M",      // (Original)
                            @"iPod2,1"   :@"128M",      // (Second Generation)
                            @"iPod3,1"   :@"256M",      // (Third Generation)
                            @"iPod4,1"   :@"256M",      // (Fourth Generation)
                            @"iPod5,1"   :@"512M",      // (Fifth Generation)
                            @"iPad1,1"   :@"256M",            // (Original)
                            @"iPad2,1"   :@"512M",          //
                            @"iPad2,5"   :@"512M",       // (Original)
                            @"iPad3,1"   :@"1G",            // (3rd Generation)
                            @"iPad3,4"   :@"1G",            // (4th Generation)
                            @"iPad4,1"   :@"1G",        // 5th Generation iPad (iPad Air) - Wifi
                            @"iPad4,2"   :@"1G",        // 5th Generation iPad (iPad Air) - Cellular
                            @"iPad4,4"   :@"1G",       // (2nd Generation iPad Mini - Wifi)
                            @"iPad4,5"   :@"1G",        // (2nd Generation iPad Mini - Cellular)
                            @"iPhone1,1" :@"128M",          // (Original)
                            @"iPhone1,2" :@"128M",          // (3G)
                            @"iPhone2,1" :@"256M",          // (3GS)
                            @"iPhone3,1" :@"512M",        // (GSM) 4
                            @"iPhone3,3" :@"512M",        // (CDMA/Verizon/Sprint) 4
                            @"iPhone4,1" :@"512M",       // 4s
                            @"iPhone5,1" :@"1G",        // (model A1428, AT&T/Canada) 5
                            @"iPhone5,2" :@"1G",        // (model A1429, everything else) 5
                            @"iPhone5,3" :@"1G",       // (model A1456, A1532 | GSM) 5c
                            @"iPhone5,4" :@"1G",       // (model A1507, A1516, A1526 (China), A1529 | Global) 5c
                            @"iPhone6,1" :@"1G",       // (model A1433, A1533 | GSM) 5s
                            @"iPhone6,2" :@"1G",       // (model A1457, A1518, A1528 (China), A1530 | Global) 5s
                            @"iPhone7,1" :@"1G",       // 6 P
                            @"iPhone7,2" :@"1G",        // 6
                            @"iPhone8,1" :@"2G",        // 6s P
                            @"iPhone8,2" :@"2G",        // 6s
                            };
    }
    NSString* deviceRam = [deviceRamByCode objectForKey:code];
    if (!deviceRam) {
        // Not found on database. At least guess main device type from string contents:
        if ([code rangeOfString:@"iPod"].location != NSNotFound) {
            deviceRam = @"unknown iPod ram";
        }
        else if([code rangeOfString:@"iPad"].location != NSNotFound) {
            deviceRam = @"unknown iPad ram";
        }
        else if([code rangeOfString:@"iPhone"].location != NSNotFound){
            deviceRam = @"unknown iPhone ram";
        }else{
            deviceRam = @"unknown device, maybe simulator";
        }
    }
    return deviceRam;
}

NS_INLINE NSUInteger __OKGetSystemInfo(uint typeSpecifier)
{
    size_t size = sizeof(int);
    int result;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &result, &size, NULL, 0);
    return (NSUInteger)result;
}


/// CPU个数
NSUInteger OKCPU_Number(void) { return __OKGetSystemInfo(HW_NCPU); }
/// CUP 频率
NSUInteger OKCPU_FREQ(void) { return __OKGetSystemInfo(HW_CPU_FREQ); }
/// 总线频率
NSUInteger OKBUS_FREQ(void) { return __OKGetSystemInfo(HW_BUS_FREQ); }
/// 物理内存size
NSUInteger OKPhysicalRamSize(void) { return __OKGetSystemInfo(HW_MEMSIZE); }
/// 内存大小
NSUInteger OKTotalMemorySize(void) { return __OKGetSystemInfo(HW_PHYSMEM); }

long long OKFreeDiskSpace(void)
{
    struct statfs buf;
    long long freespace;
    freespace = 0;
    if (statfs("/private/var", &buf) >= 0) {
        freespace = (long long)buf.f_bsize * buf.f_bfree;
    }
    return freespace;
}

long long OKTotalDiskSpace(void)
{
    struct statfs buf;
    long long     totalspace;
    totalspace = 0;
    if (statfs("/private/var", &buf) >= 0) {
        totalspace = (long long)buf.f_bsize * buf.f_blocks;
    }
    return totalspace;
}


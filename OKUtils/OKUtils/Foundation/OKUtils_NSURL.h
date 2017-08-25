//
//  OKUtils_NSURL.h
//  OKUtils
//
//  Created by MAC on 2017/8/25.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import <Foundation/Foundation.h>


/// 编码url string
FOUNDATION_EXTERN NSString *OKURLEncode(NSString *URLString);
/// 解码url string
FOUNDATION_EXTERN NSString *OKURLDecode(NSString *URLString);
/// 解析url参数
FOUNDATION_EXTERN NSDictionary *OKURLQuery(NSString *URLString);
/// 将dict转成url
FOUNDATION_EXTERN NSString *OKURLAntiQuery(NSDictionary *dict);

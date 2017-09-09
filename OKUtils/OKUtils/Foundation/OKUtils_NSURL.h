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
/// 将dict转成url string
FOUNDATION_EXTERN NSString *OKURLAntiQuery(NSDictionary *dict);

@interface NSURL (OKUtils_Category)

/**
 *  添加query参数
 *
 *  @param parameter 接入参数(a=b&c=d)
 *
 *  @return 接入后结果
 */
- (NSURL *)URLByAppendingQueryParameter:(NSString *)parameter;

/**
 *  URL增加query dictionary
 *
 *  @param queryDictionary queryDictionary
 *
 *  @return 增加后的URL
 */
- (NSURL *)URLByAppendingQueryDictionary:(NSDictionary *)queryDictionary;

@end

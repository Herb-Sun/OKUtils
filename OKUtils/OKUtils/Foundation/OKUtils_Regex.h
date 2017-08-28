//
//  OKUtils_Regex.h
//  OKUtils
//
//  Created by MAC on 2017/8/23.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 验证内容类型
typedef NS_ENUM(NSInteger, OKValidType) {
    OKValidNone,            //!< none
    OKValidNumber,          //!< 纯数字
    OKValidMobile,          //!< 手机号码
    OKValidTel,             //!< 座机号码
    OKValidWord,            //!< 纯字母
    OKValidWordOrNumber,    //!< 数字或字母
    OKValidChinese,         //!< 纯汉字
    OKValidEmail,           //!< E-mail
    OKValidChinaPassPort,   //!< 中国护照
    OKValidForeignPassPort, //!< 外国护照
    OKValidIPAddress,       //!< IP地址
    OKValidURL,             //!< url
    OKValidIDCard,          //!< 身份证
};

/**
 正则验证
 
 @param str 待验证string
 @param type 验证类型
 @return 验证结果
 */
FOUNDATION_EXPORT BOOL OKValidation(NSString *str, OKValidType type);
FOUNDATION_EXPORT BOOL OKValidationBetterMin(NSString *str, OKValidType type, NSUInteger min);
FOUNDATION_EXPORT BOOL OKValidationBetterMax(NSString *str, OKValidType type, NSUInteger max);

/**
 更好的正则验证 含判空处理
 
 @param str 待验证string
 @param type 验证类型
 @param min 限制字符串最小字符数 左开区间
 @param max 限制字符串最大字符数 右开区间
 @return 验证结果
 */
FOUNDATION_EXPORT BOOL OKValidationBetter(NSString *str, OKValidType type, NSUInteger min, NSUInteger max);



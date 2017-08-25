//
//  OKUtils_NSData.h
//  OKUtils
//
//  Created by MAC on 2017/8/25.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (OKUtils_Category)

#pragma mark MD2 MD4 MD5加密

- (NSString *)ok_MD2Encryption; // MD2加密
- (NSString *)ok_MD4Encryption; // MD4加密
- (NSString *)ok_MD5Encryption; // MD5加密

- (NSData *)ok_MD2DataEncryption; // MD2加密
- (NSData *)ok_MD4DataEncryption; // MD4加密
- (NSData *)ok_MD5DataEncryption; // MD5加密

#pragma mark SHA1 SHA224 SHA256 SHA384 SHA512加密

- (NSString *)ok_SHA1Encryption;   // SHA1加密
- (NSString *)ok_SHA224Encryption; // SHA224加密
- (NSString *)ok_SHA256Encryption; // SHA256加密
- (NSString *)ok_SHA384Encryption; // SHA384加密
- (NSString *)ok_SHA512Encryption; // SHA512加密

- (NSData *)ok_SHA1DataEncryption;   // SHA1加密
- (NSData *)ok_SHA224DataEncryption; // SHA224加密
- (NSData *)ok_SHA256DataEncryption; // SHA256加密
- (NSData *)ok_SHA384DataEncryption; // SHA384加密
- (NSData *)ok_SHA512DataEncryption; // SHA512加密

/**
 利用AES加密数据

 @param key key
 @return 加密后数据
 */
- (nullable NSData *)ok_encryptedWithAESUsingKey:(NSString *)key;

/**
 利用AES解密数据

 @param key key
 @return 解密后数据
 */
- (nullable NSData *)ok_decryptedWithAESUsingKey:(NSString *)key;

/**
 利用3DES加密数据
 
 @param key key
 @return 加密后数据
 */
- (nullable NSData *)ok_encryptedWith3DESUsingKey:(NSString *)key;

/**
 利用3DES解密数据
 
 @param key key
 @return 解密后数据
 */
- (nullable NSData *)ok_decryptedWith3DESUsingKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END

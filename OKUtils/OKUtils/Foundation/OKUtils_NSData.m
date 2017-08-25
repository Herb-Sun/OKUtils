//
//  OKUtils_NSData.m
//  OKUtils
//
//  Created by MAC on 2017/8/25.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import "OKUtils_NSData.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSData (OKUtils_Category)


#pragma mark - MD2 MD4 MD5加密

- (NSString *)ok_MD2Encryption {
    
    unsigned char digest[CC_MD2_DIGEST_LENGTH];
    CC_MD2(self.bytes, (CC_LONG)self.length, digest);
    
    NSMutableString *strBuffer = [NSMutableString string];
    for (int i = 0; i < CC_MD2_DIGEST_LENGTH; ++i) {
        [strBuffer appendFormat:@"%02x", (unsigned int)digest[i]];
    }
    return strBuffer;
}

- (NSString *)ok_MD4Encryption {
    
    unsigned char digest[CC_MD4_DIGEST_LENGTH];
    CC_MD4(self.bytes, (CC_LONG)self.length, digest);
    
    NSMutableString *strBuffer = [NSMutableString string];
    for (int i = 0; i < CC_MD4_DIGEST_LENGTH; ++i) {
        [strBuffer appendFormat:@"%02x", (unsigned int)digest[i]];
    }
    return strBuffer;
}

- (NSString *)ok_MD5Encryption {
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(self.bytes, (CC_LONG)self.length, digest);
    
    NSMutableString *strBuffer = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; ++i) {
        [strBuffer appendFormat:@"%02x", (unsigned int)digest[i]];
    }
    return strBuffer;
}


- (NSData *)ok_MD2DataEncryption {
    
    unsigned char digest[CC_MD2_DIGEST_LENGTH];
    CC_MD2(self.bytes, (CC_LONG)self.length, digest);
    
    return [NSData dataWithBytes:digest length:CC_MD2_DIGEST_LENGTH];
}

- (NSData *)ok_MD4DataEncryption {
    
    unsigned char digest[CC_MD4_DIGEST_LENGTH];
    CC_MD4(self.bytes, (CC_LONG)self.length, digest);
    
    return [NSData dataWithBytes:digest length:CC_MD4_DIGEST_LENGTH];
}

- (NSData *)ok_MD5DataEncryption {
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(self.bytes, (CC_LONG)self.length, digest);
    
    return [NSData dataWithBytes:digest length:CC_MD5_DIGEST_LENGTH];
}

#pragma mark - SHA1 SHA224 SHA256 SHA384 SHA512加密

- (NSString *)ok_SHA1Encryption {
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(self.bytes, (CC_LONG)self.length, digest);
    
    NSMutableString *strBuffer = [NSMutableString string];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; ++i) {
        [strBuffer appendFormat:@"%02x", (unsigned int)digest[i]];
    }
    return strBuffer;
}

- (NSString *)ok_SHA224Encryption {
    
    uint8_t digest[CC_SHA224_DIGEST_LENGTH];
    CC_SHA224(self.bytes, (CC_LONG)self.length, digest);
    
    NSMutableString *strBuffer = [NSMutableString string];
    for (int i = 0; i < CC_SHA224_DIGEST_LENGTH; ++i) {
        [strBuffer appendFormat:@"%02x", (unsigned int)digest[i]];
    }
    return strBuffer;
}

- (NSString *)ok_SHA256Encryption {
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256([self bytes], (CC_LONG)[self length], digest);
    
    NSMutableString *strBuffer = [NSMutableString string];
    for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; ++i) {
        [strBuffer appendFormat:@"%02x", (unsigned int)digest[i]];
    }
    return strBuffer;
}

- (NSString *)ok_SHA384Encryption {
    
    uint8_t digest[CC_SHA384_DIGEST_LENGTH];
    CC_SHA384(self.bytes, (CC_LONG)self.length, digest);
    
    NSMutableString *strBuffer = [NSMutableString string];
    for (int i = 0; i < CC_SHA384_DIGEST_LENGTH; ++i) {
        [strBuffer appendFormat:@"%02x", (unsigned int)digest[i]];
    }
    return strBuffer;
}

- (NSString *)ok_SHA512Encryption {
    
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512([self bytes], (CC_LONG)[self length], digest);
    
    NSMutableString *strBuffer = [NSMutableString string];
    for (int i = 0; i < CC_SHA512_DIGEST_LENGTH; ++i) {
        [strBuffer appendFormat:@"%02x", (unsigned int)digest[i]];
    }
    return strBuffer;
}

- (NSData *)ok_SHA1DataEncryption {
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(self.bytes, (CC_LONG)self.length, digest);
    
    return [NSData dataWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
}

- (NSData *)ok_SHA224DataEncryption {
    
    uint8_t digest[CC_SHA224_DIGEST_LENGTH];
    CC_SHA224(self.bytes, (CC_LONG)self.length, digest);
    
    return [NSData dataWithBytes:digest length:CC_SHA224_DIGEST_LENGTH];
}

- (NSData *)ok_SHA256DataEncryption {
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256([self bytes], (CC_LONG)[self length], digest);
    
    return [NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
}

- (NSData *)ok_SHA384DataEncryption {
    
    uint8_t digest[CC_SHA384_DIGEST_LENGTH];
    CC_SHA384(self.bytes, (CC_LONG)self.length, digest);
    
    return [NSData dataWithBytes:digest length:CC_SHA384_DIGEST_LENGTH];
}

- (NSData *)ok_SHA512DataEncryption {
    
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512([self bytes], (CC_LONG)[self length], digest);
    
    return [NSData dataWithBytes:digest length:CC_SHA512_DIGEST_LENGTH];
}


- (NSData *)ok_encryptedWithAESUsingKey:(NSString *)key {
    
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    size_t dataOutMoved = 0;
    NSMutableData *encryptedData = [NSMutableData dataWithLength:self.length + kCCBlockSizeAES128];
    
    CCCryptorStatus status = CCCrypt(kCCEncrypt, // kCCEncrypt or kCCDecrypt
                                     kCCAlgorithmAES128,
                                     kCCOptionPKCS7Padding | kCCOptionECBMode, // Padding option for CBC Mode
                                     keyData.bytes,
                                     keyData.length,
                                     NULL,
                                     self.bytes,
                                     self.length,
                                     encryptedData.mutableBytes,    // encrypted data out
                                     encryptedData.length,
                                     &dataOutMoved);                   // total data moved
    
    if (status == kCCSuccess) {
        encryptedData.length = dataOutMoved;
        return encryptedData;
    }
    
    return nil;
}


- (NSData *)ok_decryptedWithAESUsingKey:(NSString *)key {
    
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    size_t dataOutMoved = 0;
    NSMutableData *decryptedData = [NSMutableData dataWithLength:self.length + kCCBlockSizeAES128];
    
    CCCryptorStatus result = CCCrypt(kCCDecrypt,                    // kCCEncrypt or kCCDecrypt
                                     kCCAlgorithmAES128,
                                     kCCOptionPKCS7Padding,         // Padding option for CBC Mode
                                     keyData.bytes,
                                     keyData.length,
                                     NULL,
                                     self.bytes,
                                     self.length,
                                     decryptedData.mutableBytes,    // encrypted data out
                                     decryptedData.length,
                                     &dataOutMoved);                   // total data moved
    
    if (result == kCCSuccess) {
        decryptedData.length = dataOutMoved;
        return decryptedData;
    }
    
    return nil;
}

- (NSData *)ok_encryptedWith3DESUsingKey:(NSString *)key {
    
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    size_t dataOutMoved = 0;
    NSMutableData *encryptedData = [NSMutableData dataWithLength:self.length + kCCBlockSize3DES];
    
    CCCryptorStatus result = CCCrypt(kCCEncrypt,                    // kCCEncrypt or kCCDecrypt
                                     kCCAlgorithm3DES,
                                     kCCOptionPKCS7Padding,         // Padding option for CBC Mode
                                     keyData.bytes,
                                     keyData.length,
                                     NULL,
                                     self.bytes,
                                     self.length,
                                     encryptedData.mutableBytes,    // encrypted data out
                                     encryptedData.length,
                                     &dataOutMoved);                   // total data moved
    
    if (result == kCCSuccess) {
        encryptedData.length = dataOutMoved;
        return encryptedData;
    }
    
    return nil;
}

- (NSData *)ok_decryptedWith3DESUsingKey:(NSString *)key {
    
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    size_t dataOutMoved = 0;
    NSMutableData *decryptedData = [NSMutableData dataWithLength:self.length + kCCBlockSize3DES];
    
    CCCryptorStatus result = CCCrypt(kCCDecrypt,                    // kCCEncrypt or kCCDecrypt
                                     kCCAlgorithm3DES,
                                     kCCOptionPKCS7Padding,         // Padding option for CBC Mode
                                     keyData.bytes,
                                     keyData.length,
                                     NULL,
                                     self.bytes,
                                     self.length,
                                     decryptedData.mutableBytes,    // encrypted data out
                                     decryptedData.length,
                                     &dataOutMoved);                   // total data moved
    
    if (result == kCCSuccess) {
        decryptedData.length = dataOutMoved;
        return decryptedData;
    }
    
    return nil;
}

@end

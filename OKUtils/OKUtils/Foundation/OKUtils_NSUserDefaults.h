//
//  OKUtils_NSUserDefaults.h
//  OKUtils
//
//  Created by herb on 2017/8/24.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSUserDefaults (OKUtils_Category)

/**
 *  读取信息
 */
+ (nullable id)objectForKey:(NSString *)defaultName;

/**
 *  存储信息
 */
+ (void)saveObject:(nullable id)value forKey:(NSString *)defaultName;

/**
 *  保存model
 */
+ (nullable id<NSCoding>)modelForKey:(NSString *)defaultName;

/**
 *  存储model
 */
+ (void)saveModel:(id<NSCoding>)value forKey:(NSString *)defaultName;

@end

NS_ASSUME_NONNULL_END


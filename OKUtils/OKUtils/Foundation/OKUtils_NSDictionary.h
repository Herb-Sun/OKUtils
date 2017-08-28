//
//  OKUtils_NSDictionary.h
//  OKUtils
//
//  Created by MAC on 2017/8/25.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (OKUtils_Category)

/// 将JSON字符串转换成NSDictionary
FOUNDATION_EXPORT NSDictionary *OKJSONSerialization(NSString *json);

/**
 *  将NSDictionary转换成XML字符串
 *
 *  @return XML 字符串
 */
- (NSString *)XMLString;

/**
 *  将NSDictionary转换成JSON字符串
 *
 *  @return JSON字符串
 */
- (nullable NSString *)JSONString;

- (NSDictionary *)dictionaryByAddingEntriesFromDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)dictionaryByRemovingEntriesWithKeys:(NSSet *)keys;

- (BOOL)hasKey:(NSString *)key;
- (nullable NSString *)stringForKey:(id)key;
- (nullable NSNumber *)numberForKey:(id)key;
- (nullable NSDecimalNumber *)decimalNumberForKey:(id)key;
- (nullable NSArray *)arrayForKey:(id)key;
- (nullable NSDictionary *)dictionaryForKey:(id)key;
- (NSInteger)integerForKey:(id)key;
- (NSUInteger)unsignedIntegerForKey:(id)key;
- (BOOL)boolForKey:(id)key;
- (int16_t)int16ForKey:(id)key;
- (int32_t)int32ForKey:(id)key;
- (int64_t)int64ForKey:(id)key;
- (char)charForKey:(id)key;
- (short)shortForKey:(id)key;
- (float)floatForKey:(id)key;
- (double)doubleForKey:(id)key;
- (long long)longLongForKey:(id)key;
- (unsigned long long)unsignedLongLongForKey:(id)key;
- (nullable NSDate *)dateForKey:(id)key dateFormat:(NSString *)dateFormat;
- (CGFloat)CGFloatForKey:(id)key;
- (CGPoint)pointForKey:(id)key;
- (CGSize)sizeForKey:(id)key;
- (CGRect)rectForKey:(id)key;

@end

#pragma mark - NSMutableDictionary OKUtils_Category

@interface NSMutableDictionary (OKUtils_Category)

- (void)setPoint:(CGPoint)point forKey:(NSString *)key;
- (void)setSize:(CGSize)size forKey:(NSString *)key;
- (void)setRect:(CGRect)rect forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END

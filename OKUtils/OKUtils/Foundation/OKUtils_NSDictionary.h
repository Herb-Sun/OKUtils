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
FOUNDATION_EXTERN NSDictionary *OKJSONSerialization(NSString *json);

/**
 *  将NSDictionary转换成XML字符串
 *
 *  @return XML 字符串
 */
- (NSString *)ok_XMLString;

/**
 *  将NSDictionary转换成JSON字符串
 *
 *  @return JSON字符串
 */
- (nullable NSString *)ok_JSONString;

- (NSDictionary *)ok_dictionaryByAddingEntriesFromDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)ok_dictionaryByRemovingEntriesWithKeys:(NSSet *)keys;

#pragma mark - NSDictionary OKSafeAccess

- (BOOL)ok_hasKey:(NSString *)key;
- (nullable NSString *)ok_stringForKey:(id)key;
- (nullable NSNumber *)ok_numberForKey:(id)key;
- (nullable NSDecimalNumber *)ok_decimalNumberForKey:(id)key;
- (nullable NSArray *)ok_arrayForKey:(id)key;
- (nullable NSDictionary *)ok_dictionaryForKey:(id)key;
- (NSInteger)ok_integerForKey:(id)key;
- (NSUInteger)ok_unsignedIntegerForKey:(id)key;
- (BOOL)ok_boolForKey:(id)key;
- (int16_t)ok_int16ForKey:(id)key;
- (int32_t)ok_int32ForKey:(id)key;
- (int64_t)ok_int64ForKey:(id)key;
- (char)ok_charForKey:(id)key;
- (short)ok_shortForKey:(id)key;
- (float)ok_floatForKey:(id)key;
- (double)ok_doubleForKey:(id)key;
- (long long)ok_longLongForKey:(id)key;
- (unsigned long long)ok_unsignedLongLongForKey:(id)key;
- (nullable NSDate *)ok_dateForKey:(id)key dateFormat:(NSString *)dateFormat;
- (CGFloat)ok_CGFloatForKey:(id)key;
- (CGPoint)ok_pointForKey:(id)key;
- (CGSize)ok_sizeForKey:(id)key;
- (CGRect)ok_rectForKey:(id)key;

@end

#pragma mark - NSMutableDictionary OKUtils_Category

@interface NSMutableDictionary (OKUtils_Category)

- (void)ok_setPoint:(CGPoint)point forKey:(NSString *)key;
- (void)ok_setSize:(CGSize)size forKey:(NSString *)key;
- (void)ok_setRect:(CGRect)rect forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END

//
//  OKUtils_NSArray.h
//  OKUtils
//
//  Created by MAC on 2017/9/7.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (OKUtils_Category)

/**
 Returns the object located at a random index.
 
 @return The object in the array with a random index value.
 If the array is empty, returns nil.
 */
- (nullable id)randomObject;

/**
 Convert object to json string. return nil if an error occurs.
 NSString/NSNumber/NSDictionary/NSArray
 */
- (nullable NSString *)jsonStringEncoded;

/**
 Convert object to json string formatted. return nil if an error occurs.
 */
- (nullable NSString *)jsonPrettyStringEncoded;

/**
 Creates an array of elements split into groups the length of size. 
 If array can't be split evenly, the final chunk will be the remaining elements.
 👉[@[@1, @2, @3] chunk:2] => @[@[@1, @2], @[@3]]
 
 @param size [size=1]
 @return @[] if array is empty
 */
- (NSArray *)chunk:(NSUInteger)size;


/**
 Creates an array with all falsey values removed. 
 The values @NO, [NSNull null], @0, @"" are falsey.
 👉[@[@0, @1, @"", @" ", [NSNull null], @YES, @NO] compact] => @[@1, @" ", @YES]
 
 @return @[] if all values are falsey
 */
- (NSArray *)compact;

/**
 Creates an array of array values not included in the other given arrays using SameValueZero for equality comparisons. 
 The order and references of result values are determined by the first array.
 
 @return @[] if all values are equals
 */
- (NSArray *)difference:(NSArray *)array;

/**
 Creates a slice of array with n elements dropped from the beginning.
 👉[@[@1, @2, @3] drop:2] => @[@3]
 
 @param n default = 1
 @return the slice of array.
 */
- (NSArray *)drop:(NSUInteger)n;

/**
 Creates a slice of array with n elements dropped from the end.
 👉[@[@1, @2, @3] dropRight:2] => @[@1].
 
 @param n default = 1
 @return the slice of array.
 */
- (NSArray *)dropRight:(NSUInteger)n;

/**
 Creates a slice of array by predicate rule
 👉[@[@1, @2, @3, @4, @5] dropByPredicate:^BOOL(id  _Nonnull obj, NSUInteger idx) {
        return idx % 2 == 0;
    }]
    => @[@2, @4]
 @param predicate predicate
 @return the slice of array.
 */
- (NSArray *)dropByPredicate:(BOOL(^)(id obj, NSUInteger idx))predicate;

/**
 Creates a slice of array with n elements taken from the beginning.
 👉[@[@1, @2, @3] take:2] => @[@1, @2]
 
 @param n default = 1
 @return the slice of array.
 */
- (NSArray *)take:(NSUInteger)n;

/**
 Creates a slice of array with n elements taken from the end.
 👉[@[@1, @2, @3] takeRight:2] => @[@2, @3]
 
 @param n default = 1
 @return the slice of array.
 */
- (NSArray *)takeRight:(NSUInteger)n;

/**
 Creates a slice of array with n elements taken from the end.
 👉[@[@1, @2, @3, @4, @5] takeByPredicate:^BOOL(id  _Nonnull obj, NSUInteger idx) {
        return idx % 2 == 0;
    }]
    => @[@1, @3, @5]
 @param predicate predicate
 @return the slice of array.
 */
- (NSArray *)takeByPredicate:(BOOL(^)(id obj, NSUInteger idx))predicate;

/**
 Strong and Safe get the index element of array.
 Will not crash by beyond bounds
 👉[@[@1, @2, @3] safetyObjectAtIndex:-1] => @3.
 👉[@[@1, @2, @3] safetyObjectAtIndex:100] => nil.
 */
- (nullable id)safetyObjectAtIndex:(NSInteger)index;

/**
 Removes all elements from array that predicate returns truthy for 
 and returns an array of the removed elements.
 👉[@[@1, @2, @3, @4, @5] removeByPredicate:^BOOL(id obj, NSUInteger idx) {
        return idx % 2 == 0;
    }]
    => @[@1, @3, @5]
 */
- (NSArray *)removeByPredicate:(BOOL(^)(id obj, NSUInteger idx))predicate;

/**
 Reverse the index of object in this array.
 👉 [@[@1, @2, @3] reverse] => @[@3, @2, @1].
 */
- (NSArray *)reverse;

/**
 unique value of array
 */
- (NSArray *)unique;

/**
 Creates an array of from all given arrays
 It will continue if self has constain the value of others
 👉 [@[@1, @2, @3, @3] unionByOthers:@[@1, @4, @3, @5]] => @[@1, @2, @3, @3, @4, @5].
 */
- (NSArray *)unionByOthers:(NSArray *)others;

@end

NS_ASSUME_NONNULL_END

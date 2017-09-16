//
//  OKUtils_NSMutableArray.h
//  OKUtils
//
//  Created by MAC on 2017/9/11.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (OKUtils_Category)

/**
 Creates an array of elements split into groups the length of size.
 If array can't be split evenly, the final chunk will be the remaining elements.
 👉[@[@1, @2, @3] chunk:2] => @[@[@1, @2], @[@3]]
 
 @param size [size=1]
 */
- (void)chunk:(NSUInteger)size;

/**
 Creates an array with all falsey values removed.
 The values @NO, [NSNull null], @0, @"" are falsey.
 👉[@[@0, @1, @"", @" ", [NSNull null], @YES, @NO] compact] => @[@1, @" ", @YES]
 */
- (void)compact;

/**
 Creates a slice of array with n elements dropped from the beginning.
 👉[@[@1, @2, @3] drop:2] => @[@3]
 
 @param n default = 1
 */
- (void)drop:(NSUInteger)n;

/**
 Creates a slice of array with n elements dropped from the end.
 👉[@[@1, @2, @3] dropRight:2] => @[@1].
 
 @param n default = 1
 */
- (void)dropRight:(NSUInteger)n;

/**
 Creates a slice of array by predicate rule
 👉[@[@1, @2, @3, @4, @5] dropByPredicate:^BOOL(id  _Nonnull obj, NSUInteger idx) {
 return idx % 2 == 0;
 }]
 => @[@2, @4]
 @param predicate predicate
 */
- (void)dropByPredicate:(BOOL(^)(id obj, NSUInteger idx))predicate;

/**
 Creates a slice of array with n elements taken from the beginning.
 👉[@[@1, @2, @3] take:2] => @[@1, @2]
 
 @param n default = 1
 */
- (void)take:(NSUInteger)n;

/**
 Creates a slice of array with n elements taken from the end.
 👉[@[@1, @2, @3] takeRight:2] => @[@2, @3]
 
 @param n default = 1
 */
- (void)takeRight:(NSUInteger)n;

/**
 Creates a slice of array with n elements taken from the end.
 👉[@[@1, @2, @3, @4, @5] takeByPredicate:^BOOL(id  _Nonnull obj, NSUInteger idx) {
 return idx % 2 == 0;
 }]
 => @[@1, @3, @5]
 @param predicate predicate
 */
- (void)takeByPredicate:(BOOL(^)(id obj, NSUInteger idx))predicate;

/**
 Removes all elements from array that predicate returns truthy for
 and returns an array of the removed elements.
 👉[@[@1, @2, @3, @4, @5] removeByPredicate:^BOOL(id obj, NSUInteger idx) {
 return idx % 2 == 0;
 }]
 => @[@1, @3, @5]
 */
- (void)removeByPredicate:(BOOL(^)(id obj, NSUInteger idx))predicate;

/**
 Reverse the index of object in this array.
 👉 [@[@1, @2, @3] reverse] => @[@3, @2, @1].
 */
- (void)reverse;

/**
 Creates an array of from all given arrays
 It will continue if self has constain the value of others
 👉 [@[@1, @2, @3, @3] unionByOthers:@[@1, @4, @3, @5]] => @[@1, @2, @3, @3, @4, @5].
 */
- (void)unionByOthers:(NSArray *)others;

@end

NS_ASSUME_NONNULL_END

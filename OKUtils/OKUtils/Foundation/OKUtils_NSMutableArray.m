//
//  OKUtils_NSMutableArray.m
//  OKUtils
//
//  Created by MAC on 2017/9/11.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import "OKUtils_NSMutableArray.h"

@implementation NSMutableArray (OKUtils_Category)

- (void)chunk:(NSUInteger)size {
    if (!self.count || size > self.count) return;
    NSInteger maxSize = MAX(size, 1);

    NSInteger index = 0;
    NSInteger resIndex = 0;
    NSArray *arrayM = [self mutableCopy];
    [self removeAllObjects];
    while (index < arrayM.count) {
        NSArray *subArray = [arrayM subarrayWithRange:NSMakeRange(index, MIN(arrayM.count - index, maxSize))];
        [self insertObject:subArray atIndex:resIndex++];
        index += maxSize;
    }
}

- (void)compact {
    if (!self.count) return;
    for (int i = 0; i < self.count - 1; i++) {
        id obj = [self objectAtIndex:i];
        if ([obj isKindOfClass:[NSNumber class]]) {
            if (![(NSNumber *)obj boolValue]) {
                [self removeObject:obj];
                i--;
            }
        }
        if ([obj isKindOfClass:[NSString class]]) {
            if (!((NSString *)obj).length) {
                [self removeObject:obj];
                i--;
            }
        }
        if ([obj isKindOfClass:[NSNull class]]) {
            [self removeObject:obj];
            i--;
        }
    }
}

- (void)drop:(NSUInteger)n {
    if (!self.count) return;
    NSInteger size = MAX(n, 1);
    if (size >= self.count) {
        [self removeAllObjects];
    } else {
        [self removeObjectsInRange:NSMakeRange(0, size)];
    }
}

- (void)dropRight:(NSUInteger)n {
    if (!self.count) return;
    NSInteger size = MAX(n, 1);
    if (size >= self.count) {
        [self removeAllObjects];
    } else {
        [self removeObjectsInRange:NSMakeRange(self.count - size, size)];
    }
}

- (void)dropByPredicate:(BOOL(^)(id obj, NSUInteger idx))predicate {
    if (!self.count) return;
    for (int i = 0; i < self.count - 1; i++) {
        id obj = [self objectAtIndex:i];
        if (predicate && predicate(obj, i)) {
            [self removeObject:obj];
            i--;
        }
    }
}

- (void)take:(NSUInteger)n {
    if (!self.count || n == 0) {
        [self removeAllObjects]; return;
    }
    NSInteger size = MAX(n, 1);
    if (size < self.count) {
        [self removeObjectsInRange:NSMakeRange(size, self.count - size)];
    }
}

- (void)takeRight:(NSUInteger)n {
    if (!self.count || n == 0) {
        [self removeAllObjects]; return;
    }
    NSInteger size = MAX(n, 1);
    if (size < self.count) {
        [self removeObjectsInRange:NSMakeRange(0, self.count - size)];
    }
}

- (void)takeByPredicate:(BOOL(^)(id obj, NSUInteger idx))predicate {
    if (!self.count) {
        [self removeAllObjects]; return;
    }
    for (int i = 0; i < self.count - 1; i++) {
        id obj = [self objectAtIndex:i];
        if (predicate && !predicate(obj, i)) {
            [self removeObject:obj];
            i--;
        }
    }
}

- (void)removeByPredicate:(BOOL(^)(id obj, NSUInteger idx))predicate {
    if (!self.count) return;
    for (int i = 0; i < self.count - 1; i++) {
        id obj = [self objectAtIndex:i];
        if (predicate && predicate(obj, i)) {
            [self removeObject:obj];
            i--;
        }
    }
}

- (void)reverse {
    if (!self.count) return;
    NSUInteger count = self.count;
    int mid = floor(count / 2.0);
    for (NSUInteger i = 0; i < mid; i++) {
        [self exchangeObjectAtIndex:i withObjectAtIndex:(count - (i + 1))];
    }
}

- (void)unionByOthers:(NSArray *)others {
    if (!self.count && !others.count) return;
    [others enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![self containsObject:obj]) {
            [self addObject:obj];
        }
    }];
}

@end

//
//  OKUtils_NSArray.m
//  OKUtils
//
//  Created by MAC on 2017/9/7.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import "OKUtils_NSArray.h"

@implementation NSArray (OKUtils_Category_Private)

#if DEBUG
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    NSMutableString *desc = [NSMutableString string];
    NSMutableString *tabString = [[NSMutableString alloc] initWithCapacity:level];
    for (NSUInteger i = 0; i < level; ++i) {
        [tabString appendString:@"\t"];
    }
    NSString *tab = level > 0 ? tabString : @"\t";
    [desc appendString:@"\t(\n"];
    
    for (id obj in self) {
        if (![obj respondsToSelector:@selector(description)]) continue;
        
        if ([obj isKindOfClass:[NSDictionary class]]
            || [obj isKindOfClass:[NSArray class]]
            || [obj isKindOfClass:[NSSet class]]) {
            NSString *str = [((NSDictionary *)obj) descriptionWithLocale:locale indent:level + 1];
            [desc appendFormat:@"%@\t%@,\n", tab, str];
        } else if ([obj isKindOfClass:[NSString class]]) {
            [desc appendFormat:@"%@\t\"%@\",\n", tab, obj];
        } else if ([obj isKindOfClass:[NSData class]]) {
            NSError *error = nil;
            NSObject *result =  [NSJSONSerialization JSONObjectWithData:obj
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&error];
            if (error == nil && result != nil) {
                if ([result isKindOfClass:[NSDictionary class]]
                    || [result isKindOfClass:[NSArray class]]
                    || [result isKindOfClass:[NSSet class]]) {
                    NSString *str = [((NSDictionary *)result) descriptionWithLocale:locale indent:level + 1];
                    [desc appendFormat:@"%@\t%@,\n", tab, str];
                } else if ([obj isKindOfClass:[NSString class]]) {
                    [desc appendFormat:@"%@\t\"%@\",\n", tab, result];
                }
            } else {
                @try {
                    NSString *str = [[NSString alloc] initWithData:obj encoding:NSUTF8StringEncoding];
                    if (str != nil) {
                        [desc appendFormat:@"%@\t\"%@\",\n", tab, str];
                    } else {
                        [desc appendFormat:@"%@\t%@,\n", tab, obj];
                    }
                }
                @catch (NSException *exception) {
                    [desc appendFormat:@"%@\t%@,\n", tab, obj];
                }
            }
        } else {
            [desc appendFormat:@"%@\t%@,\n", tab, obj];
        }
    }    
    [desc appendFormat:@"%@)", tab];
    
    return desc;
}
#endif

@end

@implementation NSArray (OKUtils_Category)

- (id)randomObject {
    if (self.count) {
        return self[arc4random_uniform((u_int32_t)self.count)];
    }
    return nil;
}

- (NSString *)jsonStringEncoded {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        if (!error) return json;
    }
    return nil;
}

- (NSString *)jsonPrettyStringEncoded {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        if (!error) return json;
    }
    return nil;
}

- (NSArray *)chunk:(NSUInteger)size {
    if (!self.count) return @[];
    NSInteger maxSize = MAX(size, 1);
    if (maxSize >= self.count) return self;
    
    NSInteger index = 0;
    NSInteger resIndex = 0;
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:(NSUInteger)ceil(self.count / maxSize)];
    while (index < self.count) {
        NSArray *subArray = [self subarrayWithRange:NSMakeRange(index, MIN(self.count - index, maxSize))];
        [arrayM insertObject:subArray atIndex:resIndex++];
        index += maxSize;
    }
    return [NSArray arrayWithArray:arrayM];
}

- (NSArray *)compact {
    if (!self.count) return @[];
    NSMutableArray *arrayM = [NSMutableArray array];
    for (id value in self) {
        if ([value isKindOfClass:[NSNumber class]]) {
            if (![(NSNumber *)value boolValue]) continue;
        }
        if ([value isKindOfClass:[NSString class]]) {
            if (!((NSString *)value).length) continue;
        }
        if ([value isKindOfClass:[NSNull class]]) continue;
        
        [arrayM addObject:value];
    }
    return [NSArray arrayWithArray:arrayM];
}

- (NSArray *)difference:(NSArray *)array {
    // TODO: --
    return self;
}

- (NSArray *)drop:(NSUInteger)n {
    if (!self.count) return @[];
    NSInteger size = MAX(n, 1);
    if (size >= self.count) return @[];
    return [self subarrayWithRange:NSMakeRange(size, self.count - size)];
}

- (NSArray *)dropRight:(NSUInteger)n {
    if (!self.count) return @[];
    NSInteger size = MAX(n, 1);
    if (size >= self.count) return @[];
    return [self subarrayWithRange:NSMakeRange(0, self.count - size)];
}

- (NSArray *)dropByPredicate:(BOOL(^)(id obj, NSUInteger idx))predicate {
    if (!self.count) return @[];
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (predicate && !predicate(obj, idx)) {
            [arrayM addObject:obj];
        }
    }];
    return [NSArray arrayWithArray:arrayM];
}

- (NSArray *)take:(NSUInteger)n {
    if (!self.count || n == 0) return @[];
    NSInteger size = MAX(n, 1);
    if (size >= self.count) return self;
    return [self subarrayWithRange:NSMakeRange(0, size)];
}

- (NSArray *)takeRight:(NSUInteger)n {
    if (!self.count || n == 0) return @[];
    NSInteger size = MAX(n, 1);
    if (size >= self.count) return self;
    return [self subarrayWithRange:NSMakeRange(self.count - size, size)];
}

- (NSArray *)takeByPredicate:(BOOL(^)(id obj, NSUInteger idx))predicate {
    if (!self.count) return @[];
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:self.count];

    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (predicate && predicate(obj, idx)) {
            [arrayM addObject:obj];
        }
    }];
    return [NSArray arrayWithArray:arrayM];
}

- (id)safetyObjectAtIndex:(NSInteger)index {
    if (!self.count) return nil;
    
    if (index >= 0) {
        if (index > self.count - 1) return nil;
        return [self objectAtIndex:index];
    } else {
        if (labs(index) > self.count) return nil;
        return [self objectAtIndex:(self.count + index)];
    }
}

- (NSArray *)removeByPredicate:(BOOL(^)(id obj, NSUInteger idx))predicate {
    if (!self.count) return @[];
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:self.count];
    
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (predicate && !predicate(obj, idx)) {
            [arrayM addObject:obj];
        }
    }];
    return [NSArray arrayWithArray:arrayM];
}

- (NSArray *)reverse {
    if (!self.count) return @[];
    NSUInteger count = self.count;
    int mid = floor(count / 2.0);
    NSMutableArray *arrayM = [NSMutableArray arrayWithArray:self];
    for (NSUInteger i = 0; i < mid; i++) {
        [arrayM exchangeObjectAtIndex:i withObjectAtIndex:(count - (i + 1))];
    }
    return [NSArray arrayWithArray:arrayM];
}

- (NSArray *)unique {
    if (!self.count) return @[];
    NSOrderedSet *orderSet = [NSOrderedSet orderedSetWithArray:self];
    return orderSet.array;
}

- (NSArray *)unionByOthers:(NSArray *)others {
    if (!self.count && !others.count) return @[];
    NSMutableArray *arrayM = [NSMutableArray arrayWithArray:self];
    [others enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![self containsObject:obj]) {
            [arrayM addObject:obj];
        }
    }];
    return [NSArray arrayWithArray:arrayM];
}

@end

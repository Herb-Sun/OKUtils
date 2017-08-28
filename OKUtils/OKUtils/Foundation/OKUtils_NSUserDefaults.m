//
//  OKUtils_NSUserDefaults.m
//  OKUtils
//
//  Created by herb on 2017/8/24.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import "OKUtils_NSUserDefaults.h"

@implementation NSUserDefaults (OKUtils_Category)

+ (id)objectForKey:(NSString *)defaultName {
    return [[NSUserDefaults standardUserDefaults] objectForKey:defaultName];
}

+ (void)saveObject:(id)value forKey:(NSString *)defaultName {
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:defaultName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id<NSCoding>)modelForKey:(NSString *)defaultName {
    id<NSCoding> model;
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:defaultName];
    if (data) {
        model = (id<NSCoding>)[NSKeyedUnarchiver unarchiveObjectWithData: data];
    }
    return model;
}

+ (void)saveModel:(id<NSCoding>)value forKey:(NSString *)defaultName {
    if (value) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:value];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:defaultName];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end

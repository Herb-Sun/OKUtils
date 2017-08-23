//
//  OKUtils_Regex.m
//  OKUtils
//
//  Created by MAC on 2017/8/23.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import "OKUtils_Regex.h"

BOOL OKValidation(NSString *str, OKValidType type)
{
    return OKValidationBetter(str, type, 0, NSUIntegerMax);
}

BOOL OKValidationBetterMin(NSString *str, OKValidType type, NSUInteger min)
{
    return OKValidationBetter(str, type, min, NSUIntegerMax);
}

BOOL OKValidationBetterMax(NSString *str, OKValidType type, NSUInteger max)
{
    return OKValidationBetter(str, type, 0, max);
}

BOOL OKValidationBetter(NSString *str, OKValidType type, NSUInteger min, NSUInteger max)
{
    if (!str || str.length <= 0) return NO;
    
    NSCAssert(min < max, @"The maximum value must be greater than the minimum value");
    if (str.length < min || str.length > max) {
        return NO;
    }
    NSArray<NSString *> *regexArray;
    
    switch (type) {
        case OKValidNumber:
            regexArray = @[@"^[0-9]*$"];
            break;
        case OKValidMobile:
            regexArray = @[@"^1([3-9])\\d{9}"];
            break;
        case OKValidTel:
            regexArray = @[@"^(\\d{3,4}-)\\d{7,8}$"];
            break;
        case OKValidWord:
            regexArray = @[@"^[A-Za-z]+$"];
            break;
        case OKValidWordOrNumber:
            regexArray = @[@"^[A-Za-z0-9]+$"];
            break;
        case OKValidChinese:
            regexArray = @[@"^[\u4E00-\u9FA5]+$"];
            break;
        case OKValidEmail:
            regexArray = @[@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
            break;
        case OKValidChinaPassPort:
            regexArray = @[@"^[A-Za-z]{1,3}\\d{7,12}$", @"^\\d{9,12}$"];
            break;
        case OKValidForeignPassPort:
            regexArray = @[@"^[A-Za-z0-9]{1,20}$"];
            break;
        default:
            return YES;
            break;
    }
    __block BOOL valid = NO;
    [regexArray enumerateObjectsUsingBlock:^(NSString *regex, NSUInteger idx, BOOL * _Nonnull stop) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        if ([predicate evaluateWithObject:str]) {
            valid = YES;
            *stop = YES;
        }
    }];
    
    return valid;
}


//
//  OKUtils_Regex.m
//  OKUtils
//
//  Created by MAC on 2017/8/23.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import "OKUtils_Regex.h"

/// 严格验证身份证
static inline BOOL __OKValidIDCard(NSString *num);
/// 严格验证中国银行卡号
static inline BOOL __OKValidChinaBankCard(NSString *number);

#pragma mark - Public

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
        case OKValidIPAddress:
            regexArray = @[@"^(25[0-5]|2[0-4]\\d|[0-1]?\\d?\\d)(\\.(25[0-5]|2[0-4]\\d|[0-1]?\\d?\\d)){3}$"];
            break;
        case OKValidURL:
            regexArray = @[@"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"];
            break;
        case OKValidIDCard:
            return __OKValidIDCard(str);
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

#pragma mark - Private

static inline BOOL __OKValidIDCard(NSString *num)
{
    if (num.length != 18) return NO;
    
    NSArray *wight = @[@7, @9, @10, @5, @8, @4, @2, @1, @6, @3, @7, @9, @10, @5, @8, @4, @2];
    NSArray *remainders = @[@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    int sum = 0;
    for (int i = 0; i < num.length - 1; i++) {
        unichar ch = [num characterAtIndex:i];
        sum += ((ch - 48) * [wight[i] intValue]);
    }
    
    NSString *last = [num substringFromIndex:num.length - 1];
    // 取余
    int m = sum % 11;
    
    return [[remainders objectAtIndex:m] isEqualToString:[last uppercaseString]];
}

/// 严格验证中国银行卡号
static inline BOOL __OKValidChinaBankCard(NSString *number)
{
    if (number.length == 0) return NO;
    
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int numberLength = (int)number.length;
    int lastNum = [[number substringFromIndex:numberLength-1] intValue];
    
    number = [number substringToIndex:numberLength - 1];
    for (int i = numberLength -1 ; i>=1;i--) {
        NSString *tmpString = [number substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (numberLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}

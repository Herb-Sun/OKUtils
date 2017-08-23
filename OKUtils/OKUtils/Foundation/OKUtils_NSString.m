//
//  OKUtils_NSString.m
//  OKUtils
//
//  Created by MAC on 2017/8/23.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import "OKUtils_NSString.h"

BOOL OKStringEmpty(NSString *string)
{
    return !string || string.length <=0;
}

NSString *OKStringSafety(NSString *string)
{
    return OKStringValid(string, @"");
}

NSString *OKStringValid(NSString *string, NSString *placeholder)
{
    return string ?: (placeholder ?: @"");
}


//
//  OKUtils_NSURL.m
//  OKUtils
//
//  Created by MAC on 2017/8/25.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import "OKUtils_NSURL.h"

NSString *OKURLEncode(NSString *URLString)
{
    return [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

NSString *OKURLDecode(NSString *URLString)
{
    return [URLString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

NSDictionary *OKURLQuery(NSString *URLString)
{
    NSURL *url = [NSURL URLWithString:URLString];
    
    if (!url.query) return @{};
    
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    NSArray *parameters = [url.query componentsSeparatedByString:@"&"];
    
    for (NSString *parameter in parameters) {
        
        NSArray *contents = [parameter componentsSeparatedByString:@"="];
        if ([contents count] == 2) {
            NSString *key   = [contents firstObject];
            NSString *value = [contents lastObject];
            key = [key stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            value = [value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            if (key && value) {
                [paramDict setObject:value forKey:key];
            }
        }
    }
    return [NSDictionary dictionaryWithDictionary:paramDict];
}

NSString *OKURLAntiQuery(NSDictionary *dict)
{
    NSMutableString *string = [NSMutableString string];
    
    for (NSString *key in dict.allKeys) {
        if (string.length > 0) { [string appendString:@"&"]; }
        
        CFStringRef escaped = CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                      (CFStringRef)[dict[key] description],
                                                                      NULL,
                                                                      (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                      kCFStringEncodingUTF8);
        [string appendFormat:@"%@=%@", key, escaped];
        CFRelease(escaped);
    }
    return string;
}

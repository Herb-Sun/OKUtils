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


@implementation NSURL (OKUtils_Category)

- (NSURL *)URLByAppendingQueryParameter:(NSString *)parameter {
    
    NSString *queryStr       = self.query;
    NSString *resultQueryStr = nil;
    
    NSString *resultUrlStr   = nil;
    NSString *absoluteUrlStr = self.absoluteString;
    NSRange  hashRange       = [absoluteUrlStr rangeOfString:@"#"];
    
    //判断原始url是否包含query部分
    if (queryStr && queryStr.length > 0) {
        resultQueryStr = [NSString stringWithFormat:@"%@&%@", queryStr, parameter];
        resultUrlStr   = [absoluteUrlStr stringByReplacingOccurrencesOfString:queryStr withString:resultQueryStr];
        
    } else {
        resultQueryStr = [NSString stringWithFormat:@"?%@", parameter];
        if (hashRange.location != NSNotFound) {
            //先截取hash部分，再拼接query
            NSString *hashStr = [absoluteUrlStr substringFromIndex:hashRange.location];
            NSString *subUrl  = [NSString stringWithFormat:@"%@%@", resultQueryStr, hashStr];
            resultUrlStr = [absoluteUrlStr stringByReplacingOccurrencesOfString:hashStr withString:subUrl];
            
        } else {
            resultUrlStr = [NSString stringWithFormat:@"%@/?%@", absoluteUrlStr, parameter];
        }
    }
    return [NSURL URLWithString:resultUrlStr];
}

- (NSURL *)URLByAppendingQueryDictionary:(NSDictionary *)queryDictionary {
    
    NSMutableArray *queries = [self.query length] > 0 ? @[self.query].mutableCopy : @[].mutableCopy;
    
    
    if (queryDictionary) {
        [queries addObject:queryDictionary];
    }
    NSString *newQuery = [queries componentsJoinedByString:@"&"];
    
    if (newQuery.length > 0) {
        NSArray *queryComponents = [self.absoluteString componentsSeparatedByString:@"?"];
        if (queryComponents.count > 0) {
            return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@%@%@",
                                         queryComponents[0],
                                         @"?",
                                         newQuery,
                                         self.fragment.length ? @"#" : @"",
                                         self.fragment.length ? self.fragment : @""]];
        }
    }
    return self;
}

@end


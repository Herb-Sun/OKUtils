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

NSString *OKRepeat(NSString *string, NSUInteger length)
{
    NSMutableString *stringM = [NSMutableString string];
    for (int i = 0; i < length; i++) {
        [stringM appendString:string];
    }
    return [stringM mutableCopy];
}

@implementation NSString (OKUtils_Category)

- (NSString *)padStart:(NSUInteger)length string:(NSString *)string {
    NSMutableString *stringM = [NSMutableString stringWithString:self];
    [stringM insertString:OKRepeat(string, length) atIndex:0];
    return [stringM mutableCopy];
}
- (NSString *)padEnd:(NSUInteger)length string:(NSString *)string {
    NSMutableString *stringM = [NSMutableString stringWithString:self];
    [stringM insertString:OKRepeat(string, length) atIndex:self.length];
    return [stringM mutableCopy];
}

- (NSString *)trim {
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

- (NSString *)trimWhiteSpace {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

- (NSString *)trimStart {
    NSUInteger len = self.length;
    if (!len) return self;
    
    if ([self containsString:@" "]
        || [self containsString:@"\r"]
        || [self containsString:@"\n"]
        || [self containsString:@"\r\n"]) {
        int flag = 0;
        for (int i = 0; i < self.length; i++) {
            unichar ch =  [self characterAtIndex:i];
            if (ch == 9 || ch == 10 || ch == 13 || ch == 32) continue;
            flag = i; break;
        }
        return [self substringFromIndex:flag];
    }
    return self;
}

- (NSString *)trimEnd {
    NSUInteger len = self.length;
    if (!len) return self;
    
    if ([self containsString:@" "]
        || [self containsString:@"\r"]
        || [self containsString:@"\n"]
        || [self containsString:@"\r\n"]) {
        long flag = 0;
        for (long i = self.length - 1; i >= 0; i--) {
            unichar ch =  [self characterAtIndex:i];
            if (ch == 9 || ch == 10 || ch == 13 || ch == 32) continue;
            flag = i + 1; break;
        }
        return [self substringToIndex:flag];
    }
    return self;
}

- (CGSize)sizeWithFont:(UIFont *)font containerSize:(CGSize)containerSize {
    UIFont *textFont = font ? : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    CGSize textSize = CGSizeZero;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                     NSParagraphStyleAttributeName: paragraph};
        textSize = [self boundingRectWithSize:containerSize
                                      options:(NSStringDrawingUsesLineFragmentOrigin |
                                               NSStringDrawingUsesFontLeading |
                                               NSStringDrawingTruncatesLastVisibleLine)
                                   attributes:attributes
                                      context:nil].size;
    } else {
        textSize = [self sizeWithFont:textFont
                    constrainedToSize:containerSize
                        lineBreakMode:NSLineBreakByWordWrapping];
    }
#else
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: [NSParagraphStyle defaultParagraphStyle]};
    
    textSize = [self boundingRectWithSize:containerSize
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingUsesFontLeading |
                                           NSStringDrawingTruncatesLastVisibleLine)
                               attributes:attributes
                                  context:nil].size;
#endif
    return CGSizeMake(ceil(textSize.width), ceil(textSize.height));
}

@end

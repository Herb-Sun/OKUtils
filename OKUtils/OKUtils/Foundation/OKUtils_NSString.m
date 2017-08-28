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


@implementation NSString (OKUtils_Category)


- (CGFloat)widthWithFont:(UIFont *)font containerHeight:(CGFloat)containerHeight {
    return [self sizeWithFont:font containerSize:CGSizeMake(containerHeight, CGFLOAT_MAX)].width;
}

- (CGFloat)heightWithFont:(UIFont *)font containerWidth:(CGFloat)containerWidth {
    return [self sizeWithFont:font containerSize:CGSizeMake(containerWidth, CGFLOAT_MAX)].height;
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

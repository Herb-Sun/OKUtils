//
//  OKUtils_UIColor.m
//  OKUtils
//
//  Created by MAC on 2017/8/24.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import "OKUtils_UIColor.h"

UIColor *OKColor_Random(void)
{
    return [UIColor colorWithRed:arc4random_uniform(256)/255.0
                           green:arc4random_uniform(256)/255.0
                            blue:arc4random_uniform(256)/255.0
                           alpha:1.0];
}

UIColor *OKColor_Inverted(UIColor *color)
{
    CGFloat red, green, blue, alpha;
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    if (CGColorGetNumberOfComponents(color.CGColor) == 2) {
        red   = components[0];
        green = components[0];
        blue  = components[0];
        alpha = components[1];
    } else {
        red   = components[0];
        green = components[1];
        blue  = components[2];
        alpha = components[3];
    }
    
    return OKColor_RGBA(1-red, 1-green, 1-blue, alpha);
}

UIColor *OKColor_RGB(CGFloat r, CGFloat g, CGFloat b)
{
    return OKColor_RGBA(r, g, b, 1.0);
}

UIColor *OKColor_RGBA(CGFloat r, CGFloat g, CGFloat b, CGFloat a)
{
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];
}

UIColor *OKColor_Hex(unsigned int hex)
{
    return OKColor_HexA(hex, 1.0);
}

UIColor *OKColor_HexA(unsigned int hex, CGFloat alpha)
{
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0
                           green:((float)((hex & 0xFF00) >> 8)) / 255.0
                            blue:((float)(hex & 0xFF)) / 255.0
                           alpha:alpha];
}

UIColor *OKColor_HexString(NSString *hexString)
{
    return OKColor_HexStringA(hexString, 1.0);
}

UIColor *OKColor_HexStringA(NSString *hexString, CGFloat alpha)
{
    if (hexString.length == 0) return [UIColor blackColor];
    
    unsigned int hex = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1];
    [scanner scanHexInt:&hex];
    return OKColor_HexA(hex, alpha);
}

UIColor *OKColor_Gradient(NSArray<UIColor *> *colors, CGFloat height)
{
    CGSize size = CGSizeMake(1, height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef    context    = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (__bridge CFArrayRef)colors, NULL);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, size.height), 0);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:image];
}

UIColor *OKColorFromImage(UIImage *image)
{
    uint32_t bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
    CGSize          thumbSize  = CGSizeMake(50, 50);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef    context    = CGBitmapContextCreate(NULL,
                                                       thumbSize.width,
                                                       thumbSize.height,
                                                       8,//bits per component
                                                       thumbSize.width*4,
                                                       colorSpace,
                                                       bitmapInfo);
    
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, image.CGImage);
    CGColorSpaceRelease(colorSpace);
    
    unsigned char *data = CGBitmapContextGetData(context);
    if (data == NULL) {
        CGContextRelease(context);
        return nil;
    }
    NSCountedSet *set = [NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];
    for (int x = 0; x < thumbSize.width; x++) {
        for (int y = 0; y < thumbSize.height; y++) {
            int offset = 4*(x*y);
            int red    = data[offset];
            int green  = data[offset+1];
            int blue   = data[offset+2];
            int alpha  = data[offset+3];
            
            [set addObject:@[@(red), @(green), @(blue), @(alpha)]];
        }
    }
    CGContextRelease(context);
    
    NSEnumerator *enumerator = [set objectEnumerator];
    NSArray      *curColor   = nil;
    NSArray      *maxColor   = nil;
    NSUInteger   maxCount    = 0;
    while ( (curColor = [enumerator nextObject]) != nil) {
        NSUInteger tmpCount = [set countForObject:curColor];
        if (tmpCount < maxCount) continue;
        maxCount = tmpCount;
        maxColor = curColor;
    }
    
    return OKColor_RGBA([maxColor[0] intValue],
                        [maxColor[1] intValue],
                        [maxColor[2] intValue],
                        [maxColor[3] intValue]);
}

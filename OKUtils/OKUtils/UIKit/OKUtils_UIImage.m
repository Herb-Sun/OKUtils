//
//  OKUtils_UIImage.m
//  OKUtils
//
//  Created by MAC on 2017/8/23.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import "OKUtils_UIImage.h"
#import <Accelerate/Accelerate.h>
#import <QuartzCore/QuartzCore.h>

NS_INLINE CGFloat __OKDegreesToRadians(CGFloat degrees) { return degrees * M_PI / 180; }
NS_INLINE CGFloat __OKRadiansToDegrees(CGFloat radians) { return radians * 180/M_PI; }

UIImage *OKImageByColor(UIColor *color)
{
    CGRect rect = CGRectMake(0, 0, 1.0, 1.0);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

UIImage *OKImageByScreenShot(void)
{
    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
    UIGraphicsBeginImageContext(screenWindow.frame.size);
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

UIImage *OKImageByScreenShotWithoutStatusBar(void)
{
    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect screenRect = CGRectMake(0,
                                   20,
                                   [[UIScreen mainScreen] bounds].size.width,
                                   [[UIScreen mainScreen] bounds].size.height - 20);
    
    UIGraphicsBeginImageContext(screenRect.size);
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

UIImage *OKImageByView(UIView *theView)
{
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

UIImage *OKImageByViewAtFrame(UIView *theView, CGRect atFrame)
{
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(atFrame);
    [theView.layer renderInContext:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

UIImage *OKImagByStretchable(UIImage *theImage)
{
    return OKImageByStretchableScale(theImage, 0.5, 0.5);
}

UIImage *OKImageByStretchableScale(UIImage *theImage, CGFloat leftCap, CGFloat topCap)
{
    return [theImage stretchableImageWithLeftCapWidth:theImage.size.width * leftCap
                                      topCapHeight:theImage.size.height * topCap];
}

UIImage *OKImageByCircled(UIImage *theImage)
{
    UIGraphicsBeginImageContextWithOptions(theImage.size, NO, 0.0);
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, theImage.size.width, theImage.size.height);
    CGContextAddEllipseInRect(ctr, rect);
    CGContextClip(ctr);
    [theImage drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

UIImage *OKImageBySlice(UIImage *theImage, CGRect rect)
{
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(theImage.CGImage, rect);
    CGRect targetRect = CGRectMake(0, 0, CGImageGetWidth(imageRef), CGImageGetHeight(imageRef));
    
    UIGraphicsBeginImageContext(targetRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, targetRect, imageRef);
    
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    CGContextRelease(context);
    CGImageRelease(imageRef);
    UIGraphicsEndImageContext();
    
    return image;
}

UIImage *OKImageByScaled(UIImage *theImage, CGSize size)
{
    UIGraphicsBeginImageContext(size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGRectMake(0.0, 0.0, size.width, size.height), theImage.CGImage);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

UIImage *OKImageFixOrientation(UIImage *theImage) {
    
    if (theImage.imageOrientation == UIImageOrientationUp) return theImage;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (theImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, theImage.size.width, theImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, theImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, theImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    switch (theImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, theImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, theImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    CGContextRef ctx = CGBitmapContextCreate(NULL,
                                             theImage.size.width,
                                             theImage.size.height,
                                             CGImageGetBitsPerComponent(theImage.CGImage),
                                             0,
                                             CGImageGetColorSpace(theImage.CGImage),
                                             CGImageGetBitmapInfo(theImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (theImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,theImage.size.height,theImage.size.width), theImage.CGImage);
            break;
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,theImage.size.width,theImage.size.height), theImage.CGImage);
            break;
    }
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    CGContextRelease(ctx);
    CGImageRelease(imageRef);
    return image;
}

UIImage *OKImageFlipVertical(UIImage *theImage)
{
    CGRect rect = CGRectMake(0, 0, theImage.size.width, theImage.size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClipToRect(ctx, rect);
    CGContextDrawImage(ctx, rect, theImage.CGImage);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

UIImage *OKImageFlipHorizontal(UIImage *theImage)
{
    CGRect rect = CGRectMake(0, 0, theImage.size.width, theImage.size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClipToRect(ctx, rect);
    CGContextRotateCTM(ctx, M_PI);
    CGContextTranslateCTM(ctx, -rect.size.width, -rect.size.height);
    CGContextDrawImage(ctx, rect, theImage.CGImage);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

UIImage *OKImageRotatedByDegrees(UIImage *theImage, CGFloat degrees)
{
    return OKImageRotatedByRadians(theImage, __OKDegreesToRadians(degrees));
}

UIImage *OKImageRotatedByRadians(UIImage *theImage, CGFloat radians)
{
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,theImage.size.width, theImage.size.height)];
    
    CGAffineTransform t = CGAffineTransformMakeRotation(radians);
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    // Rotate the image context
    CGContextRotateCTM(bitmap, radians);
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-theImage.size.width / 2, -theImage.size.height / 2, theImage.size.width, theImage.size.height), theImage.CGImage);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

UIImage *OKImageByBlurred(UIImage *theImage, CGFloat radio)
{
    if (radio < 0.0 || radio > 1.0) { radio = 0.5; }
    
    int boxSize = (int)(radio * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error  error;
    void *pixelBuffer;
    CGImageRef imageRef = theImage.CGImage;
    
    CGDataProviderRef inProvider   = CGImageGetDataProvider(imageRef);
    CFDataRef         inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width    = CGImageGetWidth(imageRef);
    inBuffer.height   = CGImageGetHeight(imageRef);
    inBuffer.rowBytes = CGImageGetBytesPerRow(imageRef);
    
    inBuffer.data = (void *)CFDataGetBytePtr(inBitmapData);
    pixelBuffer = malloc(CGImageGetBytesPerRow(imageRef) * CGImageGetHeight(imageRef));
    
    outBuffer.data     = pixelBuffer;
    outBuffer.width    = CGImageGetWidth(imageRef);
    outBuffer.height   = CGImageGetHeight(imageRef);
    outBuffer.rowBytes = CGImageGetBytesPerRow(imageRef);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (!error) {
        error = vImageBoxConvolve_ARGB8888(&outBuffer, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    }
    
    if (error) return theImage;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    
    CGImageRef ref = CGBitmapContextCreateImage(ctx);
    
    UIImage *returnImage = [UIImage imageWithCGImage:ref];
    
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(ref);
    
    return returnImage;
}

// CIGaussianBlur ---> 高斯模糊
// CIBoxBlur      ---> 均值模糊(Available in iOS 9.0 and later)
// CIDiscBlur     ---> 环形卷积模糊(Available in iOS 9.0 and later)
// CIMedianFilter ---> 中值模糊, 用于消除图像噪点, 无需设置radius(Available in iOS 9.0 and later)
// CIMotionBlur   ---> 运动模糊, 用于模拟相机移动拍摄时的扫尾效果(Available in iOS 9.0 and later)
UIImage *OKImageByBlurredStyle(UIImage *theImage, OKImageBlurStyle blurStyle, CGFloat radio)
{
    NSDictionary *blurDict = @{@(OKImageBlurStyleNone) : @"",
                               @(OKImageBlurStyleGaussian) : @"CIGaussianBlur",
                               @(OKImageBlurStyleBox) : @"CIBoxBlur",
                               @(OKImageBlurStyleDisc) : @"CIDiscBlur",
                               @(OKImageBlurStyleMedian) : @"CIMedianFilter",
                               @(OKImageBlurStyleMotion) : @"CIMotionBlur"};
    
    NSString *blurName = [blurDict objectForKey:@(blurStyle)];
    
    if (blurName.length > 0) {
        
        CIContext *context = [CIContext contextWithOptions:nil];
        CIImage *inputImage = [[CIImage alloc] initWithImage:theImage];
        CIFilter *filter = [CIFilter filterWithName:blurName];
        [filter setValue:inputImage forKey:kCIInputImageKey];
        if (![blurName isEqualToString:@"CIMedianFilter"]) {
            [filter setValue:@(radio) forKey:@"inputradio"];
        }
        CIImage *result = [filter valueForKey:kCIOutputImageKey];
        CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
        UIImage *resultImage = [UIImage imageWithCGImage:cgImage];
        CGImageRelease(cgImage);
        return resultImage;
    }
    return theImage;
}

// 怀旧 --> CIPhotoEffectInstant                         单色 --> CIPhotoEffectMono
// 黑白 --> CIPhotoEffectNoir                            褪色 --> CIPhotoEffectFade
// 色调 --> CIPhotoEffectTonal                           冲印 --> CIPhotoEffectProcess
// 岁月 --> CIPhotoEffectTransfer                        铬黄 --> CIPhotoEffectChrome
// CILinearToSRGBToneCurve, CISRGBToneCurveToLinear, CIGaussianBlur, CIBoxBlur, CIDiscBlur, CISepiaTone, CIDepthOfField
UIImage *OKImageByEffectted(UIImage *theImage, OKImageEffectStyle effectStyle)
{
    NSDictionary *effectDict = @{@(OKImageEffectStyleNone) : @"",
                                 @(OKImageEffectStyleInstant) : @"CIPhotoEffectInstant",
                                 @(OKImageEffectStyleNoir) : @"CIPhotoEffectNoir",
                                 @(OKImageEffectStyleTonal) : @"CIPhotoEffectTonal",
                                 @(OKImageEffectStyleTransfer) : @"CIPhotoEffectTransfer",
                                 @(OKImageEffectStyleMono) : @"CIPhotoEffectMono",
                                 @(OKImageEffectStyleFade) : @"CIPhotoEffectFade",
                                 @(OKImageEffectStyleProcess) : @"CIPhotoEffectProcess",
                                 @(OKImageEffectStyleChrome) : @"CIPhotoEffectChrome"};
    NSString *effectName = [effectDict objectForKey:@(effectStyle)];
    
    if (effectName.length > 0) {
        
        CIContext *context = [CIContext contextWithOptions:nil];
        CIImage *inputImage = [[CIImage alloc] initWithImage:theImage];
        CIFilter *filter = [CIFilter filterWithName:effectName];
        [filter setValue:inputImage forKey:kCIInputImageKey];
        CIImage *result = [filter valueForKey:kCIOutputImageKey];
        CGImageRef imageRef = [context createCGImage:result fromRect:[result extent]];
        
        UIImage *image = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
        return image;
    }
    return theImage;
}

UIImage *OKImageBySaturated(UIImage *theImage, CGFloat saturation, CGFloat brightness, CGFloat contrast)
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:theImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorControls"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    
    [filter setValue:@(saturation) forKey:@"inputSaturation"];
    [filter setValue:@(brightness) forKey:@"inputBrightness"];
    [filter setValue:@(contrast) forKey:@"inputContrast"];
    
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef imageRef = [context createCGImage:result fromRect:result.extent];
    
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return image;
}

UIImage *OKImageByConvertGray(UIImage *theImage)
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 theImage.size.width,
                                                 theImage.size.height,
                                                 8,
                                                 0,
                                                 colorSpace,
                                                 kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL) return theImage;
    
    CGContextDrawImage(context, CGRectMake(0, 0, theImage.size.width, theImage.size.width), theImage.CGImage);
    CGImageRef contextRef = CGBitmapContextCreateImage(context);
    UIImage *image = [UIImage imageWithCGImage:contextRef];
    CGContextRelease(context);
    CGImageRelease(contextRef);
    
    return image;
}

UIImage *OKImageByMerged(UIImage *firstImage, UIImage *secondImage)
{
    CGImageRef firstImageRef  = firstImage.CGImage;
    CGFloat    firstWidth     = CGImageGetWidth(firstImageRef);
    CGFloat    firstHeight    = CGImageGetHeight(firstImageRef);
    
    CGImageRef secondImageRef = secondImage.CGImage;
    CGFloat    secondWidth    = CGImageGetWidth(secondImageRef);
    CGFloat    secondHeight   = CGImageGetHeight(secondImageRef);
    
    CGSize     mergedSize     = CGSizeMake(MAX(firstWidth, secondWidth), MAX(firstHeight, secondHeight));
    UIGraphicsBeginImageContext(mergedSize);
    [firstImage drawInRect:CGRectMake(0, 0, firstWidth, firstHeight)];
    [secondImage drawInRect:CGRectMake(0, 0, secondWidth, secondHeight)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

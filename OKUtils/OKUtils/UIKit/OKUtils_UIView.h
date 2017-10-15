//
//  OKUtils_UIView.h
//  OKUtils
//
//  Created by MAC on 2017/8/23.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (OKUtils_Category_Frame)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat maxY;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize  size;

@end

#pragma mark - OKUtils_Category_Border

typedef NS_OPTIONS(NSInteger, OKBorderType) {
    OKBorderTypeNone    = 0,
    OKBorderTypeTop     = 1 << 0,
    OKBorderTypeLeft    = 1 << 1,
    OKBorderTypeBottom  = 1 << 2,
    OKBorderTypeRight   = 1 << 3,
    OKBorderTypeAll     = ~0L,
};

@interface UIView (OKUtils_Category_Border)

- (void)clearBorderStyle;

/**
 添加边框
 @param color       边框颜色
 @param borderWidth 边框宽度
 @param type        边框类型
 */
- (void)addBorderWithColor:(UIColor *)color borderWidth:(CGFloat)borderWidth borderType:(OKBorderType)type;

/**
 添加边框
 @param color       边框颜色
 @param borderWidth 边框宽度
 @param margin      上边框,下边框的左边距
 @param type        边框类型
 */
- (void)addBorderWithColor:(UIColor *)color borderWidth:(CGFloat)borderWidth margin:(CGFloat)margin borderType:(OKBorderType)type;

/**
 添加边框
 @param color       边框颜色
 @param borderWidth 边框宽度
 @param opacity     边框的透明度(取值范围0-1)
 @param type        边框类型
 */
- (void)addBorderWithColor:(UIColor *)color borderWidth:(CGFloat)borderWidth opacity:(CGFloat)opacity borderType:(OKBorderType)type;

/**
 添加边框
 @param color       边框颜色
 @param borderWidth 边框宽度
 @param opacity     边框的透明度(取值范围0-1)
 @param margin      上边框,下边框的左边距
 @param type        边框类型
 */
- (void)addBorderWithColor:(UIColor *)color borderWidth:(CGFloat)borderWidth opacity:(CGFloat)opacity margin:(CGFloat)margin borderType:(OKBorderType)type;

@end

#pragma mark - OKUtils_Category_Corner

@interface UIView (OKUtils_Category_Corner)

- (void)roundCornerWithRadius:(CGFloat)radius;
- (void)roundWidthStyle;
- (void)roundHeightStyle;

/**
 切角

 @param corners corners
 @param radius radius
 */
- (void)roundCorners:(UIRectCorner)corners radius:(CGFloat)radius;

@end

NS_ASSUME_NONNULL_END

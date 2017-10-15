//
//  OKUtils_UIView.m
//  OKUtils
//
//  Created by MAC on 2017/8/23.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import "OKUtils_UIView.h"

@implementation UIView (OKUtils_Category_Frame)

- (CGFloat)x { return CGRectGetMinX(self.frame); }
- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)y { return CGRectGetMinY(self.frame); }
- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)maxX { return CGRectGetMaxX(self.frame); }
- (void)setMaxX:(CGFloat)maxX { self.x = maxX - self.width; }

- (CGFloat)maxY { return CGRectGetMaxY(self.frame); }
-(void)setMaxY:(CGFloat)maxY { self.y = maxY - self.height; }

- (CGFloat)centerX { return CGRectGetMidX(self.frame); };
- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerY { return CGRectGetMidY(self.frame); }
- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)width { return self.frame.size.width; }
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height { return self.frame.size.height; }
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)origin { return self.frame.origin; }
- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size { return self.frame.size; }
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

@end


@implementation UIView (OKUtils_Category_Border)

- (void)clearBorderStyle {
    self.layer.borderWidth = 0;
    self.layer.masksToBounds = YES;
}

- (void)addBorderWithColor:(UIColor *)color borderWidth:(CGFloat)borderWidth borderType:(OKBorderType)type {
    [self addBorderWithColor:color borderWidth:borderWidth opacity:1.0 margin:0.0 borderType:type];
}

- (void)addBorderWithColor:(UIColor *)color borderWidth:(CGFloat)borderWidth margin:(CGFloat)margin borderType:(OKBorderType)type {
    [self addBorderWithColor:color borderWidth:borderWidth opacity:1.0 margin:margin borderType:type];
}

- (void)addBorderWithColor:(UIColor *)color borderWidth:(CGFloat)borderWidth opacity:(CGFloat)opacity borderType:(OKBorderType)type {
    [self addBorderWithColor:color borderWidth:borderWidth opacity:opacity margin:0.0 borderType:type];
}

- (void)addBorderWithColor:(UIColor *)color borderWidth:(CGFloat)borderWidth opacity:(CGFloat)opacity margin:(CGFloat)margin borderType:(OKBorderType)type {
    [self layoutIfNeeded];
    
    if (type & OKBorderTypeTop) {
        CALayer *border = [CALayer layer];
        border.opacity = opacity;
        border.backgroundColor = color.CGColor;
        border.frame = CGRectMake(margin, 0, self.frame.size.width - margin, borderWidth);
        [self.layer addSublayer:border];
    }
    
    if (type & OKBorderTypeLeft) {
        CALayer *border = [CALayer layer];
        border.opacity = opacity;
        border.backgroundColor = color.CGColor;
        border.frame = CGRectMake(0, 0, borderWidth, self.frame.size.height);
        [self.layer addSublayer:border];
    }
    
    if (type & OKBorderTypeBottom) {
        CALayer *border = [CALayer layer];
        border.opacity = opacity;
        border.backgroundColor = color.CGColor;
        border.frame = CGRectMake(margin, self.frame.size.height - borderWidth, self.frame.size.width - margin, borderWidth);
        [self.layer addSublayer:border];
    }
    
    if (type & OKBorderTypeRight) {
        CALayer *border = [CALayer layer];
        border.opacity = opacity;
        border.backgroundColor = color.CGColor;
        border.frame = CGRectMake(self.frame.size.width - borderWidth, 0, borderWidth, self.frame.size.height);
        [self.layer addSublayer:border];
    }
}

@end

#pragma mark - OKUtils_Category_Corner

@implementation UIView (OKUtils_Category_Corner)

- (void)roundCornerWithRadius:(CGFloat)radius {
    if (CGRectEqualToRect(self.frame, CGRectZero)) { [self layoutIfNeeded]; }
    self.layer.cornerRadius  = radius;
    self.layer.masksToBounds = YES;
}

- (void)roundWidthStyle {
    [self roundCornerWithRadius:(CGRectGetWidth(self.frame) * 0.5)];
}

- (void)roundHeightStyle {
    [self roundCornerWithRadius:(CGRectGetHeight(self.frame) * 0.5)];
}

- (void)roundCorners:(UIRectCorner)corners radius:(CGFloat)radius {
    
    if (CGRectEqualToRect(self.frame, CGRectZero)) { [self layoutIfNeeded]; }
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                           byRoundingCorners:corners
                                                 cornerRadii:(CGSize){radius, radius}].CGPath;
    self.clipsToBounds = YES;
}

@end


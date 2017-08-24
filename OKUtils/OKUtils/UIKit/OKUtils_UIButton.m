//
//  OKUtils_UIButton.m
//  OKUtils
//
//  Created by MAC on 2017/8/24.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import "OKUtils_UIButton.h"
#import "OKUtils_UIImage.h"
#import <objc/runtime.h>

@implementation UIButton (OKUtils_Category)

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state {
    [self setBackgroundImage:OKImageFromColor(color) forState:state];
}

- (UIEdgeInsets)touchAreaInsets {
    return [objc_getAssociatedObject(self, _cmd) UIEdgeInsetsValue];
}

/**
 *  设置按钮额外热区
 */
- (void)setTouchAreaInsets:(UIEdgeInsets)touchAreaInsets {
    NSValue *value = [NSValue valueWithUIEdgeInsets:touchAreaInsets];
    objc_setAssociatedObject(self, @selector(touchAreaInsets), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    UIEdgeInsets touchAreaInsets = self.touchAreaInsets;
    CGRect       bounds          = self.bounds;
    bounds = CGRectMake(bounds.origin.x - touchAreaInsets.left,
                        bounds.origin.y - touchAreaInsets.top,
                        bounds.size.width + touchAreaInsets.left + touchAreaInsets.right,
                        bounds.size.height + touchAreaInsets.top + touchAreaInsets.bottom);
    return CGRectContainsPoint(bounds, point);
}

@end

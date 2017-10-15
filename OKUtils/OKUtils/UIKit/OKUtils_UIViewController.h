//
//  OKUtils_UIViewController.h
//  OKUtils
//
//  Created by herb on 2017/10/15.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^OKBackButtonHandler)(UIViewController *vc);

@interface UIViewController (OKUtils_Category)

/// UIViewController 是否可见
- (BOOL)isVisible;

/**
 *  获取当前显示的ViewController
 */
+ (nullable UIViewController *)fetchCurrentViewController;

/**
 *  视图层级
 *
 *  @return 视图层级字符串
 */
- (NSString *)recursiveDescription;

- (void)backButtonTouched:(OKBackButtonHandler)backButtonHandler;

- (void)addChildViewController:(UIViewController *)controller;
- (void)addChildViewController:(UIViewController *)controller atFrame:(CGRect)frame;
- (void)addChildViewController:(UIViewController *)controller inView:(UIView *)view atFrame:(CGRect)frame;

- (void)removeChildViewController:(UIViewController *)controller;

- (void)dismissToRootViewControllerAnimated:(BOOL)flag;

@end

NS_ASSUME_NONNULL_END

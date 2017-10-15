//
//  OKUtils_UIViewController.m
//  OKUtils
//
//  Created by herb on 2017/10/15.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import "OKUtils_UIViewController.h"
#import <objc/runtime.h>

@implementation UIViewController (OKUtils_PrivateCategory)

+ (UIViewController *)__topViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[UITabBarController class]]) {
        return [self __topViewController:[(UITabBarController *)viewController selectedViewController]];
    } else if ([viewController isKindOfClass:[UINavigationController class]]) {
        return [self __topViewController:[(UINavigationController *)viewController topViewController]];
    } else if (viewController.presentedViewController) {
        return [self __topViewController:viewController.presentedViewController];
    } else {
        return viewController;
    }
}

- (void)__addDescriptionToString:(NSMutableString *)string indentLevel:(NSInteger)indentLevel {
    NSString *padding = [@"" stringByPaddingToLength:indentLevel withString:@" " startingAtIndex:0];
    [string appendString:padding];
    [string appendFormat:@"%@, %@", [self debugDescription], NSStringFromCGRect(self.view.frame)];
    
    for (UIViewController *childController in self.childViewControllers) {
        [string appendFormat:@"\n%@>", padding];
        [childController __addDescriptionToString:string indentLevel:indentLevel + 1];
    }
}

@end

@implementation UIViewController (OKUtils_Category)

- (BOOL)isVisible {
    return [self isViewLoaded] && self.view.window;
}

+ (UIViewController *)fetchCurrentViewController {
    UIViewController *result = nil;
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] lastObject];
    
    id nextResponder = [frontView nextResponder];
    while ([nextResponder nextResponder]) {
        nextResponder = [nextResponder nextResponder];
    }
    
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    }
    else {
        result = window.rootViewController;
    }
    return [self __topViewController:result];
}

- (NSString *)recursiveDescription {
    NSMutableString *description = [NSMutableString stringWithFormat:@"\n"];
    [self __addDescriptionToString:description indentLevel:0];
    return description;
}

- (void)backButtonTouched:(OKBackButtonHandler)backButtonHandler {
    objc_setAssociatedObject(self, @selector(backButtonHandler), backButtonHandler, OBJC_ASSOCIATION_COPY);
}

- (OKBackButtonHandler)backButtonHandler {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)addChildViewController:(UIViewController *)controller {
    [self addChildViewController:controller inView:self.view atFrame:self.view.bounds];
}

- (void)addChildViewController:(UIViewController *)controller atFrame:(CGRect)frame {
    [self addChildViewController:controller inView:self.view atFrame:frame];
}

- (void)addChildViewController:(UIViewController *)controller inView:(UIView *)view atFrame:(CGRect)frame {
    [controller willMoveToParentViewController:self];
    [self addChildViewController:controller];
    
    controller.view.frame = frame;
    [view addSubview:controller.view];
    
    [controller didMoveToParentViewController:self];
}

- (void)removeChildViewController:(UIViewController *)controller {
    [controller willMoveToParentViewController:nil];
    [controller removeFromParentViewController];
    [controller.view removeFromSuperview];
}

- (void)dismissToRootViewControllerAnimated:(BOOL)flag {
    UIViewController *vc = self;
    while (vc.presentingViewController) {
        vc = vc.presentingViewController;
    }
    [vc dismissViewControllerAnimated:flag completion:nil];
}

@end

@implementation UINavigationController (OKUtils_PrivateCategory)

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    
    if ([self.viewControllers count] < [navigationBar.items count]) {
        return YES;
    }
    
    UIViewController    *vc     = [self topViewController];
    OKBackButtonHandler handler = [vc backButtonHandler];
    if (handler) {
        dispatch_async(dispatch_get_main_queue(), ^{
            handler(self);
        });
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
    }
    
    return NO;
}

@end



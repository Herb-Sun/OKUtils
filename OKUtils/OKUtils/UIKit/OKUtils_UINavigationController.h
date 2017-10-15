//
//  OKUtils_UINavigationController.h
//  OKUtils
//
//  Created by MAC on 2017/8/25.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (OKUtils_Category)

- (void)pushViewController:(UIViewController *)controller
            withTransition:(UIViewAnimationTransition)transition;

- (UIViewController *)popViewControllerWithTransition:(UIViewAnimationTransition)transition;

/**
 *  RootViewController
 *
 *  @return RootViewController
 */
- (nullable UIViewController *)rootViewController;

/**
 *  UINavigationController 栈中是否包含某个UIViewController
 */
- (BOOL)stackContainViewController:(Class)controllerClass;

/**
 *  判断是否只有一个RootViewController
 *
 *  @return 是否只有一个RootViewController
 */
- (BOOL)isOnlyContainRootViewController;

/**
 *  pop n层
 *
 *  @param level  n层
 *  @param animated  是否动画
 *
 *  @return pop之后的viewcontrolers
 */
- (nullable NSArray *)popToViewControllerWithLevel:(NSUInteger)level animated:(BOOL)animated;

/**
 *  返回UINavigationController 中指定的UIViewController的前一个UIViewController
 *
 *  @param controllerClass 指定UIViewController
 */
- (void)popBeforeViewController:(nonnull Class)controllerClass;

/**
 *  从UINavigationController stack 中 移除顶部VC前面几个UIViewController
 *
 *  @param count 移除的UIViewController的个数
 */
- (void)removeViewControllerFromStackWithCount:(NSUInteger)count;

/**
 *  移除UINavigationController stack中指定的UIViewController
 *
 *  @param controllerClass 移除的viewController  类型
 */
- (void)removeViewControllerFromStack:(nonnull Class)controllerClass;

/**
 *  移除UINavigationController stack中多个指定的UIViewController
 *
 *  @param controllerClass 移除的viewController  类型
 */
- (void)removeViewControllersFromStack:(nonnull Class)controllerClass, ...;

/**
 *  移除UINavigationController stack顶部UIViewController
 *
 *  @param controllerClass 移除到哪个UIViewController
 */
- (void)removeViewControllersFromStackToViewController:(nonnull Class)controllerClass;

@end


NS_ASSUME_NONNULL_END

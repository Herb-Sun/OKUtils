//
//  OKShareAnimation.m
//  OKUtils
//
//  Created by MAC on 2017/9/11.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import "OKShareAnimation.h"
#import "OKShareViewController.h"

@interface OKShareAnimation ()
{
    @private
    OKAnimationStyle _animationStyle;
}
@end

@implementation OKShareAnimation

- (instancetype)initWithAnimationStyle:(OKAnimationStyle)style {
    if (self = [super init]) {
        _animationStyle = style;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.7;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    if (_animationStyle == OKAnimationStyleDown) { // down
        
        UITransitionContextViewControllerKey fromViewControllerKey = UITransitionContextFromViewControllerKey;
        OKShareViewController *fromVC = [transitionContext viewControllerForKey:fromViewControllerKey];
        
        NSTimeInterval duration = [self transitionDuration:transitionContext];
        fromVC.maskView.alpha = 1.0;
        fromVC.containerView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        
        [UIView animateWithDuration:duration delay:0.0 usingSpringWithDamping:0.9 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            
            fromVC.maskView.alpha = 0.0;
            fromVC.containerView.transform = CGAffineTransformMakeScale(0.0, 0.0);
            
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
        
    } else { // up
        
        UITransitionContextViewControllerKey toViewControllerKey = UITransitionContextToViewControllerKey;
        OKShareViewController *toVC = [transitionContext viewControllerForKey:toViewControllerKey];
        
        UIView *containerView = transitionContext.containerView;
        NSTimeInterval duration = [self transitionDuration:transitionContext];
        toVC.maskView.alpha = 0.0;
        
        toVC.containerView.transform = CGAffineTransformMakeScale(0.0, 0.0);
        [containerView addSubview:toVC.view];
        
        [UIView animateWithDuration:duration delay:0.0 usingSpringWithDamping:0.9 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            
            toVC.maskView.alpha = 1.0;
            toVC.containerView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}

@end

//
//  OKShareViewController.m
//  OKUtils
//
//  Created by MAC on 2017/9/11.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import "OKShareViewController.h"
#import "OKShareAnimation.h"

@interface OKShareViewController () <UIViewControllerTransitioningDelegate>
{
    @private
    UIControl *_maskView;
    UIView *_containerView;
}

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *shareCollectionView;
@property (nonatomic, strong) UICollectionView *actionCollectionView;

@property (nonatomic, copy) NSString *pickerTitle;
@property (nonatomic, copy) NSString *pickerMessage;
@property (nonatomic, copy) NSArray *shareItems;
@property (nonatomic, copy) NSArray *shareActions;

@end

@implementation OKShareViewController

- (instancetype)initWithTitle:(NSString *)title {
    return [[[self class] alloc] initWithTitle:title message:nil];
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message {
    if (self = [super init]) {
        _pickerTitle = title;
        _pickerMessage = message;
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self setupAppearance];
}

- (void)setupAppearance {
    [self.view addSubview:self.maskView];
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:_maskView
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.view
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.0
                                                                      constant:0.0];
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:_maskView
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.view
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1.0
                                                                      constant:0.0];
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:_maskView
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.view
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1.0
                                                                      constant:0.0];
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:_maskView
                                                                     attribute:NSLayoutAttributeBottom
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.view
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1.0
                                                                      constant:0.0];
    
    [self.view addConstraints:@[topConstraint, leftConstraint, rightConstraint, bottomConstraint]];
}

- (void)maskViewAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addShareItem:(NSArray<OKShareItem *> *)shareItems {
    _shareItems = shareItems;
}

- (void)addShareAction:(NSArray<OKShareItem *> *)shareActions {
    _shareActions = shareActions;
}

#pragma mark - LazyLoad

- (UIControl *)maskView {
    if (!_maskView) {
        _maskView = [[UIControl alloc] init];
        _maskView.translatesAutoresizingMaskIntoConstraints = NO;
        _maskView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
        [_maskView addTarget:self action:@selector(maskViewAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _maskView;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor whiteColor];
    }
    return _containerView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    }
    return _flowLayout;
}

- (UICollectionView *)shareCollectionView {
    if (!_shareCollectionView) {
        _shareCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                                  collectionViewLayout:self.flowLayout];
    }
    return _shareCollectionView;
}

- (UICollectionView *)actionCollectionView {
    if (!_actionCollectionView) {
        _actionCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                                   collectionViewLayout:self.flowLayout];
    }
    return _actionCollectionView;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[OKShareAnimation alloc] initWithAnimationStyle:OKAnimationStyleUp];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[OKShareAnimation alloc] initWithAnimationStyle:OKAnimationStyleDown];
}

@end


@implementation OKShareItemCell

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

@end



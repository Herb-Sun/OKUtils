//
//  OKShareViewController.h
//  OKUtils
//
//  Created by MAC on 2017/9/11.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OKShareItem;

NS_ASSUME_NONNULL_BEGIN

@interface OKShareViewController : UIViewController

@property (nonatomic, strong, readonly) UIControl *maskView;
@property (nonatomic, strong, readonly) UIView *containerView;

- (instancetype)initWithTitle:(nullable NSString *)title;
- (instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message;

- (void)addShareItem:(NSArray<OKShareItem *> *)shareItems;
- (void)addShareAction:(NSArray<OKShareItem *> *)shareActions;

@end


@interface OKShareItemCell : UICollectionViewCell

@end

NS_ASSUME_NONNULL_END

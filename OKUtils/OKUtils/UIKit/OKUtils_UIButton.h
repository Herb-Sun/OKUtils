//
//  OKUtils_UIButton.h
//  OKUtils
//
//  Created by MAC on 2017/8/24.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (OKUtils_Category)

/// 设置按钮额外热区
@property (nonatomic, assign) UIEdgeInsets touchAreaInsets;

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state;

@end

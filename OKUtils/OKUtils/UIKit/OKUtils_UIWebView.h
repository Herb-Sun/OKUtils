//
//  OKUtils_UIWebView.h
//  OKUtils
//
//  Created by MAC on 2017/8/25.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (OKUtils_Category)

/// 获取某个标签的结点个数
- (NSUInteger)ok_nodeCountOfTag:(NSString *)tag;

/// 获取当前页面URL
- (NSString *)ok_fetchCurrentURL;

/// 获取标题
- (NSString *)ok_fetchTitle;

/// 获取图片
- (NSArray *)ok_fetchImages;

/// 获取当前页面所有链接
- (NSArray *)ok_fetchAllURL;

/// 改变指定标签的字体大小
- (void)ok_setFontSize:(CGFloat)fontSize withTag:(NSString *)tagName;

@end

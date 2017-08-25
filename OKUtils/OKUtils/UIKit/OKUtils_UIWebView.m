//
//  OKUtils_UIWebView.m
//  OKUtils
//
//  Created by MAC on 2017/8/25.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import "OKUtils_UIWebView.h"

@implementation UIWebView (OKUtils_Category)

/// 获取某个标签的结点个数
- (NSUInteger)ok_nodeCountOfTag:(NSString *)tag {
    NSString   *jsString = [NSString stringWithFormat:@"document.getElementsByTagName('%@').length", tag];
    NSUInteger len       = [[self stringByEvaluatingJavaScriptFromString:jsString] integerValue];
    return len;
}

/// 获取当前页面URL
- (NSString *)ok_fetchCurrentURL {
    return [self stringByEvaluatingJavaScriptFromString:@"document.location.href"];
}

/// 获取标题
- (NSString *)ok_fetchTitle {
    return [self stringByEvaluatingJavaScriptFromString:@"document.title"];
}

/// 获取所有图片链接
- (NSArray *)ok_fetchImages {
    NSMutableArray *arrImgURL = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self ok_nodeCountOfTag:@"img"]; i++) {
        NSString *jsString = [NSString stringWithFormat:@"document.getElementsByTagName('img')[%d].src", i];
        [arrImgURL addObject:[self stringByEvaluatingJavaScriptFromString:jsString]];
    }
    return arrImgURL;
}

/// 获取当前页面所有点击链接
- (NSArray *)ok_fetchAllURL {
    NSMutableArray *arrOnClicks = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self ok_nodeCountOfTag:@"a"]; i++) {
        NSString *jsString    = [NSString stringWithFormat:@"document.getElementsByTagName('a')[%d].getAttribute('onclick')", i];
        NSString *clickString = [self stringByEvaluatingJavaScriptFromString:jsString];
        NSLog(@"%@", clickString);
        [arrOnClicks addObject:clickString];
    }
    return arrOnClicks;
}

/// 改变指定标签的字体大小
- (void)ok_setFontSize:(CGFloat)fontSize withTag:(NSString *)tagName {
    NSString *jsString = [NSString stringWithFormat:
                          @"var nodes = document.getElementsByTagName('%@'); \
                          for(var i=0;i<nodes.length;i++){\
                          nodes[i].style.fontSize = '%fpx';}", tagName, fontSize];
    [self stringByEvaluatingJavaScriptFromString:jsString];
}

@end

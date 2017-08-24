//
//  OKUtils_UIApplication.m
//  OKUtils
//
//  Created by MAC on 2017/8/23.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import "OKUtils_UIApplication.h"

void OKScoreAPP(NSString *appId)
{
    NSString *urlString = [NSString stringWithFormat:@"https://itunes.apple.com/app/id%@", appId];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}


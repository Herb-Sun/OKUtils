//
//  TestDeallocView.m
//  OKUtils
//
//  Created by MAC on 2017/10/24.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import "TestDeallocView.h"

@implementation TestDeallocView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
    NSLog(@"dealloc");
}

@end

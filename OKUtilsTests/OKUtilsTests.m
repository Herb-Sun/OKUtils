//
//  OKUtilsTests.m
//  OKUtilsTests
//
//  Created by MAC on 2017/8/23.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OKUtils.h"

@interface OKUtilsTests : XCTestCase

@end

@implementation OKUtilsTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
//~!@#$%^&*()-_=+[]{}|\;:'",.<>?/
    // !"#$%&'()*+,-./ 33-47
    // {|}~ 123-126
    // [\]^_ 91-95
    // :;<=>?@ 58-64
    // 0-9 48-57
    // A-Z 65-90
    // a-z 97-122
    
    NSString *value = @"dkdk jdjdj";
    
    for (int i = 0; i < value.length - 1; i++) {
        unichar ch = [value characterAtIndex:i];
        if (ch > 126 || ch < 33) {
            NSLog(@"**不符合字符--%c", ch);
        } else {
            NSLog(@"符合字符====%c", ch);
        }
    }
    
    
    NSString *reg = @"\s+";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
    BOOL result = [pre evaluateWithObject:value];
    NSLog(@"--------%@", @(result));
}

- (void)testAAA {
    NSString *value = @"#$%^&*(5";
    
    NSArray *regs = @[@"^[0-9]+$",
                      @"^[A-Za-z]+$",
                      @"^[~!@#\\$%\\^&*()\\-_=\\+\\[\\]\\{\\}\\|\\;:'\",.<>?/]+$"];
    for (NSString *regex in regs) {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        if ([predicate evaluateWithObject:value]) {
            NSLog(@"%@--字母、数字及符号至少包含两种", regex);
        }
    }
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end

//
//  OKUtils_NSStringTests.m
//  OKUtils
//
//  Created by herb on 2017/9/10.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OKUtils.h"

@interface OKUtils_NSStringTests : XCTestCase

@end

@implementation OKUtils_NSStringTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testTrimStart {
    NSLog(@"%@", [@" aaa   \r\n/r/n" trimStart]);
    
}


- (void)testTrimEnd {
    NSString *testStr = @"aaa   \r\n";
    
    NSLog(@"%@", [testStr trimEnd]);
    NSLog(@"--%@--", [@"a " trimEnd]);

}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end

//
//  OKUtils_NSArrayTests.m
//  OKUtils
//
//  Created by MAC on 2017/9/7.
//  Copyright © 2017年 HERB. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OKUtils.h"
#import "YYKit.h"

@interface OKUtils_NSArrayTests : XCTestCase

@end

@implementation OKUtils_NSArrayTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    NSInteger i = 0;
    NSMutableArray *array = [NSMutableArray array];
    while (i < 11) {
        
        NSLog(@"%@---%@---%@", @(i),array, [array chunk:10]);
        [array addObject:@(i++)];
    }
    
}

- (void)testCompact {
    NSLog(@"--%@",  [@[@0, @1, @"", @" ", [NSNull null], @YES, @NO] compact]);
}

- (void)testDrop {
    NSLog(@"--%@",  [@[@1,@2,@3,@4,@5] drop:-1]);
    NSLog(@"--%@",  [@[@1,@2,@3,@4,@5] drop:2]);
    NSLog(@"--%@",  [@[@1,@2,@3,@4,@5] drop:10]);
    NSLog(@"--%@",  [@[@1,@2,@3,@4,@5] dropRight:-1]);
    NSLog(@"--%@",  [@[@1,@2,@3,@4,@5] dropRight:5]);
    NSLog(@"--%@",  [@[@1,@2,@3,@4,@5] dropRight:10]);
    NSLog(@"--%@",  [@[@1,@2,@3,@4,@5] dropByPredicate:^BOOL(id  _Nonnull obj, NSUInteger idx) {
        return idx % 2 == 0;
    }]);
}

- (void)testTake {
    NSLog(@"--%@",  [@[@1,@2,@3,@4,@5] take:-1]);
    NSLog(@"--%@",  [@[@1,@2,@3,@4,@5] take:0]);
    NSLog(@"--%@",  [@[@1,@2,@3,@4,@5] take:2]);
    NSLog(@"--%@",  [@[@1,@2,@3,@4,@5] take:10]);
    NSLog(@"--%@",  [@[@1,@2,@3,@4,@5] takeRight:-1]);
    NSLog(@"--%@",  [@[@1,@2,@3,@4,@5] takeRight:0]);
    NSLog(@"--%@",  [@[@1,@2,@3,@4,@5] takeRight:2]);
    NSLog(@"--%@",  [@[@1,@2,@3,@4,@5] takeRight:5]);
    NSLog(@"--%@",  [@[@1,@2,@3,@4,@5] takeRight:10]);
    NSLog(@"--%@",  [@[@1,@2,@3,@4,@5] takeByPredicate:^BOOL(id  _Nonnull obj, NSUInteger idx) {
        return idx % 2 == 0;
    }]);

}

- (void)testSafety {
    NSLog(@"--%@",  [@[@1,@2,@3,@4,@5] safetyObjectAtIndex:-1]);
    NSLog(@"--%@",  [@[@1,@2,@3,@4,@5] safetyObjectAtIndex:-15]);
    NSLog(@"--%@",  [@[@1,@2,@3,@4,@5] safetyObjectAtIndex:1]);
    NSLog(@"--%@",  [@[@1,@2,@3,@4,@5] safetyObjectAtIndex:100]);

}

- (void)testRemove {
    NSLog(@"-->%@",  [@[@1,@2,@3,@4,@5] removeByPredicate:^BOOL(id  _Nonnull obj, NSUInteger idx) {
        return idx % 2 == 0;
    }]);
    NSLog(@"-->%@",  [@[@1,@2,@3,@4,@5] removeByPredicate:^BOOL(id  _Nonnull obj, NSUInteger idx) {
        return [obj intValue] == 3;
    }]);

}

- (void)testReverse {
    NSLog(@"--%@",  [@[@1,@2,@3,@4,@5] reverse]);
}

- (void)testUniq {
    NSLog(@"--%@",  [@[@1,@2,@3,@4,@5, @2, @3] unique]);

}

- (void)testNSMutableArray {
    NSMutableArray *array0 = [NSMutableArray array];
    NSMutableArray *array1 = [NSMutableArray arrayWithArray:@[@1]];
    NSMutableArray *array2 = [NSMutableArray arrayWithArray:@[@1,@2]];
    NSMutableArray *array3 = [NSMutableArray arrayWithArray:@[@1,@2,@3]];
    NSMutableArray *array4 = [NSMutableArray arrayWithArray:@[@1,@2,@3,@4]];
    NSMutableArray *array4Tem = [NSMutableArray arrayWithArray:@[@1,@2,@3,@4, @5]];
    
//    [array4 chunk:-1]; NSLog(@"---%@", [array4 modelToJSONString]);
//    [array4 chunk:1]; NSLog(@"---%@", [array4 modelToJSONString]);
//    [array4 chunk:2]; NSLog(@"---%@", [array4 modelToJSONString]);
//    [array4 chunk:12]; NSLog(@"---%@", [array4 modelToJSONString]);
    
    NSMutableArray *array5 = [NSMutableArray arrayWithArray:@[@0, @1, @"", @" ", [NSNull null], @YES, @NO]];
    [array5 compact]; NSLog(@"---%@", [array5 modelToJSONString]);

    [array4 dropRight:2]; NSLog(@"---%@", [array4 modelToJSONString]);

    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end

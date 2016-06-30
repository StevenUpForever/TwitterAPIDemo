//
//  TwitterAPIDemoTests.m
//  TwitterAPIDemoTests
//
//  Created by Chengzhi Jia on 6/28/16.
//  Copyright © 2016 ChengzhiJia. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TwitterStreamingManager.h"
#import "MainViewModel.h"

@interface TwitterAPIDemoTests : XCTestCase

@property (nonatomic) MainViewModel *mainViewModel;

@end

@implementation TwitterAPIDemoTests

- (void)setUp {
    [super setUp];
    self.mainViewModel = [[MainViewModel alloc]init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
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

- (void)testSingleton {
    XCTAssertEqualObjects([TwitterStreamingManager sharedManager], [TwitterStreamingManager sharedManager], @"Two object should be the same memory address");
}

- (void)testConfigurationValidation {
    [self.mainViewModel createStreamingManagerConfigurationWithSourceTitle:@"Public API with Samples" follow:nil track:@"test" locations:nil];
    TwitterStreamingManager *sharedManager = [TwitterStreamingManager sharedManager];
    XCTAssertNotNil(sharedManager.configuration, @"After setup, configuration shouldn't be nil");
    XCTAssertNotNil([sharedManager.configuration createURLRequest], @"URL requet should be valid");
    XCTAssertTrue([[sharedManager.configuration createURLRequest] isKindOfClass:[NSURLRequest class]], @"configuration request should be kind of NSURLRequest");
}



@end

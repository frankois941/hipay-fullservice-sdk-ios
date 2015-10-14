//
//  HPTAbstractSerializationMapperTests.m
//  HiPayTPP
//
//  Created by Jonathan TIRET on 14/10/2015.
//  Copyright © 2015 Jonathan TIRET. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <HiPayTPP/HPTAbstractSerializationMapper+Encode.h>

@interface HPTAbstractSerializationMapperTests : XCTestCase
{
    OCMockObject *mockedRequest;
    HPTAbstractSerializationMapper *mapper;
}

@end

@implementation HPTAbstractSerializationMapperTests

- (void)setUp {
    [super setUp];

    mockedRequest = [OCMockObject mockForClass:[NSObject class]];
    mapper = [HPTAbstractSerializationMapper mapperWithRequest:mockedRequest];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInit {
    XCTAssertEqual(mapper.request, mockedRequest);
}

- (void)testInitNil {
    XCTAssertNil([HPTAbstractSerializationMapper mapperWithRequest:nil]);
}

- (void)testShouldSuclass {
    XCTAssertThrows(mapper.serializedRequest);
}

- (void)testGetURLValues
{
    [[[mockedRequest expect] andReturn:[NSURL URLWithString:@"http://www.example.com/forward/ok"]] valueForKey:@"test1"];
    [[[mockedRequest expect] andReturn:nil] valueForKey:@"test2"];
    [[[mockedRequest expect] andReturn:@"hello"] valueForKey:@"test3"];
    
    XCTAssertEqualObjects([mapper getURLForKeyPath:@"test1"], @"http://www.example.com/forward/ok");
    XCTAssertNil([mapper getURLForKeyPath:@"test2"]);
    XCTAssertNil([mapper getURLForKeyPath:@"test3"]);
}

- (void)testIntegerValues
{
    [[[mockedRequest expect] andReturn:@(45)] valueForKey:@"test1"];
    [[[mockedRequest expect] andReturn:@(45.125457)] valueForKey:@"test2"];
    [[[mockedRequest expect] andReturn:@(45.125457)] valueForKey:@"test3"];
    [[[mockedRequest expect] andReturn:@"hello"] valueForKey:@"test4"];
    [[[mockedRequest expect] andReturn:nil] valueForKey:@"test5"];
    
    XCTAssertEqualObjects([mapper getIntegerForKeyPath:@"test1"], @"45");
    XCTAssertEqualObjects([mapper getIntegerForKeyPath:@"test2"], @"45");
    XCTAssertEqualObjects([mapper getIntegerForKeyPath:@"test3"], @"45");
    XCTAssertNil([mapper getIntegerForKeyPath:@"test4"]);
    XCTAssertNil([mapper getIntegerForKeyPath:@"test5"]);
}

@end

//
//  CSPrettyPrintedTests.m
//  CSPrettyPrintedTests
//
//  Created by Joslyn Wu on 2018/2/5.
//  Copyright © 2018年 Joslyn Wu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CSPrettyPrinted.h"

@interface CSSimpleSubModel : NSObject
@property (nonatomic, copy) NSString *subName;
@property (nonatomic, copy) NSString *subUid;
@property (nonatomic, copy) NSString *subSummary;
@end

@implementation CSSimpleSubModel
@end

@interface CSSimpleModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, strong) CSSimpleSubModel *subModel;
@end

@implementation CSSimpleModel
@end


@interface CSPrettyPrintedTests : XCTestCase

@property (nonatomic, strong) NSSet *set;
@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, strong) NSDictionary *typeDict;

@end

@implementation CSPrettyPrintedTests

- (void)setUp {
    [super setUp];
    
    NSString *itemDictStr = @"{\"url\": \"ddd\", \"title\": \"2子标题\"}";
    NSString *itemNormalStr = @"normal 普通";
    NSData *itemData = [itemNormalStr dataUsingEncoding:NSUTF8StringEncoding];
    NSNull *null = [NSNull null];
    NSNumber *numb = @(2222);
    NSValue *value = [NSValue valueWithCGSize:CGSizeMake(50, 50)];
    NSDate *date = [NSDate date];
    NSArray *arr1 = @[@"1item1", @"1元素2", @"1item3"];
    NSDictionary *subDict2 = @{@"url": @"https://baidu.com", @"title": @"2子标题"};
    NSSet *set = [NSSet setWithObjects:@"11", @"22", @"set 中文", subDict2, arr1, nil];
    CSSimpleModel *obj = [CSSimpleModel new];
    NSDictionary *subDict1 = @{@"url": @"https://baidu.com", @"title": @"1子标题", @"sub2": subDict2, @"sub22": subDict2};
    NSArray *arr = @[@"item1", @"元素2", @"item3", numb, null, subDict1, arr1];
    NSDictionary *subDict0 = @{@"url": @"https://baidu.com", @"title": @"0子标题", @"sub1": subDict1, @"arr": arr, @"set": set};
    NSDictionary *dict = @{@"name": @"aaa", @"summary": @"摘要", @"sub": subDict0, @"arr": arr,
                           @"numb": numb, @"null": null, @"normalStr": itemNormalStr, @"itemData": itemData,
                           @"itemDictStr": itemDictStr, @"obj": obj, @"value": value, @"date": date, @"set": set};
    NSDictionary *typeDict = @{@"name": @"aaa", @"summary": @"摘要", @"sub": subDict2, @"arr": arr1,
                               @"numb": numb, @"null": null, @"normalStr": itemNormalStr, @"itemData": itemData,
                               @"itemDictStr": itemDictStr, @"obj": obj, @"value": value, @"date": date, @"set": set};
    self.typeDict = typeDict;
    self.dict = dict;
    self.arr = arr;
    self.set = set;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDictToString {
    NSLog(@"---->\n%@", self.typeDict.cs_toSting);
}


@end

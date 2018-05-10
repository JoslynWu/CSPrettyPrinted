//
//  CSSPrettyPrintedTests.m
//  CSSPrettyPrintedTests
//
//  Created by Joslyn Wu on 2018/2/5.
//  Copyright © 2018年 Joslyn Wu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CSSPrettyPrinted.h"

@interface CSSSimpleSubModel : NSObject
@property (nonatomic, copy) NSString *subName;
@property (nonatomic, copy) NSString *subUid;
@property (nonatomic, copy) NSString *subSummary;
@end

@implementation CSSSimpleSubModel
@end

@interface CSSSimpleModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, strong) CSSSimpleSubModel *subModel;
@end

@implementation CSSSimpleModel
@end


@interface CSSPrettyPrintedTests : XCTestCase

@property (nonatomic, strong) NSSet *set;
@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, strong) NSDictionary *typeDict;
@property (nonatomic, strong) CSSSimpleModel *modelObject;

@end

@implementation CSSPrettyPrintedTests

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
    NSDictionary *subDict2 = @{@"url": @"https://www.baidu.com", @"title": @"2子标题"};
    NSSet *set = [NSSet setWithObjects:@"11", @"22", @"set 中文", subDict2, arr1, nil];
    
    CSSSimpleModel *obj = [CSSSimpleModel new];
    obj.name = @"obj name";
    obj.summary = @"obj summary";
    obj.uid = @"334";
    CSSSimpleSubModel *subObj = [CSSSimpleSubModel new];
    subObj.subName = @"sub 名称";
    subObj.subSummary = @"sub obj 描述";
    subObj.subUid = @"334";
    obj.subModel = subObj;
    self.modelObject = obj;
    
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
    
    [super tearDown];
}

- (void)testDictionaryToDebugSting {
    NSString *debgugStr = self.typeDict.css_debugSting;
    XCTAssertTrue([debgugStr containsString:@"summary"]);
    XCTAssertTrue([debgugStr containsString:@"摘要"]);
    XCTAssertTrue([debgugStr containsString:@"itemDictStr"]);
    XCTAssertTrue([debgugStr containsString:@"{\"url\": \"ddd\", \"title\": \"2子标题\"}"]);
    
    NSLog(@"--Dictionary-->\n%@", debgugStr);
}

- (void)testArrayToDebugSting {
    NSString *debgugStr = self.arr.css_debugSting;
    XCTAssertTrue([debgugStr containsString:@"item1"]);
    XCTAssertTrue([debgugStr containsString:@"元素2"]);
    XCTAssertTrue([debgugStr containsString:@"<null>"]);
    XCTAssertTrue([debgugStr containsString:@"1元素2"]);
    
    NSLog(@"--Array-->\n%@", debgugStr);
}

- (void)testSetToDebugSting {
    NSString *debgugStr = self.set.css_debugSting;
    XCTAssertTrue([debgugStr containsString:@"11"]);
    XCTAssertTrue([debgugStr containsString:@"22"]);
    XCTAssertTrue([debgugStr containsString:@"set 中文"]);
    XCTAssertTrue([debgugStr containsString:@"https://www.baidu.com"]);
    
    NSLog(@"--Set-->\n%@", debgugStr);
}

- (void)testYYModelToDebugSting {
    // 如果只使用YYModel、MJExtension和CSSModel中一个，则无需指定
    NSObject.css_customToJsonObjectSelector = NSSelectorFromString(@"yy_modelToJSONObject");
    NSString *debgugStr = self.modelObject.css_debugSting;
    XCTAssertTrue([debgugStr containsString:@"summary"]);
    XCTAssertTrue([debgugStr containsString:@"obj summary"]);
    XCTAssertTrue([debgugStr containsString:@"subSummary"]);
    XCTAssertTrue([debgugStr containsString:@"sub obj 描述"]);
    XCTAssertTrue([debgugStr containsString:@"subUid"]);
    XCTAssertTrue([debgugStr containsString:@"334"]);
    
    NSLog(@"--YYModel-->\n%@", debgugStr);
}

- (void)testMJExtensionToDebugSting {
    // 如果只使用YYModel、MJExtension和CSSModel中一个，则无需指定
    NSObject.css_customToJsonObjectSelector = NSSelectorFromString(@"mj_JSONObject");
    NSString *debgugStr = self.modelObject.css_debugSting;
    XCTAssertTrue([debgugStr containsString:@"summary"]);
    XCTAssertTrue([debgugStr containsString:@"obj summary"]);
    XCTAssertTrue([debgugStr containsString:@"subSummary"]);
    XCTAssertTrue([debgugStr containsString:@"sub obj 描述"]);
    XCTAssertTrue([debgugStr containsString:@"subUid"]);
    XCTAssertTrue([debgugStr containsString:@"334"]);
    
    NSLog(@"--MJExtension-->\n%@", debgugStr);
}

- (void)testCSSModelToDebugSting {
    // 如果只使用YYModel、MJExtension和CSSModel中一个，则无需指定
    NSObject.css_customToJsonObjectSelector = NSSelectorFromString(@"css_JSONObject");
    NSString *debgugStr = self.modelObject.css_debugSting;
    XCTAssertTrue([debgugStr containsString:@"summary"]);
    XCTAssertTrue([debgugStr containsString:@"obj summary"]);
    XCTAssertTrue([debgugStr containsString:@"subSummary"]);
    XCTAssertTrue([debgugStr containsString:@"sub obj 描述"]);
    XCTAssertTrue([debgugStr containsString:@"subUid"]);
    XCTAssertTrue([debgugStr containsString:@"334"]);
    
    NSLog(@"--CSSModel-->\n%@", debgugStr);
}

// %@的打印测试
//- (void)testNormal {
//    NSLog(@"---->arr:\n%@, \nset:\n%@, \ndict:\n%@, \nobjcet:\n%@", self.arr, self.set, self.dict, self.modelObject);
//}

@end

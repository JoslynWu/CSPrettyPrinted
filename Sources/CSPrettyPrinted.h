//
//  CSPrettyPrinted.h
//  CSPrettyPrinted
//
//  Created by Joslyn Wu on 2018/2/2.
//  Copyright © 2018年 joslyn. All rights reserved.
//
// https://github.com/JoslynWu/CSPrettyPrinted
// 

#import <Foundation/Foundation.h>


@interface NSDictionary (CSPrettyPrinted)

@property (nonatomic, strong, readonly) NSString *cs_toSting;

@end


@interface NSArray (CSPrettyPrinted)

@property (nonatomic, strong, readonly) NSString *cs_toSting;

@end


@interface NSSet (CSPrettyPrinted)

@property (nonatomic, strong, readonly) NSString *cs_toSting;

@end

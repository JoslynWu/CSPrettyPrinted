//
//  CSPrettyPrinted.m
//  CSPrettyPrinted
//
//  Created by Joslyn Wu on 2018/2/2.
//  Copyright © 2018年 joslyn. All rights reserved.
//
// https://github.com/JoslynWu/CSPrettyPrinted
//

#import "CSPrettyPrinted.h"

@implementation NSObject (CSPrettyPrinted)

+ (NSString *)_cs_toStringForSequence:(NSObject *)data {
    return [self _cs_stringForSequence:data indentLevel:1 wrap:YES];
}

+ (NSString *)_cs_stringForSequence:(NSObject *)data indentLevel:(NSInteger)level wrap:(BOOL)wrap {
    NSString *endSymbol = @"";
    NSArray *sequence;
    NSString *startSymbol = @"";
    if ([data isKindOfClass:[NSArray class]]) {
        startSymbol = @"[";
        endSymbol = @"]";
        sequence = (NSArray *)data;
    } else if ([data isKindOfClass:[NSSet class]]) {
        startSymbol = @"(";
        endSymbol = @")";
        sequence = ((NSSet *)data).allObjects;
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        startSymbol = @"{";
        endSymbol = @"}";
        sequence = ((NSDictionary *)data).allValues;
    } else {
        return nil;
    }
    NSString *indent = [self _cs_placeholder:@" " tag:@"." base:4 repeat:level level:level];
    NSString *endIndent = [self _cs_placeholder:@" " tag:@"." base:4 repeat:level - 1 level:level - 1];
    NSString *wrapStr = [NSString stringWithFormat:@"%@%@", (wrap ? @"\n" : @""), (wrap ? indent : @"")];
    if (![data isKindOfClass:[NSDictionary class]]) {
        wrapStr = @"";
    }
    NSMutableString *result = [NSMutableString stringWithFormat:@"%@\n", startSymbol];
    for (NSInteger i = 0; i < sequence.count; i++) {
        NSString *key = @"";
        if ([data isKindOfClass:[NSDictionary class]]) {
            key = [NSString stringWithFormat:@"%@ = ",[((NSDictionary *)data).allKeys objectAtIndex:i]];
        }
        NSString *obj = [sequence objectAtIndex:i];
        if ([obj isKindOfClass:[NSArray class]]) {
            [result appendFormat:@"%@%@%@%@", indent, key, wrapStr, [self _cs_stringForSequence:obj indentLevel:level + 1 wrap:wrap]];
            continue;
        }
        if ([obj isKindOfClass:[NSSet class]]) {
            [result appendFormat:@"%@%@%@%@", indent, key, wrapStr,  [self _cs_stringForSequence:obj indentLevel:level + 1 wrap:wrap]];
            continue;
        }
        if ([obj isKindOfClass:[NSDictionary class]]) {
            [result appendFormat:@"%@%@%@%@", indent, key, wrapStr, [self _cs_stringForSequence:(NSDictionary *)obj indentLevel:level + 1 wrap:wrap]];
            continue;
        }
        NSString *objStr = ([obj isKindOfClass:[NSString class]] ? [NSString stringWithFormat:@"\"%@\"", obj] : obj.description);
        [result appendFormat:@"%@%@%@%@\n", indent, key, objStr, (i + 1 == sequence.count ? @"" : @",")];
    }
    [result appendFormat:@"%@%@\n", endIndent, endSymbol];
    
    return result;
}

+ (NSString *)_cs_placeholder:(NSString *)symbol tag:(NSString *)tag base:(NSInteger)n repeat:(NSInteger)repeat level:(NSInteger)level {
    if (n <= 0 ) {
        return @"";
    }
    
    if (repeat <= 0) {
        return @"";
    }
    
    if (symbol.length <= 0) {
        return @"";
    }
    
    if (tag.length <= 0) {
        tag = symbol;
    }
    
    NSMutableString *result = [NSMutableString string];
    NSMutableString *baseStr = [NSMutableString string];
    for (NSInteger i = 0; i < n; i++) {
        [baseStr appendString:symbol];
    }
    
    for (NSInteger i = 0; i < repeat; i++) {
        [result appendString:baseStr];
    }
    
    for (NSInteger i = 0; i < level; i++) {
        [result replaceOccurrencesOfString:symbol withString:tag options:NSCaseInsensitiveSearch range:NSMakeRange(n * i, 1)];
    }
    return result;
}

- (NSString *)_cs_debugDescription {
    return [NSString stringWithFormat:@"<%@: %p>\n%@",NSStringFromClass([self class]), self, [NSObject _cs_toStringForSequence:self]];
}

@end


@implementation NSDictionary (CSPrettyPrinted)

- (NSString *)cs_toSting {
    return [NSObject _cs_toStringForSequence:self];
}

- (NSString *)debugDescription {
    return [self _cs_debugDescription];
}

@end


@implementation NSArray (CSPrettyPrinted)

- (NSString *)cs_toSting {
    return [NSObject _cs_toStringForSequence:self];
}

- (NSString *)debugDescription {
    return [self _cs_debugDescription];
}

@end


@implementation NSSet (CSPrettyPrinted)

- (NSString *)cs_toSting {
    return [NSObject _cs_toStringForSequence:self];
}

- (NSString *)debugDescription {
    return [self _cs_debugDescription];
}

@end


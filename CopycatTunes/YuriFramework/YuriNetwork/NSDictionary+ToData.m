//
//  NSDictionary+ToData.m
//  Request
//
//  Created by 武国斌 on 2017/4/8.
//  Copyright © 2017年 武国斌. All rights reserved.
//

#import "NSDictionary+ToData.h"

@implementation NSDictionary (ToData)

- (NSData *)toData {
    NSMutableString *temp = [NSMutableString string];
    NSArray *allkeys = [self allKeys];
    if (allkeys.count) {
        for (NSString *key in allkeys) {
            [temp appendString:key];
            [temp appendString:@"="];
            [temp appendString:[self objectForKey:key]];
            [temp appendString:@"&"];
        }
    }
    
    NSInteger count = temp.length;
    NSString *result = [temp substringToIndex:count - 1];
    
    return [result dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];;
}

@end

//
//  YuriNetwork6.h
//  Request
//
//  Created by 武国斌 on 2017/4/8.
//  Copyright © 2017年 武国斌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YuriNetwork6 : NSObject

- (void)resuestWithURL:(NSString *)url andMethod:(NSString *)method andParams:(NSDictionary *)params andSucceed:(void (^)(NSDictionary *dictionary))succeed andFailure:(void (^)(NSError *error))failure;

@end

//
//  YuriNetwork7.h
//  Request
//
//  Created by 武国斌 on 2017/4/8.
//  Copyright © 2017年 武国斌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YuriNetwork7 : NSObject

- (void)requestWithURL:(NSString *)url andMethod:(NSString *)method andParams:(NSDictionary *)params andSucceed:(void (^)(NSDictionary *dictionary))succeed andFailure:(void (^)(NSError *error))failure;

@end

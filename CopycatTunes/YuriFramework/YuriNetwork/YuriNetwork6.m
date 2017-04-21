//
//  YuriNetwork6.m
//  Request
//
//  Created by 武国斌 on 2017/4/8.
//  Copyright © 2017年 武国斌. All rights reserved.
//

#import "YuriNetwork6.h"
#import "NSDictionary+ToData.h"

@implementation YuriNetwork6

- (void)resuestWithURL:(NSString *)url andMethod:(NSString *)method andParams:(NSDictionary *)params andSucceed:(void (^)(NSDictionary *dictionary))succeed andFailure:(void (^)(NSError *error))failure {
    
    NSData *postData = [params toData];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", [postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:method];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        if (connectionError) {
            failure(connectionError);
        }else {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                succeed(dic);
            });
        }
    }];
}

@end

//
//  BaseClass.h
//
//  Created by   on 2017/4/15
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QQData;

@interface QQBaseClass : CSJSONModel

@property (nonatomic, copy) NSString *notice;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, strong) QQData *data;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *subcode;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *tips;

- (NSArray *)tracks;

@end

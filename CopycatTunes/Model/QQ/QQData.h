//
//  Data.h
//
//  Created by   on 2017/4/15
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QQZhida, QQSemantic, QQSong;

@interface QQData : CSJSONModel

@property (nonatomic, strong) QQZhida *zhida;
@property (nonatomic, copy) NSString *totaltime;
@property (nonatomic, strong) QQSemantic *semantic;
@property (nonatomic, copy) NSString *keyword;
@property (nonatomic, strong) NSArray *qc;
@property (nonatomic, strong) QQSong *song;
@property (nonatomic, copy) NSString *priority;

@end

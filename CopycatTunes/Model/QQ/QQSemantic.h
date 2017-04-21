//
//  Semantic.h
//
//  Created by   on 2017/4/15
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQSemantic : CSJSONModel

@property (nonatomic, copy) NSString *curnum;
@property (nonatomic, copy) NSString *totalnum;
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, copy) NSString *curpage;

@end

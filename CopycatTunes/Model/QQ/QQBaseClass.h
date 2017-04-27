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


/*
 NSString *api = @"http://s.music.qq.com/fcgi-bin/music_search_new_platform";
 NSDictionary *params = @{@"t":@"0",
 @"n":@"20",//数量
 @"p":self.page,//分页
 @"aggr":@"1",
 @"cr":@"1",
 @"loginUin":@"0",
 @"format":@"json",
 @"inCharset":@"GB2312",
 @"outCharset":@"utf-8",
 @"notice":@"0",
 @"platform":@"jqminiframe.json",
 @"needNewCode":@"0",
 @"catZhida":@"0",
 @"remoteplace":@"sizer.newclient.next_song",
 @"w":self.term};
 */

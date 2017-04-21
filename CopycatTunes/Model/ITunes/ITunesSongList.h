//
//  BaseClass.h
//
//  Created by   on 2017/4/13
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ITunesSong;

@protocol ITunesSong @end

@interface ITunesSongList : CSJSONModel

@property (nonatomic, strong) NSArray<ITunesSong> *results;
@property (nonatomic, assign) double resultCount;

- (NSArray *)tracks;

@end

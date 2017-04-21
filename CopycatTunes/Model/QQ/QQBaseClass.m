//
//  BaseClass.m
//
//  Created by   on 2017/4/15
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "QQBaseClass.h"
#import "QQData.h"

#import "QQSong.h"
#import "QQList.h"

@implementation QQBaseClass

- (NSArray *)tracks {
    
    NSMutableArray *array = [NSMutableArray array];
    NSArray *list = self.data.song.list;
    for (QQList *qqList in list) {
        [array addObject:[qqList getTrack]];
    }
    return array;
}

@end

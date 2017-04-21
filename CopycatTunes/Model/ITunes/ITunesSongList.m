//
//  BaseClass.m
//
//  Created by   on 2017/4/13
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "ITunesSongList.h"
#import "ITunesSong.h"

@interface ITunesSongList ()

@end

@implementation ITunesSongList

- (NSArray *)tracks {
    NSMutableArray *array = [NSMutableArray array];
    for (ITunesSong *song in self.results) {
        [array addObject:[song getTrack]];
    }
    return array;
}

@end

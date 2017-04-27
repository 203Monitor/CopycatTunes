//
//  Track+isPlaying.m
//  CopycatTunes
//
//  Created by 武国斌 on 2017/4/27.
//  Copyright © 2017年 武国斌. All rights reserved.
//

#import "Track+isPlaying.h"

@implementation Track (isPlaying)

- (BOOL)isPlaying {
    return [[[kAppDelegate audioUtil] trackId] isEqualToString:self.trackId];
}

@end

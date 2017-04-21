//
//  Track.h
//  HalfTunes
//
//  Created by 武国斌 on 2017/4/13.
//  Copyright © 2017年 武国斌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DOUAudioFile.h"

@interface Track : NSObject <DOUAudioFile>

@property (nonatomic, copy) NSString *artist;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *trackId;
@property (nonatomic, copy) NSURL *preCover;
@property (nonatomic, copy) NSURL *cover;
@property (nonatomic, copy) NSURL *audioFileURL;

- (BOOL)isNowPlaying;

@end

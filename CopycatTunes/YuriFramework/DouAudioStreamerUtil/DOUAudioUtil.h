//
//  DOUAudioUtil.h
//  HalfTunes
//
//  Created by 武国斌 on 2017/4/14.
//  Copyright © 2017年 武国斌. All rights reserved.
//

#import <DOUAudioStreamer/DOUAudioStreamer.h>

typedef void(^CallBack)(id obj);

@interface DOUAudioUtil : NSObject

@property (nonatomic, copy) void(^playingCallBack)(id obj);
@property (nonatomic, copy) void(^startCallBack)(id obj);
@property (nonatomic, copy) void(^finishCallBack)(id obj);

- (void)playWithTrack:(id <DOUAudioFile>)track;
- (void)play;
- (void)pause;
- (void)stop;

- (void)seek:(NSTimeInterval)timeInterval;

- (NSString *)duration;
- (NSString *)currentTime;
- (NSString *)trackId;

- (void)download;

@end

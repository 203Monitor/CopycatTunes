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
@property (nonatomic, copy) void(^pauseCallBack)(id obj);
@property (nonatomic, copy) void(^finishCallBack)(id obj);

- (void)setFinishCallBack:(void (^)(id obj))finishCallBack;
- (void)setPlayingCallBack:(void (^)(id obj))playingCallBack;
- (void)setPauseCallBack:(void (^)(id obj))pauseCallBack;

- (void)playWithTrack:(id <DOUAudioFile>)track;
- (void)play;
- (void)pause;
- (void)stop;

- (void)seek:(NSTimeInterval)timeInterval;

- (BOOL)isPlaying;

- (NSString *)duration;
- (NSString *)currentTime;
- (double)progress;
- (NSString *)trackId;

- (void)download;

@end

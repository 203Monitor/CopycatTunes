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
- (void)setFinishCallBack:(void (^)(id obj))finishCallBack;

@property (nonatomic, copy) void(^pauseCallBack)(id obj);
- (void)setPlayingCallBack:(void (^)(id obj))playingCallBack;

@property (nonatomic, copy) void(^finishCallBack)(id obj);
- (void)setPauseCallBack:(void (^)(id obj))pauseCallBack;

@property (nonatomic, copy) void(^downloadingCallBack)(float downloadPrecent);
- (void)setDownloadingCallBack:(void (^)(float downloadPrecent))downloadingCallBack;

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
